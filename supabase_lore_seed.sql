-- ============================================
-- ALDUJA / LORE FOUNDATION
-- المرجع الأساسي لعالم الدجى
-- ============================================

-- إرم
insert into public.lore_knowledge
(city_id, knowledge_type, knowledge_text, source_name, difficulty, is_public)
select
  c.id,
  'world',
  'مدينة إرم مدينة عربية قديمة تقوم وسط الرمال، تمر بها القوافل، وتخفي أزقتها حكايات لم تُروَ بعد. لا يعرف أهلها على وجه اليقين من أسسها ولا لماذا بقيت بعض آثارها أقدم من ذاكرة سكانها.',
  'مرجع عالم الدجى',
  1,
  false
from public.cities c
where c.name = 'إرم'
and not exists (
  select 1 from public.lore_knowledge
  where knowledge_text = 'مدينة إرم مدينة عربية قديمة تقوم وسط الرمال، تمر بها القوافل، وتخفي أزقتها حكايات لم تُروَ بعد. لا يعرف أهلها على وجه اليقين من أسسها ولا لماذا بقيت بعض آثارها أقدم من ذاكرة سكانها.'
);

-- رملة
insert into public.lore_knowledge
(village_id, knowledge_type, knowledge_text, source_name, difficulty, is_public)
select
  v.id,
  'village',
  'قرية رملة تقع على أطراف إرم، ويعيش أهلها على الماء القليل وحركة القوافل. الخبز والطعام فيها محسوبان، والبقاء مرتبط بمواسم القوافل وبقاء البئر.',
  'مرجع عالم الدجى',
  1,
  false
from public.villages v
where v.name = 'رملة'
and not exists (
  select 1 from public.lore_knowledge
  where knowledge_text = 'قرية رملة تقع على أطراف إرم، ويعيش أهلها على الماء القليل وحركة القوافل. الخبز والطعام فيها محسوبان، والبقاء مرتبط بمواسم القوافل وبقاء البئر.'
);

-- ليلة الرماد
insert into public.lore_knowledge
(knowledge_type, knowledge_text, source_name, difficulty, is_public)
select
  'event',
  'في ليلة سُمّيت لاحقاً عند بعض الناس بليلة الرماد أو ليلة العبور، أُغلق باب إرم الشرقي قبل موعده المعتاد، وانطفأت نار قرب مخزن قديم بطريقة لم يتفق الناس على تفسيرها.',
  'حكاية الليلة التي لم تنتهِ',
  2,
  false
where not exists (
  select 1 from public.lore_knowledge
  where knowledge_text like 'في ليلة سُمّيت لاحقاً%'
);

-- القافلة
insert into public.lore_knowledge
(knowledge_type, knowledge_text, source_name, difficulty, is_public)
select
  'event',
  'كانت هناك قافلة ارتبطت بليلة العبور. بعض الروايات تقول إن فيها سبعة أشخاص، وأخرى تقول تسعة، واختلف الناس حتى في عدد الصناديق التي حملتها. والأغرب أن أحداً لم يستطع إثبات إن كانت القافلة قد دخلت إرم أصلاً.',
  'حكاية الليلة التي لم تنتهِ',
  2,
  false
where not exists (
  select 1 from public.lore_knowledge
  where knowledge_text like 'كانت هناك قافلة ارتبطت بليلة العبور%'
);

-- الرجل والصندوق
insert into public.lore_knowledge
(knowledge_type, knowledge_text, source_name, difficulty, is_public)
select
  'rumor',
  'بعد ليلة العبور شوهد رجل يحمل صندوقاً صغيراً ويمشي نحو الصحراء. لا يعرف الناس ما كان داخل الصندوق، ولا لماذا خرج به وحده، ولا إن كان الرجل جزءاً من القافلة.',
  'روايات أهل إرم',
  3,
  false
where not exists (
  select 1 from public.lore_knowledge
  where knowledge_text like 'بعد ليلة العبور شوهد رجل يحمل صندوقاً صغيراً%'
);

-- السجل المحذوف
insert into public.lore_knowledge
(knowledge_type, knowledge_text, source_name, difficulty, is_public)
select
  'clue',
  'ظهر اسم ممسوح من سجل قديم مرتبط بحركة القوافل. لم يبق من الاسم ما يكفي للجزم بصاحبه، لكن تاريخ السجل جعل بعض الباحثين يشكون في الرواية المتداولة عن ليلة العبور.',
  'سجلات إرم القديمة',
  3,
  false
where not exists (
  select 1 from public.lore_knowledge
  where knowledge_text like 'ظهر اسم ممسوح من سجل قديم%'
);

-- الرسالة
insert into public.lore_knowledge
(knowledge_type, knowledge_text, source_name, difficulty, is_public)
select
  'clue',
  'وصلت بعد ليلة الرماد رسالة مجهولة لا تحمل تفسيراً واضحاً لما حدث. قيمة الرسالة ليست في كلماتها وحدها، بل في تاريخها والخط الذي كُتبت به والجهة التي وصلت إليها.',
  'حكاية الليلة التي لم تنتهِ',
  3,
  false
where not exists (
  select 1 from public.lore_knowledge
  where knowledge_text like 'وصلت بعد ليلة الرماد رسالة مجهولة%'
);

-- الحصان
insert into public.lore_knowledge
(knowledge_type, knowledge_text, source_name, difficulty, is_public)
select
  'clue',
  'شوهد حصان بلا فارس بعد الأحداث الأولى. لم يكن واضحاً إن كان قد ضل طريقه، أم عاد من مكان لا يريد أحد الحديث عنه.',
  'روايات أهل الصحراء',
  3,
  false
where not exists (
  select 1 from public.lore_knowledge
  where knowledge_text like 'شوهد حصان بلا فارس%'
);

-- بئر رملة
insert into public.lore_knowledge
(village_id, knowledge_type, knowledge_text, source_name, difficulty, is_public)
select
  v.id,
  'mystery',
  'بئر رملة بدأت تتغير بصورة لا يلاحظها الجميع. مستوى الماء ينخفض ببطء، وأحياناً يتغير طعمه، وادعى طفل من أهل القرية أنه سمع صوت ماء يتحرك في عمق الأرض.',
  'حكايات رملة',
  4,
  false
from public.villages v
where v.name = 'رملة'
and not exists (
  select 1 from public.lore_knowledge
  where knowledge_text like 'بئر رملة بدأت تتغير بصورة%'
);

-- مريم / ابنة القمر
insert into public.lore_knowledge
(knowledge_type, knowledge_text, source_name, difficulty, is_public)
select
  'rumor',
  'تنتشر في إرم حكايات عن امرأة يطلق عليها بعض الناس ابنة القمر. لا يتفق الرواة على مكان ظهورها ولا على عمرها ولا على بيتها. أكثر ما يتكرر في الحكايات أنها تظهر أحياناً حاملة باقة من الزهور.',
  'إشاعات إرم',
  4,
  false
where not exists (
  select 1 from public.lore_knowledge
  where knowledge_text like 'تنتشر في إرم حكايات عن امرأة يطلق عليها بعض الناس ابنة القمر%'
);

-- تناقض ابنة القمر
insert into public.lore_knowledge
(knowledge_type, knowledge_text, source_name, difficulty, is_public)
select
  'rumor',
  'تقول رواية نادرة إن ابنة القمر ليست امرأة واحدة، بينما يصر آخرون على أنها امرأة واحدة غامضة يعرفها بعض الناس باسم مختلف.',
  'إشاعات إرم',
  5,
  false
where not exists (
  select 1 from public.lore_knowledge
  where knowledge_text like 'تقول رواية نادرة إن ابنة القمر ليست امرأة واحدة%'
);

-- المعرفة المفقودة
insert into public.lore_knowledge
(knowledge_type, knowledge_text, source_name, difficulty, is_public)
select
  'world_mystery',
  'القافلة لم تكن مرتبطة بالمال أو السلاح وحدهما. توجد رواية قديمة تقول إن ما حملته كان معرفة يمكن أن تغيّر فهم مدينة إرم لماضيها، وربما تغيّر تاريخ مكان كامل.',
  'المرجع السردي الأساسي',
  5,
  false
where not exists (
  select 1 from public.lore_knowledge
  where knowledge_text like 'القافلة لم تكن مرتبطة بالمال أو السلاح وحدهما%'
);

-- القاعدة الكبرى للعالم
insert into public.lore_knowledge
(knowledge_type, knowledge_text, source_name, difficulty, is_public)
select
  'world_rule',
  'لا تملك شخصية واحدة الحقيقة كاملة. كل شخصية تعرف أجزاء مختلفة، وبعض المعلومات قد تكون ناقصة أو خاطئة أو متأثرة بالذاكرة. الوصول إلى الحقيقة يحتاج إلى جمع شظايا من أكثر من حكاية وشخص ومكان.',
  'قواعد عالم الدجى',
  1,
  false
where not exists (
  select 1 from public.lore_knowledge
  where knowledge_text like 'لا تملك شخصية واحدة الحقيقة كاملة%'
);

-- قاعدة التناقض
insert into public.lore_knowledge
(knowledge_type, knowledge_text, source_name, difficulty, is_public)
select
  'world_rule',
  'اختلاف الروايات ليس خطأً بالضرورة. قد يكون الاختلاف دليلاً على سر أو ذاكرة ناقصة أو كذبة أو حقيقة لم يفهمها الراوي نفسه.',
  'قواعد عالم الدجى',
  1,
  false
where not exists (
  select 1 from public.lore_knowledge
  where knowledge_text like 'اختلاف الروايات ليس خطأً بالضرورة%'
);

select count(*) as lore_rows
from public.lore_knowledge;
