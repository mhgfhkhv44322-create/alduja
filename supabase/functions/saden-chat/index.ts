import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
};

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const body = await req.json();

    const characterId = body.character_id;
    const userMessage = String(body.message ?? "").trim();

    if (!characterId || !userMessage) {
      return new Response(
        JSON.stringify({ error: "بيانات المحادثة ناقصة" }),
        {
          status: 400,
          headers: {
            ...corsHeaders,
            "Content-Type": "application/json",
          },
        },
      );
    }

    const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
    const serviceRoleKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;

    const supabase = createClient(
      supabaseUrl,
      serviceRoleKey,
    );

    const { data: character, error: characterError } =
      await supabase
        .from("characters")
        .select("id, name, title, description")
        .eq("id", characterId)
        .single();

    if (characterError || !character) {
      throw new Error("الشخصية غير موجودة");
    }

    const { data: memories } = await supabase
      .from("character_memory")
      .select("memory_type, memory_text, importance")
      .eq("character_id", characterId)
      .is("user_id", null)
      .order("importance", { ascending: false });

    const { data: knowledge } = await supabase
      .from("lore_character_knowledge")
      .select(`
        knowledge_level,
        reveal_style,
        lore_knowledge (
          knowledge_type,
          knowledge_text,
          difficulty
        )
      `)
      .eq("character_id", characterId);

    const context = {
      character,
      memories: memories ?? [],
      knowledge: knowledge ?? [],
    };

    /*
      هنا لاحقاً نرسل:
      character + memories + knowledge + conversation
      إلى مزود الـAI.

      لا نضع أي API key داخل Flutter.
    */

    return new Response(
      JSON.stringify({
        ok: true,
        character: character.name,
        context_ready: true,
        context,
        message: userMessage,
      }),
      {
        status: 200,
        headers: {
          ...corsHeaders,
          "Content-Type": "application/json",
        },
      },
    );
  } catch (error) {
    return new Response(
      JSON.stringify({
        error: error instanceof Error
          ? error.message
          : "حدث خطأ غير معروف",
      }),
      {
        status: 500,
        headers: {
          ...corsHeaders,
          "Content-Type": "application/json",
        },
      },
    );
  }
});
