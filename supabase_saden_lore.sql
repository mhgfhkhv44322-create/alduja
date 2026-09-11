insert into public.lore_character_knowledge
(lore_id, character_id, knowledge_level, reveal_style)

select lk.id, c.id, x.knowledge_level, x.reveal_style
from public.lore_knowledge lk
join public.characters c
  on c.name = 'سادن بن راشد'
join (
  values
  ('في إرم، يتناقل بعض الناس أن ليلةً واحدة غيّرت أشياء كثيرة، لكن لا أحد يتفق على ما حدث فيها.', 'partial', 'hint'),
  ('يقال إن بوابة المدينة الشرقية أُغلقت قبل موعدها في ليلة غريبة، ولم يعرف الناس السبب.', 'known', 'direct'),
  ('انتشرت حكاية عن نار ظهرت قرب مخزن قديم ثم انطفأت بطريقة لم يفهمها أحد.', 'partial', 'fragment'),
  ('تختلف الروايات حول قافلة مرت قرب إرم في تلك الليلة؛ بعضهم ذكر سبعة أشخاص، وآخرون أقسموا أنهم كانوا تسعة.', 'known', 'question'),
  ('هناك من يتذكر ثلاثة صناديق كانت مع القافلة، لكن لا أحد يتفق على ما كان بداخلها.', 'partial', 'riddle'),
  ('في سجل قديم لإرم، يوجد موضع يبدو أن اسمًا أُزيل منه بعناية، بينما بقيت الكتابة حوله.', 'known', 'direct'),
  ('وصلت رسالة مجهولة بعد ليلة الرماد، ولم يكن واضحًا لمن كُتبت ولا من تركها.', 'partial', 'hint')
) as x(knowledge_text, knowledge_level, reveal_style)
on lk.knowledge_text = x.knowledge_text
on conflict do nothing;

