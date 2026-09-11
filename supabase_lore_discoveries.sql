insert into public.lore_discoveries
(lore_id, discovery_key, discovery_title, discovery_description, required_fragments)
select
  lk.id,
  x.discovery_key,
  x.discovery_title,
  x.discovery_description,
  x.required_fragments
from public.lore_knowledge lk
join (
  values
  ('night_of_ash',
   'ليلة الرماد',
   'ليلة غامضة غيّرت شيئًا في إرم، لكن حقيقتها لم تُجمع بعد.',
   3),
  ('missing_caravan',
   'القافلة المفقودة',
   'قافلة اختلف الناس في عدد رجالها وصناديقها، ولم يُحسم ما إذا كانت دخلت إرم أصلًا.',
   3),
  ('erased_record',
   'الاسم الممحُو',
   'سجل قديم يخفي أثر اسم أزيل بعناية من تاريخ المدينة.',
   2),
  ('unknown_letter',
   'الرسالة المجهولة',
   'رسالة ظهرت بعد ليلة غريبة، وما زال صاحبها والمقصود بها مجهولين.',
   2)
) as x(discovery_key, discovery_title, discovery_description, required_fragments)
on lk.knowledge_text ilike
  case x.discovery_key
    when 'night_of_ash' then '%ليلة%'
    when 'missing_caravan' then '%قافلة%'
    when 'erased_record' then '%سجل%'
    when 'unknown_letter' then '%رسالة%'
  end
where not exists (
  select 1
  from public.lore_discoveries d
  where d.discovery_key = x.discovery_key
);
