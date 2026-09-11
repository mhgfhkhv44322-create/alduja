insert into public.lore_knowledge
(city_id, knowledge_type, knowledge_text, source_name, difficulty, is_public)
select
  c.id,
  v.knowledge_type,
  v.knowledge_text,
  v.source_name,
  v.difficulty,
  false
from public.cities c
cross join (
  values
  ('history',
   'إرم أقدم مما يظن أهلها، ولا يوجد سجل واحد يتفق عليه الناس في أصل المدينة.',
   'حكاية الليلة التي لم تنتهِ', 2),
  ('rumor',
   'في ليلة الرماد أُغلق الباب الشرقي قبل موعده، ثم ظهرت أخبار متناقضة عن قافلة لم يتفق أحد على عدد رجالها.',
   'روايات أهل إرم', 2),
  ('mystery',
   'قيل إن القافلة حملت شيئًا أثقل من الذهب، شيئًا كان من شأنه أن يغيّر حكاية مدينة كاملة.',
   'أصداء قديمة', 4),
  ('record',
   'ظهر اسم في سجل قديم ثم مُحي بعناية، ولم يعرف الناس هل كان المحو لحماية شخص أم لإخفاء حدث.',
   'سجل المدينة القديم', 3),
  ('rumor',
   'بعد ليلة الرماد بدأ بعض أهل رملة يتحدثون عن تغير طفيف في طعم ماء البئر.',
   'أهل رملة', 2),
  ('mystery',
   'هناك طريق قديم يربط إرم بمناطق لا تظهر في الخرائط التي يتداولها أهل المدينة.',
   'مخطوط مجهول', 4),
  ('history',
   'اختفاء بعض المسافرين لم يكن دائمًا مرتبطًا باللصوص أو قطاع الطرق كما اعتاد الناس أن يفسروا.',
   'روايات القوافل', 3),
  ('rumor',
   'تنتشر في إرم حكاية عن امرأة تُرى أحيانًا عند البحر وأحيانًا في أزقة المدينة، ويختلف الناس حتى في اسمها.',
   'همس المدينة', 3),
  ('mystery',
   'بعض الروايات عن المرأة المسماة ابنة القمر تقول إنها ليست امرأة واحدة، لكن لا أحد يملك دليلاً واضحًا.',
   'رواية متناقلة', 5),
  ('mystery',
   'ما حدث في ليلة الرماد ربما كان نتيجة لشيء بدأ قبل تلك الليلة بسنوات طويلة.',
   'مرجع الدجى', 5)
) as v(knowledge_type, knowledge_text, source_name, difficulty)
where c.name = 'إرم';

insert into public.lore_character_knowledge
(lore_id, character_id, knowledge_level, reveal_style)
select
  lk.id,
  ch.id,
  x.knowledge_level,
  x.reveal_style
from public.lore_knowledge lk
join public.characters ch on ch.name = 'سادن بن راشد'
cross join lateral (
  select
    case
      when lk.knowledge_type = 'mystery' then 'partial'
      when lk.knowledge_type = 'record' then 'strong'
      else 'partial'
    end as knowledge_level,
    case
      when lk.knowledge_type = 'record' then 'question'
      when lk.knowledge_type = 'mystery' then 'riddle'
      else 'hint'
    end as reveal_style
) x
where lk.source_name in (
  'حكاية الليلة التي لم تنتهِ',
  'سجل المدينة القديم',
  'مخطوط مجهول',
  'روايات القوافل',
  'مرجع الدجى'
);
