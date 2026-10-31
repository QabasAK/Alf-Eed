// ─────────────────────────────────────────────────────────────────────────────
// Sample terms for the JSL Engineering Lexicon.
// To add a new term: copy any entry below, give it a unique `id`, fill in all
// fields, and append it to the list.  No other file needs to change.
// ─────────────────────────────────────────────────────────────────────────────
import '../models/term.dart';

const List<Term> sampleTerms = [
  // ── Engineering Basics ────────────────────────────────────────────────────

  Term(
    id: 'force',
    englishName: 'Force',
    arabicName: 'قوة',
    englishDefinition:
        'A push or pull acting on an object that can cause it to accelerate, '
        'decelerate, or change direction. Measured in Newtons (N) and described '
        'by Newton\'s second law: F = ma.',
    arabicDefinition:
        'تأثير يُسلَّط على جسم يمكنه أن يُسبب تسارعه أو تباطؤه أو تغيير اتجاهه. '
        'تُقاس بالنيوتن (N) وتُعبَّر عنها بقانون نيوتن الثاني: F = ma.',
    category: TermCategory.engineeringBasics,
    tags: ['newton', 'mechanics', 'acceleration', 'نيوتن', 'ميكانيكا'],
  ),
  Term(
    id: 'energy',
    englishName: 'Energy',
    arabicName: 'طاقة',
    englishDefinition:
        'The capacity to do work or cause change in a system. Exists in many '
        'forms — kinetic, potential, thermal, electrical — and is conserved '
        'across transformations. Measured in Joules (J).',
    arabicDefinition:
        'القدرة على أداء الشغل أو إحداث تغيير في النظام. توجد في أشكال عديدة '
        '— حركية وكامنة وحرارية وكهربائية — وتُحفَظ عبر التحولات. تُقاس بالجول (J).',
    category: TermCategory.engineeringBasics,
    tags: ['joule', 'kinetic', 'potential', 'conservation', 'جول', 'حفظ الطاقة'],
  ),
  Term(
    id: 'power',
    englishName: 'Power',
    arabicName: 'قدرة',
    englishDefinition:
        'The rate at which energy is transferred or work is done. Calculated as '
        'P = W/t (work divided by time). Measured in Watts (W).',
    arabicDefinition:
        'معدل انتقال الطاقة أو أداء الشغل. تُحسَب بالمعادلة P = W/t (الشغل مقسومًا '
        'على الزمن). تُقاس بالواط (W).',
    category: TermCategory.engineeringBasics,
    tags: ['watt', 'rate', 'work', 'واط', 'شغل'],
  ),
  Term(
    id: 'frequency',
    englishName: 'Frequency',
    arabicName: 'تردد',
    englishDefinition:
        'The number of complete oscillations or cycles of a periodic wave that '
        'occur per unit of time, measured in Hertz (Hz).',
    arabicDefinition:
        'عدد الاهتزازات الكاملة أو دورات الموجة الدورية التي تحدث لكل وحدة زمنية، '
        'وتُقاس بوحدة الهرتز (Hz).',
    category: TermCategory.engineeringBasics,
    animationPath: 'assets/animations/engineering_basics/frequency.mp4',
    tags: ['wave', 'oscillation', 'hertz', 'موجة', 'اهتزاز'],
  ),
  Term(
    id: 'wavelength',
    englishName: 'Wavelength',
    arabicName: 'طول موجي',
    englishDefinition:
        'The distance between two consecutive identical points on a wave, such '
        'as crest to crest or trough to trough. Denoted by λ (lambda) and '
        'measured in metres.',
    arabicDefinition:
        'المسافة بين نقطتين متتاليتين متطابقتين على الموجة، كالقمة إلى القمة أو '
        'القاع إلى القاع. يُرمز له بـ λ (لامدا) ويُقاس بالمتر.',
    category: TermCategory.engineeringBasics,
    tags: ['lambda', 'wave', 'crest', 'موجة', 'لامدا'],
  ),
  Term(
    id: 'voltage',
    englishName: 'Voltage',
    arabicName: 'جهد كهربائي',
    englishDefinition:
        'The electric potential difference between two points in a circuit, '
        'representing the work done per unit charge to move a charge between '
        'those points. Measured in Volts (V).',
    arabicDefinition:
        'فرق الجهد الكهربائي بين نقطتين في دائرة كهربائية، ويمثل الشغل المبذول '
        'لكل وحدة شحنة لنقل شحنة بين تلك النقطتين. يُقاس بالفولت (V).',
    category: TermCategory.engineeringBasics,
    animationPath: 'assets/animations/electrical_engineering/voltage.mp4',
    tags: ['potential', 'volt', 'EMF', 'جهد', 'فولت'],
  ),
  Term(
    id: 'current',
    englishName: 'Current',
    arabicName: 'تيار كهربائي',
    englishDefinition:
        'The rate of flow of electric charge through a conductor. Measured in '
        'Amperes (A) and driven by a potential difference (voltage).',
    arabicDefinition:
        'معدل تدفق الشحنة الكهربائية عبر موصل. يُقاس بالأمبير (A) ويُحرِّكه '
        'فرق الجهد الكهربائي.',
    category: TermCategory.engineeringBasics,
    tags: ['ampere', 'charge', 'flow', 'أمبير', 'شحنة'],
  ),
  Term(
    id: 'resistance',
    englishName: 'Resistance',
    arabicName: 'مقاومة كهربائية',
    englishDefinition:
        'The opposition that a material offers to the flow of electric current. '
        'Defined by Ohm\'s Law: R = V/I. Measured in Ohms (Ω).',
    arabicDefinition:
        'المقاومة التي تبديها مادة ما لتدفق التيار الكهربائي. تُعرَّف بقانون أوم: '
        'R = V/I. تُقاس بالأوم (Ω).',
    category: TermCategory.engineeringBasics,
    tags: ['ohm', 'opposition', 'conductor', 'أوم', 'موصل'],
  ),
  Term(
    id: 'circuit',
    englishName: 'Circuit',
    arabicName: 'دائرة كهربائية',
    englishDefinition:
        'A closed loop through which electric current can flow, consisting of '
        'conductive elements such as wires, resistors, capacitors, and power sources.',
    arabicDefinition:
        'مسار مغلق يمكن من خلاله تدفق التيار الكهربائي، يتكون من عناصر موصلة '
        'مثل الأسلاك والمقاومات والمكثفات ومصادر الطاقة.',
    category: TermCategory.engineeringBasics,
    animationPath: 'assets/animations/engineering_basics/circuit.mp4',
    signVideoPath: 'assets/signs/engineering_basics/circuit_web.mp4',
    // signVideoPath: 'assets/animations/engineering_basics/circuit.mp4',
    tags: ['electricity', 'current', 'loop', 'كهرباء', 'تيار'],
  ),
  Term(
    id: 'signal',
    englishName: 'Signal',
    arabicName: 'إشارة',
    englishDefinition:
        'A time-varying quantity that conveys information; can be analog '
        '(continuous) or digital (discrete), and is fundamental to all '
        'communication and control systems.',
    arabicDefinition:
        'كمية متغيرة بالزمن تحمل المعلومات؛ يمكن أن تكون تماثلية (مستمرة) أو '
        'رقمية (متقطعة)، وهي أساسية في جميع أنظمة الاتصالات والتحكم.',
    category: TermCategory.engineeringBasics,
    animationPath: 'assets/animations/engineering_basics/signal.mp4',
    tags: ['analog', 'digital', 'communication', 'تماثلي', 'رقمي'],
  ),
  Term(
    id: 'sensor',
    englishName: 'Sensor',
    arabicName: 'مستشعر',
    englishDefinition:
        'A device that detects and responds to physical stimuli from the '
        'environment — such as temperature, pressure, or light — and converts '
        'them into an electrical signal.',
    arabicDefinition:
        'جهاز يكتشف المنبهات الفيزيائية من البيئة — كالحرارة والضغط والضوء — '
        'ويستجيب لها محوِّلاً إياها إلى إشارة كهربائية.',
    category: TermCategory.engineeringBasics,
    tags: ['detection', 'transducer', 'input', 'كشف', 'محول'],
  ),
  Term(
    id: 'actuator',
    englishName: 'Actuator',
    arabicName: 'مشغِّل',
    englishDefinition:
        'A component that converts an electrical signal into physical motion or '
        'action — such as a motor, solenoid, or hydraulic cylinder. It is the '
        'output counterpart to a sensor.',
    arabicDefinition:
        'مكوّن يحوّل الإشارة الكهربائية إلى حركة فيزيائية أو فعل — كالمحرك أو '
        'الملف الكهرومغناطيسي أو الأسطوانة الهيدروليكية. وهو المقابل الخارجي للمستشعر.',
    category: TermCategory.engineeringBasics,
    tags: ['motor', 'output', 'motion', 'محرك', 'حركة'],
  ),
  Term(
    id: 'energy_efficiency',
    englishName: 'Energy Efficiency',
    arabicName: 'كفاءة الطاقة',
    englishDefinition:
        'The ratio of useful energy output to total energy input in a system, '
        'expressed as a percentage. Higher efficiency means less energy wasted '
        'as heat or other losses.',
    arabicDefinition:
        'نسبة الطاقة المفيدة المُخرَجة إلى إجمالي الطاقة المُدخَلة في نظام ما، '
        'وتُعبَّر عنها كنسبة مئوية. تعني الكفاءة الأعلى ضياعًا أقل للطاقة كحرارة.',
    category: TermCategory.engineeringBasics,
    tags: ['efficiency', 'ratio', 'losses', 'كفاءة', 'فقد'],
  ),
  Term(
    id: 'system',
    englishName: 'System',
    arabicName: 'نظام',
    englishDefinition:
        'A set of interconnected components that work together to perform a '
        'defined function. Systems have inputs, processes, and outputs, and '
        'are studied through systems engineering.',
    arabicDefinition:
        'مجموعة من المكونات المترابطة التي تعمل معًا لأداء وظيفة محددة. تمتلك '
        'الأنظمة مدخلات وعمليات ومخرجات، وتُدرَس من خلال هندسة الأنظمة.',
    category: TermCategory.engineeringBasics,
    tags: ['input', 'output', 'process', 'مدخلات', 'مخرجات'],
  ),
  Term(
    id: 'feedback',
    englishName: 'Feedback',
    arabicName: 'تغذية راجعة',
    englishDefinition:
        'The process of routing part of a system\'s output back to its input '
        'to regulate or correct behaviour. Negative feedback stabilises a '
        'system; positive feedback amplifies change.',
    arabicDefinition:
        'عملية توجيه جزء من مخرجات النظام إلى مدخلاته لتنظيم سلوكه أو تصحيحه. '
        'التغذية الراجعة السلبية تُثبِّت النظام؛ والإيجابية تُضخِّم التغيير.',
    category: TermCategory.engineeringBasics,
    tags: ['control', 'loop', 'regulation', 'تحكم', 'تنظيم'],
  ),
  Term(
    id: 'prototype',
    englishName: 'Prototype',
    arabicName: 'نموذج أولي',
    englishDefinition:
        'An early functional model of a product or system built to test concepts, '
        'validate designs, and identify problems before full-scale production.',
    arabicDefinition:
        'نموذج وظيفي مبكر لمنتج أو نظام يُبنى لاختبار المفاهيم والتحقق من '
        'التصميمات وتحديد المشكلات قبل الإنتاج بالحجم الكامل.',
    category: TermCategory.engineeringBasics,
    tags: ['design', 'testing', 'iteration', 'تصميم', 'اختبار'],
  ),
  Term(
    id: 'simulation',
    englishName: 'Simulation',
    arabicName: 'محاكاة',
    englishDefinition:
        'A computational model that imitates the behaviour of a real system '
        'over time, allowing engineers to test designs, predict outcomes, and '
        'analyse scenarios without physical prototypes.',
    arabicDefinition:
        'نموذج حاسوبي يحاكي سلوك نظام حقيقي عبر الزمن، يتيح للمهندسين اختبار '
        'التصميمات والتنبؤ بالنتائج وتحليل السيناريوهات دون الحاجة إلى نماذج مادية.',
    category: TermCategory.engineeringBasics,
    tags: ['modelling', 'virtual', 'analysis', 'نمذجة', 'افتراضي'],
  ),

  Term(
    id: 'torque',
    englishName: 'Torque',
    arabicName: 'عزم الدوران',
    englishDefinition:
        'A rotational force that causes or tends to cause rotation about an '
        'axis. Calculated as τ = r × F (radius times force). Measured in '
        'Newton-metres (N·m).',
    arabicDefinition:
        'قوة دورانية تُسبب أو تميل إلى إحداث الدوران حول محور. تُحسَب بالمعادلة '
        'τ = r × F (نصف القطر في القوة). تُقاس بالنيوتن·متر (N·m).',
    category: TermCategory.engineeringBasics,
    tags: ['rotation', 'moment', 'newton-metre', 'دوران', 'نيوتن'],
  ),
  Term(
    id: 'velocity',
    englishName: 'Velocity',
    arabicName: 'سرعة اتجاهية',
    englishDefinition:
        'A vector quantity describing the rate of change of position, including '
        'both speed and direction. Measured in metres per second (m/s).',
    arabicDefinition:
        'كمية متجهة تصف معدل تغير الموضع، وتشمل السرعة والاتجاه معًا. '
        'تُقاس بالمتر في الثانية (m/s).',
    category: TermCategory.engineeringBasics,
    tags: ['speed', 'direction', 'vector', 'متجه', 'اتجاه'],
  ),
  Term(
    id: 'acceleration',
    englishName: 'Acceleration',
    arabicName: 'تسارع',
    englishDefinition:
        'The rate of change of velocity over time. A vector quantity measured '
        'in metres per second squared (m/s²). Described by Newton\'s second '
        'law: a = F/m.',
    arabicDefinition:
        'معدل تغير السرعة الاتجاهية بالنسبة للزمن. كمية متجهة تُقاس بالمتر '
        'في الثانية التربيع (m/s²). تُوصَف بقانون نيوتن الثاني: a = F/m.',
    category: TermCategory.engineeringBasics,
    tags: ['rate of change', 'vector', 'newton', 'متجه', 'نيوتن'],
  ),
  Term(
    id: 'mass',
    englishName: 'Mass',
    arabicName: 'كتلة',
    englishDefinition:
        'A measure of the amount of matter in an object and its resistance to '
        'acceleration (inertia). Measured in kilograms (kg). Distinct from '
        'weight, which is the gravitational force on a mass.',
    arabicDefinition:
        'مقياس لكمية المادة في جسم ومقاومته للتسارع (العطالة). تُقاس '
        'بالكيلوغرام (kg). تختلف عن الوزن الذي هو قوة الجاذبية المؤثرة على الكتلة.',
    category: TermCategory.engineeringBasics,
    tags: ['inertia', 'kilogram', 'matter', 'عطالة', 'كيلوغرام'],
  ),
  Term(
    id: 'friction',
    englishName: 'Friction',
    arabicName: 'احتكاك',
    englishDefinition:
        'A force that opposes the relative motion or tendency of motion between '
        'two surfaces in contact. Can be static (surfaces at rest) or kinetic '
        '(surfaces in motion).',
    arabicDefinition:
        'قوة تعارض الحركة النسبية أو ميل الحركة بين سطحين متلامسين. يمكن أن '
        'يكون ساكنًا (السطحان في حالة راحة) أو حركيًا (السطحان في حالة حركة).',
    category: TermCategory.engineeringBasics,
    tags: ['static', 'kinetic', 'surface', 'force', 'قوة', 'سطح'],
  ),
  Term(
    id: 'pressure',
    englishName: 'Pressure',
    arabicName: 'ضغط',
    englishDefinition:
        'The force applied per unit area on a surface. Measured in Pascals (Pa). '
        'Used in fluid mechanics, thermodynamics, and structural engineering.',
    arabicDefinition:
        'القوة المؤثرة لكل وحدة مساحة على سطح ما. تُقاس بالباسكال (Pa). '
        'تُستخدم في ميكانيكا الموائع والديناميكا الحرارية والهندسة الإنشائية.',
    category: TermCategory.engineeringBasics,
    tags: ['pascal', 'force', 'area', 'باسكال', 'مساحة'],
  ),
  Term(
    id: 'stress_mechanical',
    englishName: 'Stress (Mechanical)',
    arabicName: 'إجهاد ميكانيكي',
    englishDefinition:
        'The internal force per unit area within a material that arises from '
        'externally applied loads. Types include tensile, compressive, and '
        'shear stress. Measured in Pascals (Pa).',
    arabicDefinition:
        'القوة الداخلية لكل وحدة مساحة داخل مادة ما تنشأ عن أحمال خارجية مُطبَّقة. '
        'تشمل الأنواع: الإجهاد الشدي والضغطي والقصي. تُقاس بالباسكال (Pa).',
    category: TermCategory.engineeringBasics,
    tags: ['tensile', 'compressive', 'shear', 'pascal', 'شد', 'ضغط'],
  ),
  Term(
    id: 'strain',
    englishName: 'Strain',
    arabicName: 'انفعال',
    englishDefinition:
        'The deformation of a material expressed as the ratio of change in '
        'dimension to the original dimension. A dimensionless quantity; '
        'closely related to stress through Young\'s modulus.',
    arabicDefinition:
        'تشوُّه مادة ما يُعبَّر عنه كنسبة التغيُّر في البُعد إلى البُعد الأصلي. '
        'كمية عديمة الأبعاد؛ ترتبط ارتباطًا وثيقًا بالإجهاد من خلال معامل يونغ.',
    category: TermCategory.engineeringBasics,
    tags: ['deformation', 'dimensionless', "young's modulus", 'تشوه', 'معامل'],
  ),
  Term(
    id: 'tolerance',
    englishName: 'Tolerance',
    arabicName: 'تفاوت مسموح به',
    englishDefinition:
        'The permissible range of variation in a physical dimension or '
        'measured value. Ensures parts fit and function correctly when '
        'manufactured to specification.',
    arabicDefinition:
        'نطاق التباين المسموح به في بُعد فيزيائي أو قيمة مقيسة. يضمن تلاؤم '
        'القطع وعملها بشكل صحيح عند تصنيعها وفق المواصفات.',
    category: TermCategory.engineeringBasics,
    tags: ['variation', 'specification', 'manufacturing', 'مواصفات', 'تصنيع'],
  ),
  Term(
    id: 'material',
    englishName: 'Material',
    arabicName: 'مادة',
    englishDefinition:
        'Any substance with defined physical and chemical properties used in '
        'engineering applications. Classified broadly as metals, polymers, '
        'ceramics, and composites.',
    arabicDefinition:
        'أي مادة لها خصائص فيزيائية وكيميائية محددة تُستخدم في التطبيقات الهندسية. '
        'تُصنَّف على نطاق واسع إلى معادن ومواد بوليمرية وسيراميك ومواد مركبة.',
    category: TermCategory.engineeringBasics,
    tags: ['metal', 'polymer', 'composite', 'معدن', 'بوليمر', 'مركب'],
  ),
  Term(
    id: 'conductor',
    englishName: 'Conductor',
    arabicName: 'موصل',
    englishDefinition:
        'A material that allows electric current or heat to flow through it '
        'easily due to the presence of free electrons. Metals such as copper '
        'and aluminium are common electrical conductors.',
    arabicDefinition:
        'مادة تسمح بتدفق التيار الكهربائي أو الحرارة خلالها بسهولة بفضل وجود '
        'إلكترونات حرة. المعادن كالنحاس والألومنيوم موصلات كهربائية شائعة.',
    category: TermCategory.engineeringBasics,
    tags: ['copper', 'electron', 'electric', 'نحاس', 'إلكترون'],
  ),
  Term(
    id: 'insulator',
    englishName: 'Insulator',
    arabicName: 'عازل',
    englishDefinition:
        'A material that resists the flow of electric current or heat, '
        'having very few free electrons. Used to protect against electrical '
        'shock and to confine signals within conductors.',
    arabicDefinition:
        'مادة تقاوم تدفق التيار الكهربائي أو الحرارة، ولديها إلكترونات حرة '
        'قليلة جدًا. تُستخدم للحماية من الصدمة الكهربائية وحصر الإشارات داخل الموصلات.',
    category: TermCategory.engineeringBasics,
    tags: ['resistance', 'protection', 'electric', 'حماية', 'مقاومة'],
  ),
  Term(
    id: 'bandwidth',
    englishName: 'Bandwidth',
    arabicName: 'عرض النطاق الترددي',
    englishDefinition:
        'The range of frequencies a system can transmit, or the maximum data '
        'transfer rate of a network or channel. Measured in Hz (analog) or '
        'bits per second (digital).',
    arabicDefinition:
        'نطاق الترددات التي يستطيع النظام إرسالها، أو أقصى معدل لنقل البيانات '
        'في شبكة أو قناة. يُقاس بالهرتز (تماثلي) أو بت في الثانية (رقمي).',
    category: TermCategory.engineeringBasics,
    tags: ['frequency', 'data rate', 'network', 'تردد', 'شبكة'],
  ),
  Term(
    id: 'latency',
    englishName: 'Latency',
    arabicName: 'زمن الاستجابة',
    englishDefinition:
        'The time delay between a stimulus and the response, or between '
        'sending a data packet and receiving it. Lower latency means faster '
        'response. Measured in milliseconds (ms).',
    arabicDefinition:
        'التأخير الزمني بين المنبه والاستجابة، أو بين إرسال حزمة بيانات واستلامها. '
        'الزمن الأقل يعني استجابة أسرع. يُقاس بالميلي ثانية (ms).',
    category: TermCategory.engineeringBasics,
    tags: ['delay', 'response time', 'network', 'تأخير', 'شبكة'],
  ),
  Term(
    id: 'throughput',
    englishName: 'Throughput',
    arabicName: 'معدل الإنتاجية',
    englishDefinition:
        'The amount of data or work successfully processed by a system in a '
        'given period of time. A key performance metric for networks, '
        'processors, and manufacturing systems.',
    arabicDefinition:
        'كمية البيانات أو العمل التي يعالجها النظام بنجاح في فترة زمنية محددة. '
        'مقياس أداء رئيسي للشبكات والمعالجات وأنظمة التصنيع.',
    category: TermCategory.engineeringBasics,
    tags: ['performance', 'data', 'rate', 'أداء', 'بيانات'],
  ),
  Term(
    id: 'calibration',
    englishName: 'Calibration',
    arabicName: 'معايرة',
    englishDefinition:
        'The process of configuring or adjusting a measuring instrument by '
        'comparing its output to a known standard, ensuring accuracy and '
        'reliability of measurements.',
    arabicDefinition:
        'عملية ضبط جهاز قياس أو تعديله بمقارنة مخرجاته بمعيار معروف، '
        'لضمان دقة القياسات وموثوقيتها.',
    category: TermCategory.engineeringBasics,
    tags: ['measurement', 'accuracy', 'standard', 'قياس', 'دقة'],
  ),
  Term(
    id: 'efficiency',
    englishName: 'Efficiency',
    arabicName: 'كفاءة',
    englishDefinition:
        'The ratio of useful output to total input in a process or system, '
        'expressed as a percentage. A perfectly efficient system would have '
        '100% efficiency with no losses.',
    arabicDefinition:
        'نسبة المخرجات المفيدة إلى إجمالي المدخلات في عملية أو نظام، تُعبَّر '
        'عنها كنسبة مئوية. النظام ذو الكفاءة المثالية تكون كفاءته 100% دون خسائر.',
    category: TermCategory.engineeringBasics,
    tags: ['ratio', 'losses', 'performance', 'نسبة', 'خسائر'],
  ),

  // ── Computer Engineering ──────────────────────────────────────────────────

  Term(
    id: 'algorithm',
    englishName: 'Algorithm',
    arabicName: 'خوارزمية',
    englishDefinition:
        'A finite, ordered sequence of well-defined instructions designed to '
        'solve a specific problem or perform a computation.',
    arabicDefinition:
        'تسلسل محدود ومرتب من التعليمات الواضحة المصممة لحل مشكلة معينة أو '
        'تنفيذ عملية حسابية.',
    category: TermCategory.computerEngineering,
    animationPath: 'assets/animations/computer_engineering/algorithm.mp4',
    tags: ['computation', 'logic', 'steps', 'حوسبة', 'منطق'],
  ),
  Term(
    id: 'binary',
    englishName: 'Binary',
    arabicName: 'ثنائي',
    englishDefinition:
        'A base-2 numeral system using only the digits 0 and 1. It is the '
        'fundamental language of all digital computers and electronic circuits.',
    arabicDefinition:
        'نظام عددي ذو أساس اثنين يستخدم الرقمين 0 و1 فقط. إنه اللغة الأساسية '
        'لجميع الحواسيب الرقمية والدوائر الإلكترونية.',
    category: TermCategory.computerEngineering,
    animationPath: 'assets/animations/computer_engineering/binary.mp4',
    tags: ['base-2', 'digits', 'digital', 'أرقام', 'رقمي'],
  ),
  Term(
    id: 'variable',
    englishName: 'Variable',
    arabicName: 'متغير',
    englishDefinition:
        'A named storage location in a program that holds a value which can '
        'be read or modified during execution. Variables have a type, a name, '
        'and a value.',
    arabicDefinition:
        'موقع تخزين مُسمَّى في برنامج يحتفظ بقيمة يمكن قراءتها أو تعديلها أثناء '
        'التنفيذ. تمتلك المتغيرات نوعًا واسمًا وقيمة.',
    category: TermCategory.computerEngineering,
    tags: ['storage', 'value', 'type', 'تخزين', 'قيمة'],
  ),
  Term(
    id: 'function',
    englishName: 'Function',
    arabicName: 'دالة',
    englishDefinition:
        'A named, reusable block of code that performs a specific task, '
        'optionally accepting inputs (parameters) and returning an output value.',
    arabicDefinition:
        'كتلة شيفرة مُسمَّاة وقابلة لإعادة الاستخدام تؤدي مهمة محددة، وقد تقبل '
        'مدخلات (معاملات) وتُعيد قيمة ناتجة.',
    category: TermCategory.computerEngineering,
    tags: ['reuse', 'parameters', 'return', 'معاملات', 'إعادة استخدام'],
  ),
  Term(
    id: 'loop',
    englishName: 'Loop',
    arabicName: 'حلقة تكرار',
    englishDefinition:
        'A control-flow construct in programming that repeats a block of code '
        'as long as a specified condition is true, or for a fixed number of '
        'iterations.',
    arabicDefinition:
        'بنية تحكم في البرمجة تكرر كتلة من الشيفرة طالما أن شرطًا محددًا صحيح، '
        'أو لعدد ثابت من التكرارات.',
    category: TermCategory.computerEngineering,
    animationPath: 'assets/animations/computer_engineering/loop.mp4',
    tags: ['iteration', 'control-flow', 'repeat', 'تكرار', 'برمجة'],
  ),
  Term(
    id: 'recursion',
    englishName: 'Recursion',
    arabicName: 'تعاود',
    englishDefinition:
        'A programming technique where a function calls itself in order to '
        'solve a problem by breaking it into smaller, identical sub-problems, '
        'until a base case is reached.',
    arabicDefinition:
        'أسلوب برمجي تستدعي فيه الدالة نفسها لحل مشكلة بتقسيمها إلى مسائل '
        'فرعية أصغر متطابقة، حتى الوصول إلى الحالة الأساسية.',
    category: TermCategory.computerEngineering,
    tags: ['self-call', 'base case', 'stack', 'استدعاء ذاتي', 'حالة أساسية'],
  ),
  Term(
    id: 'data_structure',
    englishName: 'Data Structure',
    arabicName: 'هيكل البيانات',
    englishDefinition:
        'A way of organizing and storing data in a computer so that it can be '
        'accessed and modified efficiently. Examples include arrays, linked '
        'lists, stacks, and trees.',
    arabicDefinition:
        'طريقة لتنظيم البيانات وتخزينها في الحاسوب بحيث يمكن الوصول إليها '
        'وتعديلها بكفاءة. تشمل الأمثلة المصفوفات والقوائم المرتبطة والمداخن والأشجار.',
    category: TermCategory.computerEngineering,
    animationPath: 'assets/animations/computer_engineering/data_structure.mp4',
    tags: ['array', 'list', 'tree', 'storage', 'تخزين', 'مصفوفة'],
  ),
  Term(
    id: 'stack',
    englishName: 'Stack',
    arabicName: 'مكدس',
    englishDefinition:
        'A linear data structure following Last-In, First-Out (LIFO) order. '
        'Elements are pushed onto the top and popped from the top, like a '
        'stack of plates.',
    arabicDefinition:
        'هيكل بيانات خطي يتبع مبدأ الأخير دخولًا الأول خروجًا (LIFO). '
        'تُضاف العناصر من الأعلى وتُزال من الأعلى، مثل كومة من الأطباق.',
    category: TermCategory.computerEngineering,
    tags: ['LIFO', 'push', 'pop', 'linear', 'خطي'],
  ),
  Term(
    id: 'queue',
    englishName: 'Queue',
    arabicName: 'طابور',
    englishDefinition:
        'A linear data structure following First-In, First-Out (FIFO) order. '
        'Elements are enqueued at the rear and dequeued from the front, '
        'like a waiting line.',
    arabicDefinition:
        'هيكل بيانات خطي يتبع مبدأ الأول دخولًا الأول خروجًا (FIFO). '
        'تُضاف العناصر من الخلف وتُزال من الأمام، مثل طابور الانتظار.',
    category: TermCategory.computerEngineering,
    tags: ['FIFO', 'enqueue', 'dequeue', 'linear', 'خطي'],
  ),
  Term(
    id: 'array',
    englishName: 'Array',
    arabicName: 'مصفوفة',
    englishDefinition:
        'A data structure that stores a fixed-size, ordered collection of '
        'elements of the same type in contiguous memory locations, accessible '
        'by a numerical index.',
    arabicDefinition:
        'هيكل بيانات يخزن مجموعة مرتبة ذات حجم ثابت من العناصر من النوع ذاته '
        'في مواقع ذاكرة متجاورة، يمكن الوصول إليها بفهرس رقمي.',
    category: TermCategory.computerEngineering,
    tags: ['index', 'contiguous', 'collection', 'فهرس', 'مجموعة'],
  ),
  Term(
    id: 'pointer',
    englishName: 'Pointer',
    arabicName: 'مؤشر',
    englishDefinition:
        'A variable that stores the memory address of another variable rather '
        'than a data value directly. Pointers enable dynamic memory management '
        'and efficient data manipulation.',
    arabicDefinition:
        'متغير يخزن عنوان الذاكرة لمتغير آخر بدلًا من قيمة بيانات مباشرة. '
        'تتيح المؤشرات إدارة الذاكرة الديناميكية والتعامل الكفء مع البيانات.',
    category: TermCategory.computerEngineering,
    tags: ['memory', 'address', 'reference', 'ذاكرة', 'عنوان'],
  ),
  Term(
    id: 'compiler',
    englishName: 'Compiler',
    arabicName: 'مُجمِّع',
    englishDefinition:
        'A program that translates source code written in a high-level '
        'programming language into machine code or an intermediate representation '
        'that a computer can execute.',
    arabicDefinition:
        'برنامج يترجم الشيفرة المصدرية المكتوبة بلغة برمجة عالية المستوى إلى '
        'رمز آلي أو تمثيل وسيط يمكن للحاسوب تنفيذه.',
    category: TermCategory.computerEngineering,
    tags: ['translation', 'source code', 'machine code', 'ترجمة', 'رمز آلي'],
  ),
  Term(
    id: 'logic_gate',
    englishName: 'Logic Gate',
    arabicName: 'بوابة منطقية',
    englishDefinition:
        'A basic digital circuit that performs a Boolean operation on one or '
        'more binary inputs to produce a single binary output. Fundamental '
        'gates include AND, OR, and NOT.',
    arabicDefinition:
        'دائرة رقمية أساسية تُجري عملية منطقية بوليانية على مدخل ثنائي واحد أو '
        'أكثر لإنتاج مخرج ثنائي واحد. تشمل البوابات الأساسية AND وOR وNOT.',
    category: TermCategory.computerEngineering,
    tags: ['AND', 'OR', 'NOT', 'boolean', 'digital', 'بوليان', 'رقمي'],
  ),
  Term(
    id: 'flip_flop',
    englishName: 'Flip-Flop',
    arabicName: 'دارة ثنائية الاستقرار',
    englishDefinition:
        'A sequential digital circuit with two stable states that can store '
        'one bit of information. Flip-flops are the fundamental building block '
        'of registers and memory elements.',
    arabicDefinition:
        'دائرة رقمية تتابعية لها حالتان مستقرتان تستطيع تخزين بت واحد من '
        'المعلومات. وهي اللبنة الأساسية للسجلات وعناصر الذاكرة.',
    category: TermCategory.computerEngineering,
    tags: ['sequential', 'bit', 'register', 'memory', 'سجل', 'ذاكرة'],
  ),
  Term(
    id: 'memory',
    englishName: 'Memory',
    arabicName: 'ذاكرة',
    englishDefinition:
        'Hardware that stores data and instructions for use by a processor. '
        'Primary memory (RAM) is fast and volatile; secondary memory (storage) '
        'is slower but persistent.',
    arabicDefinition:
        'عتاد يخزن البيانات والتعليمات لاستخدامها من قِبل المعالج. الذاكرة '
        'الأولية (RAM) سريعة وطيّارة؛ والذاكرة الثانوية (التخزين) أبطأ لكنها دائمة.',
    category: TermCategory.computerEngineering,
    tags: ['RAM', 'storage', 'volatile', 'persistent', 'تخزين', 'طيّار'],
  ),
  Term(
    id: 'processor',
    englishName: 'Processor',
    arabicName: 'معالج',
    englishDefinition:
        'The central processing unit (CPU) of a computer that fetches, decodes, '
        'and executes instructions. It is the brain of any computing device, '
        'performing arithmetic and logic operations.',
    arabicDefinition:
        'وحدة المعالجة المركزية (CPU) في الحاسوب التي تجلب التعليمات وتفككها '
        'وتنفذها. وهي دماغ أي جهاز حوسبة، تُجري العمليات الحسابية والمنطقية.',
    category: TermCategory.computerEngineering,
    tags: ['CPU', 'fetch', 'decode', 'execute', 'معالجة', 'حوسبة'],
  ),
  Term(
    id: 'operating_system',
    englishName: 'Operating System',
    arabicName: 'نظام التشغيل',
    englishDefinition:
        'Software that manages computer hardware and software resources, '
        'providing common services for programs and acting as an interface '
        'between hardware and applications.',
    arabicDefinition:
        'برنامج يدير موارد عتاد الحاسوب وبرمجياته، يوفر خدمات مشتركة للبرامج '
        'ويعمل كواجهة بين العتاد والتطبيقات.',
    category: TermCategory.computerEngineering,
    tags: ['OS', 'kernel', 'resources', 'نواة', 'موارد'],
  ),

  Term(
    id: 'class_oop',
    englishName: 'Class (OOP)',
    arabicName: 'صنف (البرمجة الكائنية)',
    englishDefinition:
        'A blueprint or template in object-oriented programming that defines '
        'the properties (attributes) and behaviours (methods) shared by all '
        'objects of that type.',
    arabicDefinition:
        'مخطط أو قالب في البرمجة الكائنية التوجه يحدد الخصائص (السمات) '
        'والسلوكيات (الأساليب) المشتركة بين جميع كائنات ذلك النوع.',
    category: TermCategory.computerEngineering,
    tags: ['OOP', 'blueprint', 'attributes', 'methods', 'سمات', 'أساليب'],
  ),
  Term(
    id: 'object_oop',
    englishName: 'Object (OOP)',
    arabicName: 'كائن (البرمجة الكائنية)',
    englishDefinition:
        'An instance of a class in object-oriented programming. Objects '
        'encapsulate state (data) and behaviour (methods) and interact '
        'with each other through defined interfaces.',
    arabicDefinition:
        'نسخة من صنف في البرمجة الكائنية التوجه. تُغلِّف الكائنات الحالة '
        '(البيانات) والسلوك (الأساليب) وتتفاعل مع بعضها عبر واجهات محددة.',
    category: TermCategory.computerEngineering,
    tags: ['OOP', 'instance', 'state', 'behaviour', 'حالة', 'سلوك'],
  ),
  Term(
    id: 'inheritance',
    englishName: 'Inheritance',
    arabicName: 'وراثة',
    englishDefinition:
        'An OOP mechanism where a class (child) acquires the properties and '
        'methods of another class (parent), enabling code reuse and '
        'establishing hierarchical relationships.',
    arabicDefinition:
        'آلية في البرمجة الكائنية يكتسب فيها صنف (ابن) خصائص وأساليب صنف آخر '
        '(أب)، مما يتيح إعادة استخدام الشيفرة وإنشاء علاقات هرمية.',
    category: TermCategory.computerEngineering,
    tags: ['OOP', 'parent', 'child', 'reuse', 'إعادة استخدام', 'هرمي'],
  ),
  Term(
    id: 'encapsulation',
    englishName: 'Encapsulation',
    arabicName: 'تغليف',
    englishDefinition:
        'An OOP principle of bundling data and the methods that operate on '
        'that data within a single unit (class), and restricting direct '
        'access to internal state from outside.',
    arabicDefinition:
        'مبدأ في البرمجة الكائنية يقضي بتجميع البيانات والأساليب التي تعمل '
        'عليها في وحدة واحدة (صنف)، وتقييد الوصول المباشر إلى الحالة الداخلية من الخارج.',
    category: TermCategory.computerEngineering,
    tags: ['OOP', 'data hiding', 'access', 'إخفاء البيانات', 'وصول'],
  ),
  Term(
    id: 'interface_ce',
    englishName: 'Interface',
    arabicName: 'واجهة برمجية',
    englishDefinition:
        'A contract in programming that defines a set of method signatures '
        'that a class must implement, enabling different classes to be used '
        'interchangeably.',
    arabicDefinition:
        'عقد في البرمجة يحدد مجموعة من توقيعات الأساليب التي يجب على الصنف '
        'تطبيقها، مما يتيح استخدام فئات مختلفة بشكل متبادل.',
    category: TermCategory.computerEngineering,
    tags: ['OOP', 'contract', 'implementation', 'عقد', 'تطبيق'],
  ),
  Term(
    id: 'api',
    englishName: 'API',
    arabicName: 'واجهة برمجة التطبيقات',
    englishDefinition:
        'Application Programming Interface — a defined set of rules and '
        'protocols that allows different software applications to communicate '
        'and share data with each other.',
    arabicDefinition:
        'واجهة برمجة التطبيقات — مجموعة محددة من القواعد والبروتوكولات تتيح '
        'لتطبيقات البرمجيات المختلفة التواصل ومشاركة البيانات فيما بينها.',
    category: TermCategory.computerEngineering,
    tags: ['protocol', 'communication', 'integration', 'بروتوكول', 'تكامل'],
  ),
  Term(
    id: 'database',
    englishName: 'Database',
    arabicName: 'قاعدة بيانات',
    englishDefinition:
        'An organised collection of structured data stored electronically, '
        'managed by a Database Management System (DBMS). Enables efficient '
        'querying, updating, and retrieval of information.',
    arabicDefinition:
        'مجموعة منظمة من البيانات المهيكلة المخزنة إلكترونيًا، تُدار بواسطة '
        'نظام إدارة قواعد البيانات (DBMS). تتيح الاستعلام والتحديث والاسترجاع الكفء للمعلومات.',
    category: TermCategory.computerEngineering,
    tags: ['DBMS', 'SQL', 'query', 'storage', 'استعلام', 'تخزين'],
  ),
  Term(
    id: 'hash_table',
    englishName: 'Hash Table',
    arabicName: 'جدول تجزئة',
    englishDefinition:
        'A data structure that maps keys to values using a hash function to '
        'compute an index. Enables average O(1) time complexity for insertions, '
        'lookups, and deletions.',
    arabicDefinition:
        'هيكل بيانات يربط المفاتيح بالقيم باستخدام دالة تجزئة لحساب فهرس. '
        'يتيح تعقيدًا زمنيًا متوسطًا O(1) للإدراج والبحث والحذف.',
    category: TermCategory.computerEngineering,
    tags: ['hash', 'key-value', 'O(1)', 'lookup', 'بحث', 'مفتاح'],
  ),
  Term(
    id: 'linked_list',
    englishName: 'Linked List',
    arabicName: 'قائمة مترابطة',
    englishDefinition:
        'A linear data structure where each element (node) contains data and '
        'a pointer to the next node. Supports efficient insertions and '
        'deletions but requires sequential access.',
    arabicDefinition:
        'هيكل بيانات خطي تحتوي فيه كل عنصر (عقدة) على بيانات ومؤشر للعقدة '
        'التالية. يدعم الإدراج والحذف الكفء لكنه يتطلب وصولًا تسلسليًا.',
    category: TermCategory.computerEngineering,
    tags: ['node', 'pointer', 'sequential', 'عقدة', 'مؤشر'],
  ),
  Term(
    id: 'binary_tree',
    englishName: 'Binary Tree',
    arabicName: 'شجرة ثنائية',
    englishDefinition:
        'A hierarchical data structure where each node has at most two children '
        '(left and right). Binary search trees enable O(log n) search; '
        'heaps enable efficient priority queuing.',
    arabicDefinition:
        'هيكل بيانات هرمي لا تمتلك فيه كل عقدة أكثر من طفلين (أيسر وأيمن). '
        'أشجار البحث الثنائية تتيح بحثًا بـ O(log n)؛ والأكوام تتيح طوابير الأولوية الكفؤة.',
    category: TermCategory.computerEngineering,
    tags: ['tree', 'node', 'search', 'hierarchy', 'شجرة', 'هرمي'],
  ),
  Term(
    id: 'sorting_algorithm',
    englishName: 'Sorting Algorithm',
    arabicName: 'خوارزمية الترتيب',
    englishDefinition:
        'An algorithm that arranges elements of a list in a specified order '
        '(ascending or descending). Common examples include Bubble Sort, '
        'Merge Sort, and Quick Sort.',
    arabicDefinition:
        'خوارزمية ترتِّب عناصر قائمة بترتيب محدد (تصاعدي أو تنازلي). '
        'تشمل الأمثلة الشائعة: الفقاعة والدمج والترتيب السريع.',
    category: TermCategory.computerEngineering,
    tags: ['sorting', 'merge sort', 'quick sort', 'ترتيب', 'دمج'],
  ),
  Term(
    id: 'cache',
    englishName: 'Cache',
    arabicName: 'ذاكرة مخبأة',
    englishDefinition:
        'A small, fast memory layer that stores copies of frequently accessed '
        'data to reduce access time. CPUs use L1/L2/L3 caches; web browsers '
        'cache web content locally.',
    arabicDefinition:
        'طبقة ذاكرة صغيرة وسريعة تخزن نسخًا من البيانات المُستخدَمة بكثرة '
        'لتقليل وقت الوصول. تستخدم المعالجات ذاكرات مخبأة L1/L2/L3؛ '
        'والمتصفحات تخزِّن محتوى الويب محليًا.',
    category: TermCategory.computerEngineering,
    tags: ['performance', 'memory', 'speed', 'L1', 'أداء', 'ذاكرة'],
  ),
  Term(
    id: 'register_cpu',
    englishName: 'Register (CPU)',
    arabicName: 'سجل (المعالج)',
    englishDefinition:
        'A small, extremely fast storage location within the CPU that holds '
        'data currently being processed. Registers are the fastest form of '
        'computer memory.',
    arabicDefinition:
        'موقع تخزين صغير وسريع للغاية داخل المعالج يحتفظ بالبيانات الجاري '
        'معالجتها حاليًا. السجلات هي الشكل الأسرع للذاكرة في الحاسوب.',
    category: TermCategory.computerEngineering,
    tags: ['CPU', 'storage', 'fast', 'معالج', 'تخزين'],
  ),
  Term(
    id: 'bus_data',
    englishName: 'Bus (Data)',
    arabicName: 'ناقل البيانات',
    englishDefinition:
        'A communication pathway that transfers data between components '
        'inside a computer — such as the CPU, memory, and peripherals. '
        'Characterised by its width (bits) and speed.',
    arabicDefinition:
        'مسار اتصال ينقل البيانات بين المكونات داخل الحاسوب — كالمعالج '
        'والذاكرة والأجهزة الطرفية. يُميَّز بعرضه (بت) وسرعته.',
    category: TermCategory.computerEngineering,
    tags: ['data transfer', 'CPU', 'width', 'نقل البيانات', 'معالج'],
  ),
  Term(
    id: 'interrupt',
    englishName: 'Interrupt',
    arabicName: 'مقاطعة',
    englishDefinition:
        'A signal sent to the CPU to pause its current task and execute a '
        'higher-priority routine (interrupt handler). Enables CPUs to respond '
        'efficiently to hardware events like keystrokes or timers.',
    arabicDefinition:
        'إشارة تُرسَل إلى المعالج لإيقاف مهمته الحالية وتنفيذ روتين ذي أولوية '
        'أعلى (معالج المقاطعة). تُمكِّن المعالجات من الاستجابة بكفاءة '
        'لأحداث العتاد كضغطات المفاتيح والمؤقتات.',
    category: TermCategory.computerEngineering,
    tags: ['CPU', 'handler', 'priority', 'hardware', 'أولوية', 'عتاد'],
  ),
  Term(
    id: 'firmware',
    englishName: 'Firmware',
    arabicName: 'البرنامج الثابت',
    englishDefinition:
        'Low-level software permanently programmed into hardware (typically '
        'flash memory) that controls device operation at the hardware level. '
        'Sits between hardware and the operating system.',
    arabicDefinition:
        'برنامج منخفض المستوى مُبرمَج بشكل دائم في العتاد (عادةً ذاكرة فلاش) '
        'يتحكم في تشغيل الجهاز على مستوى العتاد. يقع بين العتاد ونظام التشغيل.',
    category: TermCategory.computerEngineering,
    tags: ['embedded', 'flash', 'hardware', 'low-level', 'مضمَّن', 'عتاد'],
  ),
  Term(
    id: 'debugging',
    englishName: 'Debugging',
    arabicName: 'تنقيح الأخطاء',
    englishDefinition:
        'The systematic process of finding and fixing errors (bugs) in '
        'software code. Involves identifying the root cause, isolating the '
        'faulty code, and verifying the fix.',
    arabicDefinition:
        'العملية المنهجية لإيجاد الأخطاء (الحشرات) في شيفرة البرمجيات وإصلاحها. '
        'تتضمن تحديد السبب الجذري وعزل الشيفرة المعيبة والتحقق من الإصلاح.',
    category: TermCategory.computerEngineering,
    tags: ['bug', 'error', 'testing', 'fix', 'خطأ', 'اختبار'],
  ),

  // ── Electrical Engineering ────────────────────────────────────────────────

  Term(
    id: 'resistor',
    englishName: 'Resistor',
    arabicName: 'مقاوم',
    englishDefinition:
        'A passive two-terminal electrical component that limits or regulates '
        'the flow of electric current in a circuit. Resistance is measured in Ohms (Ω).',
    arabicDefinition:
        'مكوّن كهربائي سلبي ذو طرفين يحد من تدفق التيار الكهربائي في الدائرة '
        'أو ينظمه. تُقاس المقاومة بالأوم (Ω).',
    category: TermCategory.electricalEngineering,
    animationPath: 'assets/animations/electrical_engineering/resistor.mp4',
    tags: ['passive', 'ohm', 'current', 'أوم', 'تيار'],
  ),
  Term(
    id: 'capacitor',
    englishName: 'Capacitor',
    arabicName: 'مكثف',
    englishDefinition:
        'A passive two-terminal component that stores energy in an electric '
        'field. It consists of two conductive plates separated by an insulating '
        'dielectric. Capacitance is measured in Farads (F).',
    arabicDefinition:
        'مكوّن سلبي ذو طرفين يخزن الطاقة في مجال كهربائي. يتكون من لوحين '
        'موصلين يفصل بينهما عازل كهربائي. تُقاس السعة بالفاراد (F).',
    category: TermCategory.electricalEngineering,
    animationPath: 'assets/animations/electrical_engineering/capacitor.mp4',
    tags: ['farad', 'charge', 'dielectric', 'فاراد', 'عازل'],
  ),
  Term(
    id: 'inductor',
    englishName: 'Inductor',
    arabicName: 'ملف حثي',
    englishDefinition:
        'A passive component that stores energy in a magnetic field when '
        'current flows through it. Commonly a coil of wire; inductance is '
        'measured in Henries (H).',
    arabicDefinition:
        'مكوّن سلبي يخزن الطاقة في مجال مغناطيسي عند مرور التيار خلاله. '
        'يكون عادةً ملفًا من الأسلاك؛ ويُقاس الحث بالهنري (H).',
    category: TermCategory.electricalEngineering,
    tags: ['henry', 'coil', 'magnetic', 'هنري', 'ملف', 'مغناطيسي'],
  ),
  Term(
    id: 'transistor',
    englishName: 'Transistor',
    arabicName: 'ترانزستور',
    englishDefinition:
        'A semiconductor device used to amplify or switch electronic signals '
        'and electrical power. It is the building block of modern electronic '
        'devices and integrated circuits.',
    arabicDefinition:
        'جهاز شبه موصل يستخدم لتضخيم الإشارات الإلكترونية أو تبديلها والقدرة '
        'الكهربائية. إنه اللبنة الأساسية للأجهزة الإلكترونية الحديثة والدوائر المتكاملة.',
    category: TermCategory.electricalEngineering,
    animationPath: 'assets/animations/electrical_engineering/transistor.mp4',
    tags: ['semiconductor', 'amplifier', 'switch', 'IC', 'شبه موصل', 'تضخيم'],
  ),
  Term(
    id: 'diode',
    englishName: 'Diode',
    arabicName: 'ثنائي قطبي',
    englishDefinition:
        'A semiconductor device that allows current to flow predominantly in '
        'one direction, acting as a one-way valve. Used in rectification, '
        'signal clamping, and voltage regulation.',
    arabicDefinition:
        'جهاز شبه موصل يسمح للتيار بالتدفق في اتجاه واحد بشكل أساسي، ويعمل '
        'كصمام أحادي الاتجاه. يُستخدم في التقويم وتثبيت الإشارات وتنظيم الجهد.',
    category: TermCategory.electricalEngineering,
    tags: ['rectifier', 'one-way', 'semiconductor', 'تقويم', 'شبه موصل'],
  ),
  Term(
    id: 'transformer',
    englishName: 'Transformer',
    arabicName: 'محول كهربائي',
    englishDefinition:
        'A device that transfers electrical energy between two or more circuits '
        'through electromagnetic induction, stepping voltage up or down while '
        'keeping frequency constant.',
    arabicDefinition:
        'جهاز ينقل الطاقة الكهربائية بين دائرتين أو أكثر عبر الحث الكهرومغناطيسي، '
        'رافعًا الجهد أو خافضًا إياه مع الإبقاء على التردد ثابتًا.',
    category: TermCategory.electricalEngineering,
    tags: ['induction', 'step-up', 'step-down', 'AC', 'حث', 'تيار متردد'],
  ),
  Term(
    id: 'amplifier',
    englishName: 'Amplifier',
    arabicName: 'مضخم إشارة',
    englishDefinition:
        'An electronic circuit that increases the power, voltage, or current '
        'of a signal while maintaining its essential waveform shape. Gain '
        'describes how much amplification occurs.',
    arabicDefinition:
        'دائرة إلكترونية تزيد قدرة أو جهد أو شدة إشارة ما مع الحفاظ على '
        'شكل موجتها الأساسي. يصف الكسب مقدار التضخيم الحادث.',
    category: TermCategory.electricalEngineering,
    tags: ['gain', 'signal', 'power', 'كسب', 'تضخيم'],
  ),
  Term(
    id: 'oscillator',
    englishName: 'Oscillator',
    arabicName: 'مذبذب',
    englishDefinition:
        'A circuit that produces a periodic, repetitive waveform — such as a '
        'sine or square wave — without any external input signal. Used as '
        'clocks in digital systems.',
    arabicDefinition:
        'دائرة تولِّد موجة دورية متكررة — كالموجة الجيبية أو الموجة المربعة — '
        'دون أي إشارة خارجية. يُستخدم كساعة في الأنظمة الرقمية.',
    category: TermCategory.electricalEngineering,
    tags: ['clock', 'waveform', 'frequency', 'ساعة', 'موجة'],
  ),
  Term(
    id: 'filter',
    englishName: 'Filter',
    arabicName: 'مرشح',
    englishDefinition:
        'A circuit that selectively passes signals of certain frequencies while '
        'attenuating others. Types include low-pass, high-pass, band-pass, '
        'and band-stop filters.',
    arabicDefinition:
        'دائرة تمرِّر بشكل انتقائي الإشارات ذات ترددات معينة مع تخفيف غيرها. '
        'تشمل الأنواع: مرشح التمرير المنخفض والعالي والنطاق وحجب النطاق.',
    category: TermCategory.electricalEngineering,
    tags: ['low-pass', 'high-pass', 'frequency', 'attenuation', 'تخفيف', 'تردد'],
  ),
  Term(
    id: 'impedance',
    englishName: 'Impedance',
    arabicName: 'ممانعة',
    englishDefinition:
        'The total opposition to alternating current flow in a circuit, '
        'combining resistance and reactance (from capacitors and inductors). '
        'Measured in Ohms (Ω) and represented as a complex number.',
    arabicDefinition:
        'مجموع المقاومة الكلية لتدفق التيار المتردد في الدائرة، تجمع بين '
        'المقاومة والتفاعل (من المكثفات والملفات). تُقاس بالأوم (Ω) وتُمثَّل كعدد مركب.',
    category: TermCategory.electricalEngineering,
    tags: ['AC', 'reactance', 'ohm', 'complex', 'تيار متردد', 'أوم'],
  ),
  Term(
    id: 'waveform',
    englishName: 'Waveform',
    arabicName: 'شكل موجي',
    englishDefinition:
        'A graphical representation of how a signal varies over time. Common '
        'waveforms include sine, square, triangle, and sawtooth waves, each '
        'with distinct properties.',
    arabicDefinition:
        'تمثيل بياني لكيفية تغير الإشارة عبر الزمن. تشمل الأشكال الموجية الشائعة '
        'الموجة الجيبية والمربعة والمثلثية وموجة المنشار، لكل منها خصائصه المميزة.',
    category: TermCategory.electricalEngineering,
    tags: ['sine', 'square', 'signal', 'graph', 'جيبية', 'بياني'],
  ),
  Term(
    id: 'modulation',
    englishName: 'Modulation',
    arabicName: 'تعديل',
    englishDefinition:
        'The process of varying a carrier signal\'s properties — amplitude, '
        'frequency, or phase — to encode information for transmission. '
        'Examples: AM (amplitude), FM (frequency), PM (phase).',
    arabicDefinition:
        'عملية تغيير خصائص الإشارة الحاملة — سعة أو تردد أو طور — لترميز '
        'المعلومات للإرسال. أمثلة: AM (السعة)، FM (التردد)، PM (الطور).',
    category: TermCategory.electricalEngineering,
    tags: ['AM', 'FM', 'carrier', 'transmission', 'إرسال', 'حامل'],
  ),
  Term(
    id: 'rectifier',
    englishName: 'Rectifier',
    arabicName: 'مقوِّم',
    englishDefinition:
        'A circuit that converts alternating current (AC) into direct current '
        '(DC) using diodes. Half-wave rectifiers use one diode; full-wave '
        'rectifiers use four in a bridge configuration.',
    arabicDefinition:
        'دائرة تحوِّل التيار المتردد (AC) إلى تيار مستمر (DC) باستخدام '
        'الثنائيات القطبية. المقوِّم نصف الموجة يستخدم ثنائيًا واحدًا؛ '
        'والموجة الكاملة يستخدم أربعة في تكوين جسري.',
    category: TermCategory.electricalEngineering,
    tags: ['AC', 'DC', 'diode', 'bridge', 'تيار مستمر', 'جسري'],
  ),
  Term(
    id: 'ground',
    englishName: 'Ground',
    arabicName: 'أرضي',
    englishDefinition:
        'A reference point in a circuit defined as zero volts, to which all '
        'other voltages are measured. Also a safety connection to the earth '
        'that prevents dangerous voltage build-up on equipment.',
    arabicDefinition:
        'نقطة مرجعية في الدائرة تُعرَّف بصفر فولت، تُقاس إليها جميع الجهود الأخرى. '
        'كذلك هو توصيل أمان بالأرض يمنع تراكم جهد خطر على المعدات.',
    category: TermCategory.electricalEngineering,
    tags: ['reference', 'zero volts', 'safety', 'earth', 'مرجع', 'أمان'],
  ),
  Term(
    id: 'short_circuit',
    englishName: 'Short Circuit',
    arabicName: 'دارة قصيرة',
    englishDefinition:
        'An abnormal low-resistance connection between two points in a circuit '
        'that causes excessive current to flow, bypassing the intended load. '
        'Can cause overheating, fires, or component damage.',
    arabicDefinition:
        'توصيل غير طبيعي منخفض المقاومة بين نقطتين في الدائرة يُسبب تدفق تيار '
        'مفرط، متجاوزًا الحمل المقصود. قد يُسبب ارتفاع حرارة أو حرائق أو تلف مكونات.',
    category: TermCategory.electricalEngineering,
    tags: ['fault', 'overcurrent', 'safety', 'خطأ', 'تيار زائد', 'أمان'],
  ),
  Term(
    id: 'fourier_transform',
    englishName: 'Fourier Transform',
    arabicName: 'تحويل فورييه',
    englishDefinition:
        'A mathematical technique that decomposes a signal into its constituent '
        'frequencies. Fundamental to signal processing, allowing analysis in '
        'the frequency domain rather than the time domain.',
    arabicDefinition:
        'تقنية رياضية تحلِّل الإشارة إلى الترددات المكوِّنة لها. أساسية في '
        'معالجة الإشارات، تتيح التحليل في نطاق التردد بدلًا من نطاق الزمن.',
    category: TermCategory.electricalEngineering,
    tags: ['frequency domain', 'signal processing', 'spectrum', 'طيف', 'تردد'],
  ),
  Term(
    id: 'convolution',
    englishName: 'Convolution',
    arabicName: 'التفافية',
    englishDefinition:
        'A mathematical operation that combines two functions to produce a '
        'third, describing how the shape of one is modified by the other. '
        'Used extensively in signal processing and linear systems.',
    arabicDefinition:
        'عملية رياضية تجمع دالتين لإنتاج ثالثة، تصف كيف يُعدِّل شكلُ إحداهما '
        'الأخرى. تُستخدم على نطاق واسع في معالجة الإشارات والأنظمة الخطية.',
    category: TermCategory.electricalEngineering,
    tags: ['signal processing', 'linear system', 'filter', 'خطي', 'مرشح'],
  ),
  Term(
    id: 'sampling_rate',
    englishName: 'Sampling Rate',
    arabicName: 'معدل أخذ العينات',
    englishDefinition:
        'The number of samples taken per second when converting an analog '
        'signal to digital. The Nyquist theorem states the sampling rate must '
        'be at least twice the highest signal frequency.',
    arabicDefinition:
        'عدد العينات المأخوذة في الثانية عند تحويل الإشارة التماثلية إلى رقمية. '
        'ينص مبرهنة نايكويست على أن معدل أخذ العينات يجب أن يكون ضعف أعلى '
        'تردد في الإشارة على الأقل.',
    category: TermCategory.electricalEngineering,
    tags: ['Nyquist', 'ADC', 'digital', 'نايكويست', 'رقمي'],
  ),
  Term(
    id: 'adc',
    englishName: 'Analog-to-Digital Converter',
    arabicName: 'محول تماثلي-رقمي',
    englishDefinition:
        'A circuit that converts a continuous analog signal into a discrete '
        'digital representation. Resolution (bits) and sampling rate determine '
        'conversion accuracy.',
    arabicDefinition:
        'دائرة تحوِّل الإشارة التماثلية المستمرة إلى تمثيل رقمي متقطع. '
        'يحدد الدقة (بت) ومعدل أخذ العينات دقةَ التحويل.',
    category: TermCategory.electricalEngineering,
    tags: ['ADC', 'conversion', 'resolution', 'bits', 'دقة', 'بت'],
  ),
  Term(
    id: 'dac',
    englishName: 'Digital-to-Analog Converter',
    arabicName: 'محول رقمي-تماثلي',
    englishDefinition:
        'A circuit that converts a digital signal (discrete binary values) '
        'back into an analog signal (continuous voltage or current). Used in '
        'audio output, motor control, and signal generation.',
    arabicDefinition:
        'دائرة تحوِّل الإشارة الرقمية (قيم ثنائية متقطعة) إلى إشارة تماثلية '
        '(جهد أو تيار مستمر). تُستخدم في مخرجات الصوت والتحكم بالمحركات وتوليد الإشارات.',
    category: TermCategory.electricalEngineering,
    tags: ['DAC', 'audio', 'analog output', 'صوت', 'مخرج تماثلي'],
  ),
  Term(
    id: 'op_amp',
    englishName: 'Op-Amp',
    arabicName: 'مكبر عملياتي',
    englishDefinition:
        'Operational Amplifier — a high-gain voltage amplifier with differential '
        'inputs and a single output. Used in filters, comparators, integrators, '
        'and many analog signal-processing circuits.',
    arabicDefinition:
        'المكبر العملياتي — مكبر جهد عالي الكسب بمدخلين تفاضليين ومخرج واحد. '
        'يُستخدم في المرشحات والمقارنات والمكاملات ودوائر معالجة الإشارات التماثلية.',
    category: TermCategory.electricalEngineering,
    tags: ['amplifier', 'gain', 'differential', 'analog', 'كسب', 'تفاضلي'],
  ),
  Term(
    id: 'pcb',
    englishName: 'PCB',
    arabicName: 'لوحة الدوائر المطبوعة',
    englishDefinition:
        'Printed Circuit Board — a flat board made of insulating material '
        'with conductive copper tracks that mechanically supports and '
        'electrically connects electronic components.',
    arabicDefinition:
        'لوحة الدوائر المطبوعة — لوح مسطح من مادة عازلة بمسارات نحاسية موصلة '
        'تدعم ميكانيكيًا وتوصِّل كهربائيًا المكونات الإلكترونية.',
    category: TermCategory.electricalEngineering,
    tags: ['board', 'copper', 'electronics', 'نحاس', 'إلكترونيات'],
  ),
  Term(
    id: 'microcontroller',
    englishName: 'Microcontroller',
    arabicName: 'متحكم دقيق',
    englishDefinition:
        'A compact integrated circuit that contains a processor, memory, and '
        'programmable input/output peripherals on a single chip. Used to '
        'control embedded systems like Arduino.',
    arabicDefinition:
        'دائرة متكاملة مدمجة تحتوي على معالج وذاكرة وأطراف إدخال/إخراج قابلة '
        'للبرمجة على رقاقة واحدة. تُستخدم للتحكم في الأنظمة المضمَّنة كالأردوينو.',
    category: TermCategory.electricalEngineering,
    tags: ['embedded', 'Arduino', 'chip', 'مضمَّن', 'رقاقة'],
  ),
  Term(
    id: 'fpga',
    englishName: 'FPGA',
    arabicName: 'مصفوفة البوابات القابلة للبرمجة',
    englishDefinition:
        'Field-Programmable Gate Array — an integrated circuit whose logic '
        'can be reconfigured after manufacturing using hardware description '
        'languages like VHDL or Verilog.',
    arabicDefinition:
        'مصفوفة البوابات القابلة للبرمجة ميدانيًا — دائرة متكاملة يمكن إعادة '
        'تهيئة منطقها بعد التصنيع باستخدام لغات وصف العتاد كـVHDL أو Verilog.',
    category: TermCategory.electricalEngineering,
    tags: ['VHDL', 'Verilog', 'reconfigurable', 'hardware', 'عتاد', 'قابل للبرمجة'],
  ),
  Term(
    id: 'power_supply',
    englishName: 'Power Supply',
    arabicName: 'مزود الطاقة',
    englishDefinition:
        'A device that converts electrical energy from a source into the '
        'voltage, current, and frequency required by an electronic load. '
        'Types include linear and switched-mode power supplies.',
    arabicDefinition:
        'جهاز يحوِّل الطاقة الكهربائية من مصدر إلى الجهد والتيار والتردد '
        'التي يحتاجها الحمل الإلكتروني. تشمل الأنواع: مزودات الطاقة الخطية '
        'ومفتاحية التحويل.',
    category: TermCategory.electricalEngineering,
    tags: ['voltage regulation', 'AC/DC', 'conversion', 'تحويل', 'تنظيم'],
  ),
  Term(
    id: 'load_electrical',
    englishName: 'Load (Electrical)',
    arabicName: 'حمل كهربائي',
    englishDefinition:
        'Any device or component in a circuit that consumes electrical power '
        'and converts it into another form of energy, such as light, heat, '
        'or mechanical work.',
    arabicDefinition:
        'أي جهاز أو مكوّن في الدائرة يستهلك الطاقة الكهربائية ويحوِّلها إلى '
        'شكل آخر من الطاقة، كالضوء أو الحرارة أو الشغل الميكانيكي.',
    category: TermCategory.electricalEngineering,
    tags: ['power', 'consumption', 'device', 'استهلاك', 'جهاز'],
  ),
  Term(
    id: 'phase_ac',
    englishName: 'Phase (AC)',
    arabicName: 'طور (تيار متردد)',
    englishDefinition:
        'The position of a point in time on a waveform cycle, expressed in '
        'degrees (0°–360°). Phase difference between two signals determines '
        'whether they are in phase or out of phase.',
    arabicDefinition:
        'موضع نقطة زمنية على دورة الموجة، يُعبَّر عنه بالدرجات (0°–360°). '
        'يحدد فرق الطور بين إشارتين ما إذا كانتا في الطور ذاته أم لا.',
    category: TermCategory.electricalEngineering,
    tags: ['waveform', 'degrees', 'AC', 'shift', 'موجة', 'درجة'],
  ),
  Term(
    id: 'harmonics',
    englishName: 'Harmonics',
    arabicName: 'توافقيات',
    englishDefinition:
        'Frequency components that are integer multiples of a fundamental '
        'frequency in a periodic signal. Harmonics cause waveform distortion '
        'and can degrade power quality in electrical systems.',
    arabicDefinition:
        'مكونات ترددية هي مضاعفات صحيحة للتردد الأساسي في إشارة دورية. '
        'تُسبب التوافقيات تشويه الموجة وقد تُدهور جودة الطاقة في الأنظمة الكهربائية.',
    category: TermCategory.electricalEngineering,
    tags: ['distortion', 'frequency', 'power quality', 'تشويه', 'جودة طاقة'],
  ),
  Term(
    id: 'electromagnetic_field',
    englishName: 'Electromagnetic Field',
    arabicName: 'مجال كهرومغناطيسي',
    englishDefinition:
        'A physical field produced by electrically charged objects, comprising '
        'both an electric field and a magnetic field that propagate as '
        'electromagnetic waves at the speed of light.',
    arabicDefinition:
        'حقل فيزيائي تنتجه الأجسام المشحونة كهربائيًا، يشمل مجالًا كهربائيًا '
        'ومجالًا مغناطيسيًا ينتشران كموجات كهرومغناطيسية بسرعة الضوء.',
    category: TermCategory.electricalEngineering,
    tags: ['electric field', 'magnetic field', 'wave', 'كهربائي', 'مغناطيسي'],
  ),
  Term(
    id: 'antenna',
    englishName: 'Antenna',
    arabicName: 'هوائي',
    englishDefinition:
        'A transducer that converts electrical signals into electromagnetic '
        'waves for transmission, or captures electromagnetic waves and converts '
        'them back into electrical signals for reception.',
    arabicDefinition:
        'محوِّل يحوِّل الإشارات الكهربائية إلى موجات كهرومغناطيسية للإرسال، '
        'أو يلتقط الموجات الكهرومغناطيسية ويحوِّلها إلى إشارات كهربائية للاستقبال.',
    category: TermCategory.electricalEngineering,
    tags: ['transmission', 'reception', 'wireless', 'إرسال', 'استقبال', 'لاسلكي'],
  ),
  Term(
    id: 'battery',
    englishName: 'Battery',
    arabicName: 'بطارية',
    englishDefinition:
        'A device that stores chemical energy and converts it into electrical '
        'energy through electrochemical reactions. Characterised by its voltage, '
        'capacity (Ah), and energy density.',
    arabicDefinition:
        'جهاز يخزن الطاقة الكيميائية ويحوِّلها إلى طاقة كهربائية من خلال '
        'تفاعلات كهروكيميائية. يتميز بجهده وسعته (أمبير·ساعة) وكثافة طاقته.',
    category: TermCategory.electricalEngineering,
    tags: ['energy storage', 'chemical', 'voltage', 'capacity', 'سعة', 'طاقة'],
  ),
  Term(
    id: 'ac_dc',
    englishName: 'AC / DC',
    arabicName: 'تيار متردد / تيار مستمر',
    englishDefinition:
        'AC (Alternating Current) periodically reverses direction; DC (Direct '
        'Current) flows in one direction only. Mains electricity is AC; '
        'batteries supply DC. Power supplies convert between the two.',
    arabicDefinition:
        'التيار المتردد (AC) يعكس اتجاهه بشكل دوري؛ والتيار المستمر (DC) يتدفق '
        'في اتجاه واحد فقط. كهرباء الشبكة متردد؛ والبطاريات تورِّد مستمرًا. '
        'مزودات الطاقة تحول بين الاثنين.',
    category: TermCategory.electricalEngineering,
    tags: ['alternating', 'direct', 'mains', 'battery', 'بطارية', 'شبكة'],
  ),
];
