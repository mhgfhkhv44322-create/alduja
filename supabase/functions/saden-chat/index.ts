const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

const SUPABASE_URL = Deno.env.get("SUPABASE_URL")!;
const SUPABASE_ANON_KEY = Deno.env.get("SUPABASE_ANON_KEY")!;
const SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
const GEMINI_API_KEY = Deno.env.get("ALDGA_API_KEY")!;

async function rest(path: string, options: RequestInit = {}) {
  return fetch(`${SUPABASE_URL}/rest/v1/${path}`, {
    ...options,
    headers: {
      apikey: SERVICE_ROLE_KEY,
      Authorization: `Bearer ${SERVICE_ROLE_KEY}`,
      "Content-Type": "application/json",
      ...(options.headers || {}),
    },
  });
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const authHeader = req.headers.get("Authorization");
    if (!authHeader?.startsWith("Bearer ")) {
      return new Response(
        JSON.stringify({ error: "Unauthorized" }),
        { status: 401, headers: { ...corsHeaders, "Content-Type": "application/json" } },
      );
    }

    const userToken = authHeader.replace("Bearer ", "");

    const userResponse = await fetch(`${SUPABASE_URL}/auth/v1/user`, {
      headers: {
        apikey: SUPABASE_ANON_KEY,
        Authorization: `Bearer ${userToken}`,
      },
    });

    if (!userResponse.ok) {
      return new Response(
        JSON.stringify({ error: "Invalid user session" }),
        { status: 401, headers: { ...corsHeaders, "Content-Type": "application/json" } },
      );
    }

    const user = await userResponse.json();
    const userId = user.id;

    const body = await req.json();
    const characterId = body.character_id;
    const message = String(body.message ?? "").trim();

    if (!characterId || !message) {
      return new Response(
        JSON.stringify({ error: "character_id and message are required" }),
        { status: 400, headers: { ...corsHeaders, "Content-Type": "application/json" } },
      );
    }

    if (message.length > 1000) {
      return new Response(
        JSON.stringify({ error: "Message too long" }),
        { status: 400, headers: { ...corsHeaders, "Content-Type": "application/json" } },
      );
    }

    const characterRes = await rest(
      `characters?id=eq.${encodeURIComponent(characterId)}&select=id,name,title,description`,
    );
    const characters = await characterRes.json();
    const character = characters?.[0];

    if (!character) {
      return new Response(
        JSON.stringify({ error: "Character not found" }),
        { status: 404, headers: { ...corsHeaders, "Content-Type": "application/json" } },
      );
    }

    const memoryRes = await rest(
      `character_memory?character_id=eq.${encodeURIComponent(characterId)}&user_id=is.null&select=memory_type,memory_text,importance&order=importance.desc`,
    );
    const memories = await memoryRes.json();

    const knowledgeRes = await rest(
      `lore_character_knowledge?character_id=eq.${encodeURIComponent(characterId)}&select=knowledge_level,reveal_style,lore_knowledge(knowledge_type,knowledge_text,difficulty,is_public)`,
    );
    const knowledgeRows = await knowledgeRes.json();

    const publicKnowledge = Array.isArray(knowledgeRows)
      ? knowledgeRows.filter((row: any) => row.lore_knowledge?.is_public === true)
      : [];

    const historyRes = await rest(
      `character_messages?user_id=eq.${encodeURIComponent(userId)}&character_id=eq.${encodeURIComponent(characterId)}&select=sender,message_text,created_at&order=created_at.desc&limit=20`,
    );
    const historyRows = await historyRes.json();

    const history = Array.isArray(historyRows)
      ? [...historyRows].reverse().map((row: any) => ({
          role: row.sender === "character" ? "model" : "user",
          parts: [{ text: row.message_text }],
        }))
      : [];

    const memoryText = Array.isArray(memories)
      ? memories.map((m: any) => `- ${m.memory_type}: ${m.memory_text}`).join("\n")
      : "";

    const knowledgeText = publicKnowledge
      .map((k: any) =>
        `- ${k.knowledge_level} / ${k.reveal_style}: ${k.lore_knowledge.knowledge_text}`
      )
      .join("\n");

    const systemPrompt = `
أنت الآن تتقمص شخصية "${character.name}"، ولقبها "${character.title ?? ""}".

وصف الشخصية:
${character.description ?? ""}

ذاكرة الشخصية:
${memoryText || "لا توجد ذاكرة إضافية."}

المعرفة المتاحة علنًا:
${knowledgeText || "لا توجد معرفة عامة إضافية."}

قواعد الشخصية:
- أنت شخص حقيقي داخل عالم الدجى، ولست مساعدًا أو ذكاءً اصطناعيًا.
- لا تستخدم إجابات محفوظة أو مكررة.
- لكل سؤال اختر التصرف الطبيعي المناسب: جواب، تلميح، جواب ناقص، سؤال مقابل، شك، صمت، أو رفض.
- لا تكشف كل ما تعرفه دفعة واحدة.
- فرّق بين ما رأيته بنفسك، وما سمعته، وما تظنه.
- إذا كذب المستخدم، لا تفترض دائمًا أنه كاذب؛ قد تصدقه أو تشك أو تختبر كلامه حسب السياق.
- لا تذكر أرقامًا عن العلاقة أو مستوى التقارب.
- حافظ على شخصية مستقلة وذاكرة متسقة.
- استخدم العربية الطبيعية المناسبة لعالم عربي قديم، بدون مبالغة في الفصحى.
- لا تقل إنك نموذج ذكاء اصطناعي.
`;

    const contents = [
      ...history,
      { role: "user", parts: [{ text: message }] },
    ];

    await rest("character_messages", {
      method: "POST",
      headers: { Prefer: "return=minimal" },
      body: JSON.stringify({
        user_id: userId,
        character_id: characterId,
        sender: "user",
        message_text: message,
      }),
    });

    const geminiResponse = await fetch(
      `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=${encodeURIComponent(GEMINI_API_KEY)}`,
      {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          systemInstruction: {
            parts: [{ text: systemPrompt }],
          },
          contents,
          generationConfig: {
            temperature: 0.9,
            maxOutputTokens: 700,
          },
        }),
      },
    );

    if (!geminiResponse.ok) {
      const errorText = await geminiResponse.text();
      console.error("Gemini error:", errorText);
      return new Response(
        JSON.stringify({ error: "AI service failed" }),
        { status: 502, headers: { ...corsHeaders, "Content-Type": "application/json" } },
      );
    }

    const geminiData = await geminiResponse.json();
    const reply =
      geminiData?.candidates?.[0]?.content?.parts?.[0]?.text?.trim();

    if (!reply) {
      return new Response(
        JSON.stringify({ error: "Empty AI response" }),
        { status: 502, headers: { ...corsHeaders, "Content-Type": "application/json" } },
      );
    }

    await rest("character_messages", {
      method: "POST",
      headers: { Prefer: "return=minimal" },
      body: JSON.stringify({
        user_id: userId,
        character_id: characterId,
        sender: "character",
        message_text: reply,
      }),
    });

    return new Response(
      JSON.stringify({
        ok: true,
        character: character.name,
        reply,
      }),
      {
        status: 200,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      },
    );
  } catch (error) {
    console.error("saden-chat error:", error);

    return new Response(
      JSON.stringify({ error: "Internal server error" }),
      {
        status: 500,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      },
    );
  }
});
