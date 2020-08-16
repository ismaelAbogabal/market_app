import 'category.dart';

const List<Category> all = [
  Vehicles,
  Properties,
  mobiles,
  electronics,
  home,
  fashion,
  pets,
  kids,
  books,
  jobs,
  business,
  services,
];

const carsForSale = Category(
  name: "Cars For Sale",
  arabicName: "عربيات للبيع",
  sons: [
    const Category(
      name: "Alfa Romeo",
      arabicName: "الفا روميو",
      image: "assets/logos/alfa.jpg",
    ),
    const Category(
      name: "Aston Martin",
      arabicName: "استون مارتن",
      image: "assets/logos/aston_marten.png",
    ),
    const Category(
      name: "Audi",
      arabicName: "اودى",
      image: "assets/logos/audi.png",
    ),
    const Category(
      name: "BMW",
      arabicName: "بى ام دبليو",
      image: "assets/logos/bmw.jpg",
    ),
    const Category(
      name: "BYD",
      arabicName: "بى واى دى",
      image: "assets/logos/byd.png",
    ),
    const Category(
      name: "Bentley",
      arabicName: "بينتلى",
      image: "assets/logos/bentley.png",
    ),
    const Category(
      name: "Brilliance",
      arabicName: "بريلياس",
      image: "assets/logos/brilliance.jpg",
    ),
    const Category(
      name: "Bugatti",
      arabicName: "بوجاتى",
      image: "assets/logos/bugatti.jpg",
    ),
    const Category(
      name: "Buick",
      arabicName: "بويك",
      image: "assets/logos/buick.jpg",
    ),
    const Category(
      name: "Cadillac",
      arabicName: "كاديلاك",
      image: "assets/logos/cadillac.jpg",
    ),
    const Category(
      name: "Chana",
      arabicName: "شانا",
      image: "assets/logos/chana.png",
    ),
    const Category(
      name: "Changan",
      arabicName: "شانجان",
      image: "assets/logos/changan.jpg",
    ),
    const Category(
      name: "Changhe",
      arabicName: "شانجه",
      image: "assets/logos/changahe.jpg",
    ),
    const Category(
      name: "Chery",
      arabicName: "شيرى",
      image: "assets/logos/chery.jpg",
    ),
    const Category(
      name: "Chevrolet",
      arabicName: "شيفورليت",
      image: "assets/logos/chevorlet.jpg",
    ),
    const Category(
      name: "Chrysler",
      arabicName: "كريسال",
      image: "assets/logos/chrysler.png",
    ),
    const Category(
      name: "Citroen",
      arabicName: "كيترون",
      image: "assets/logos/citroen.jpg",
    ),
    const Category(
      name: "Daewoo",
      arabicName: "دايو",
      image: "assets/logos/daewoo.png",
    ),
    const Category(
      name: "Daihatsu",
      arabicName: "داهتسو",
      image: "assets/logos/daihatsu.png",
    ),
    const Category(
      name: "Dodge",
      arabicName: "دودج",
      image: "assets/logos/dodge.jpg",
    ),
    const Category(
      name: "Faw",
      arabicName: "فاو",
      image: "assets/logos/faw.jpg",
    ),
    const Category(
      name: "Ferrari",
      arabicName: "فيرارى",
      image: "assets/logos/ferrari.png",
    ),
    const Category(
      name: "Fiat",
      arabicName: "فيات",
      image: "assets/logos/fiat.jpg",
    ),
    const Category(
      name: "Ford",
      arabicName: "فورد",
      image: "assets/logos/ford.png",
    ),
    const Category(
      name: "Geely",
      arabicName: "جيلى",
      image: "assets/logos/geely.png",
    ),
    const Category(
      name: "Great Wall",
      arabicName: "جريت وال",
      image: "assets/logos/great.jpg",
    ),
    const Category(
      name: "Honda",
      arabicName: "هوندا",
      image: "assets/logos/honda.jpg",
    ),
    const Category(
      name: "Hummer",
      arabicName: "هامر",
      image: "assets/logos/hummer.png",
    ),
    const Category(
      name: "Hyundai",
      arabicName: "هيونداى",
      image: "assets/logos/hyundai.jpg",
    ),
    const Category(
      name: "Infiniti",
      arabicName: "انفينتى",
      image: "assets/logos/infinty.jpg",
    ),
    const Category(
      name: "Isuzu",
      arabicName: "ايسوز",
      image: "assets/logos/isuzu.png",
    ),
    const Category(
      name: "Jac",
      arabicName: "جاك",
      image: "assets/logos/jac.jpg",
    ),
    const Category(
      name: "Jaguar",
      arabicName: "جاكوار",
      image: "assets/logos/jaguar.png",
    ),
    const Category(
      name: "Jeep",
      arabicName: "جيب",
      image: "assets/logos/jeep.jpg",
    ),
    const Category(
      name: "Kia",
      arabicName: "كيا",
      image: "assets/logos/kia.jpg",
    ),
    const Category(
      name: "Lada",
      arabicName: "لادا",
      image: "assets/logos/lada.jpg",
    ),
    const Category(
      name: "Lamborghini",
      arabicName: "لامبورجينى",
      image: "assets/logos/lamborghini.png",
    ),
    const Category(
      name: "Lancia",
      arabicName: "لانسيا",
      image: "assets/logos/lancia.jpg",
    ),
    const Category(
      name: "Land Rover",
      arabicName: "لاند روفر",
      image: "assets/logos/land rover.jpg",
    ),
    const Category(
      name: "Lexus",
      arabicName: "ليكساس",
      image: "assets/logos/lexus.jpg",
    ),
    const Category(
      name: "Lifan",
      arabicName: "ليفان",
      image: "assets/logos/lifan.png",
    ),
    const Category(
      name: "Lincoln",
      arabicName: "لينكولن",
      image: "assets/logos/lincoln.png",
    ),
    const Category(
      name: "MG",
      arabicName: "ام جى",
      image: "assets/logos/mg.png",
    ),
    const Category(
      name: "MINI",
      arabicName: "مينى",
      image: "assets/logos/mini.jpg",
    ),
    const Category(
      name: "Maserati",
      arabicName: "مازيراتى",
      image: "assets/logos/maserati.png",
    ),
    const Category(
      name: "Mazda",
      arabicName: "مازدا",
      image: "assets/logos/mazda.png",
    ),
    const Category(
      name: "Mercedes-Benz",
      arabicName: "مرسيدس بينز",
      image: "assets/logos/mercedes.jpg",
    ),
    const Category(
      name: "Mitsubishi",
      arabicName: "ميتسوبيشى",
      image: "assets/logos/mitsubishi.png",
    ),
    const Category(
      name: "Nissan",
      arabicName: "نيسان",
      image: "assets/logos/nissan.jpg",
    ),
    const Category(
      name: "Opel",
      arabicName: "اوبل",
      image: "assets/logos/opel.png",
    ),
    const Category(
      name: "Peugeot",
      arabicName: "بوجاتى",
      image: "assets/logos/peugeot.jpg",
    ),
    //todo get logo
    const Category(
      name: "Porsche",
      arabicName: "بورشه",
      image: "assets/logos/porsha.jpg",
    ),
    const Category(
      name: "Proton",
      arabicName: "بروتون",
      image: "assets/logos/proton.png",
    ),
    const Category(
      name: "Renault",
      arabicName: "رينو",
      image: "assets/logos/renault.jpg",
    ),
    const Category(
      name: "Saipa",
      arabicName: "سايبا",
      image: "assets/logos/saipa.png",
    ),
    const Category(
      name: "Seat",
      arabicName: "سيات",
      image: "assets/logos/seat.jpg",
    ),
    const Category(
      name: "Senova",
      arabicName: "سينوفا",
      image: "assets/logos/senova.jpg",
    ),
    const Category(
      name: "Skoda",
      arabicName: "اسكودا",
      image: "assets/logos/skoda.jpg",
    ),
    const Category(
      name: "Speranza",
      arabicName: "اسبرانزا",
      image: "assets/logos/spranza.jpg",
    ),
    const Category(
      name: "Ssang Yong",
      arabicName: "سانج يونج",
      image: "assets/logos/ssang.png",
    ),
    const Category(
      name: "Subaru",
      arabicName: "سوبارا",
      image: "assets/logos/subaru.jpg",
    ),
    const Category(
      name: "Suzuki",
      arabicName: "سوزكى",
      image: "assets/logos/suzuki.png",
    ),
    const Category(
      name: "Tesla",
      arabicName: "تيسلا",
      image: "assets/logos/tesla.png",
    ),
    const Category(
      name: "Toyota",
      arabicName: "تويوتا",
      image: "assets/logos/toyta.jpg",
    ),
    const Category(
      name: "Volkswagen",
      arabicName: "فولكواجن",
      image: "assets/logos/volks.jpg",
    ),
    const Category(
      name: "Volvo",
      arabicName: "فولفو",
      image: "assets/logos/volvo.jpg",
    ),
    const Category(
      name: "Zotye",
      arabicName: "زوتى",
      image: "assets/logos/zotye.png",
    ),
    const Category(
      name: "Other make",
      arabicName: "اخرى",
      image: "",
    ),
  ],
);

const Vehicles = Category(
  name: "Vehicles",
  arabicName: "عربيات وقطع غيار",
  image: "assets/images/car.png",
  sons: [
    carsForSale,
    Category(name: "Cars For Rent", arabicName: "سيارات للإيجار"),
    Category(
        name: "Tyres, Batteries,Oil &Accessories",
        arabicName: "اطارات، بطاريات، زيوت، و كماليات"),
    Category(name: "Car Spare Parts", arabicName: "قطع غيار سيارات"),
    Category(
        name: "Motorcycle & Accessories",
        arabicName: "درجات ناريه و إكسسواراتها"),
    Category(name: "Boats - Watercraft", arabicName: "مركبات بحرية"),
    Category(
        name: "Heavy Trucks,Buses & Other Vehicles",
        arabicName: "أتوبيسات، شاحنات نقل ثقيل، و وسائل نقل أخرى"),
  ],
);

const Properties = Category(
  name: "Properties",
  arabicName: "عقارات",
  image: "assets/images/properties.png",
  sons: [
    Category(
        name: "Apartments & Duplex for Sale", arabicName: "شقق و دوبلكس للبيع"),
    Category(
        name: "Apartments & Duplex for Rent",
        arabicName: "شقق و دوبلكس للإيجار"),
    Category(name: "Villas For Sale", arabicName: "فلل للبيع"),
    Category(name: "Villas For Rent", arabicName: "فلل للإيجار"),
    Category(name: "Vacation Homes for Sale", arabicName: "عقارات مصايف للبيع"),
    Category(
        name: "Vacation Homes for Rent", arabicName: "عقارات مصايف للإيجار"),
    Category(name: "Commercial for Sale", arabicName: "عقار تجارى للبيع"),
    Category(name: "Commercial for Rent", arabicName: "عقار تجارى للإيجار"),
    Category(name: "Buildings & Lands", arabicName: "مبانى و أراضى"),
  ],
);

const mobiles = Category(
  name: "Mobile Phones , Tablets,& Accessories",
  arabicName: "هواتف، تابلت، و إكسسواراتها",
  image: "assets/images/mobile.png",
  sons: [
    Category(name: "Mobile Phones", arabicName: "هواتف"),
    Category(name: "Tablets", arabicName: "تابلت"),
    Category(
        name: "Mobile & Tablet Accessories",
        arabicName: "إكسسوارات موبايل و تابلت"),
    Category(name: "Mobile Numbers", arabicName: "خطوط موبايل"),
  ],
);

const electronics = Category(
  name: "Electronics & Home Applications",
  arabicName: "الكترونيات وأجهزة منزلية",
  image: "assets/images/electronics.png",
  sons: [
    Category(
        name: "TV - Audio - Video",
        arabicName: "شاشات تلفزيون وصوتيات",
        sons: [
          Category(name: "Televisions", arabicName: "شاشات تلفزيون"),
          Category(
              name: "DVD - Home Theater", arabicName: "دى فى دى ومسارح منزليه"),
          Category(name: "Home Audio", arabicName: "صوتيات منزلية"),
          Category(
              name: "Mp3 Players - Portable audio",
              arabicName: "مشغلات MP3 وصوتيات"),
          Category(name: "Satellite TV receivers", arabicName: "ريسيفرات")
        ]),
    Category(
        name: "Computers - Accessories",
        arabicName: "كمبيوتر و إكسسوارات",
        sons: [
          Category(name: "Desktop computers", arabicName: "كمبيوتر"),
          Category(name: "Laptop computers", arabicName: "لاب توب"),
          Category(
              name: "Computer Accessories & Spare Parts",
              arabicName: "اكسسوارات و قطع غيار كمبيوتر")
        ]),
    Category(
        name: "Video games - Consoles",
        arabicName: "أجهزة ألعاب فيديو",
        sons: [
          Category(
              name: "Video Game Consoles", arabicName: "أجهزة ألعاب فيديو"),
          Category(
              name: "Video Games & Accessories",
              arabicName: "ألعاب فيديو و إكسسواراتها")
        ]),
    Category(
      name: "Cameras - Imaging",
      arabicName: "كاميرات وتصوير",
      sons: [
        Category(name: "Cameras", arabicName: "كاميرات"),
        Category(name: "Security Cameras", arabicName: "كاميرات مراقبة"),
        Category(name: "Camera Accessories", arabicName: "اكسسوارات الكاميرا"),
        Category(name: "Binoculars - Telescopes", arabicName: "مناظير/تلسكوبات")
      ],
    ),
    Category(
      name: "Home Appliances",
      arabicName: "أجهزة منزلية",
      sons: [
        Category(
            name: "Refrigerators - Freezers", arabicName: "ثلاجات وديب فريزر"),
        Category(
            name: "Ovens - Microwaves",
            arabicName: "بوتاجازات وأفران ومايكروويف"),
        Category(name: "Dishwashers", arabicName: "غسالات أطباق"),
        Category(name: "Cooking Tools", arabicName: "معدات وأدوات طبخ"),
        Category(name: "Washers - Dryers", arabicName: "غسالات ومجففات"),
        Category(
            name: "Water Coolers & Kettles",
            arabicName: "مبردات مياه و غلايات"),
        Category(name: "Air conditioners & Fans", arabicName: "تكييفات ومراوح"),
        Category(name: "Cleaning Appliances", arabicName: "أجهزة نظافة"),
        Category(
            name: "Other Home Appliances", arabicName: "أجهزة منزلية أخرى"),
        Category(name: "Heaters", arabicName: "سخانات")
      ],
    )
  ],
);

const home = Category(
    name: "Home Furniture ",
    arabicName: "أثاث منزل - ديكور",
    image: "assets/images/home.png",
    sons: [
      Category(name: "Bathroom", arabicName: "الحمام"),
      Category(name: "Bedroom", arabicName: "غرفة نوم"),
      Category(name: "Dining Room", arabicName: "غرفة سفرة"),
      Category(
          name: "Fabrics - Curtains - Carpets",
          arabicName: "أقمشة - ستائر - سجاد"),
      Category(name: "Garden - Outdoor", arabicName: "حديقة و أماكن خارجية"),
      Category(name: "Home Decoration", arabicName: "ديكورات منزل"),
      Category(name: "Kitchen - Kitchenware", arabicName: "مطبخ - أدوات مطبخ"),
      Category(name: "Lighting Tools", arabicName: "إضاءة"),
      Category(name: "Living Room", arabicName: "غرفة معيشة"),
      Category(name: "Multiple/Other Furniture", arabicName: "أثاث متعدد/أخر")
    ]);

const fashion = Category(
  name: "Fashion & Beauty",
  arabicName: "الموضة والجمال",
  image: "assets/images/fashion.png",
  sons: [
    Category(name: "Women’s Clothing", arabicName: "ملابس نسائيه"),
    Category(name: "Men’s Clothing", arabicName: "ملابس رجالي"),
    Category(
        name: "Women’s Accessories - Cosmetics - Personal Care",
        arabicName: "كسسوارات - مستحضرات تجميل- عناية شخصية حريمي"),
    Category(
        name: "Men’s Accessories - Personal Care",
        arabicName: "إكسسوارات - عناية شخصية رجالي")
  ],
);

const pets = Category(
  name: "Pets",
  arabicName: "حيوانات أليفة و إكسسواراتها",
  image: "assets/images/pets.png",
  sons: [
    Category(name: "Birds - Pigeons", arabicName: "طيور - حمام"),
    Category(name: "Cats", arabicName: "قطط"),
    Category(name: "Dogs", arabicName: "كلاب"),
    Category(name: "Other Pets & Animals", arabicName: "حيوانات أليفة أخرى"),
    Category(
        name: "Accessories - Pet Care Products",
        arabicName: "إكسسوارات - منتجات عناية بالحيوان")
  ],
);

const kids = Category(
    name: "Kids & Babies",
    arabicName: "مستلزمات أطفال",
    image: "assets/images/kids.png",
    sons: [
      Category(
          name: "Baby & Mom Healthcare",
          arabicName: "عناية - صحة الطفل و الأم"),
      Category(name: "Baby Clothing", arabicName: "ملابس أطفال"),
      Category(name: "Baby Feeding Tools", arabicName: "أدوات تغذية للطفل"),
      Category(
          name: "Cribs - Strollers - Carriers",
          arabicName: "سراير - عربات - أدوات تنقل بالطفل"),
      Category(name: "Toys", arabicName: "ألعاب أطفال"),
      Category(name: "Other Baby Items", arabicName: "مستلزمات أطفال أخرى")
    ]);

const books = Category(
  name: "Books, Sports & Hobbies",
  arabicName: "هوايات، رياضة و كتب",
  image: "assets/images/sports.png",
  sons: [
    Category(name: "Antiques - Collectibles", arabicName: "تحف - مقتنيات"),
    Category(name: "Bicycles", arabicName: "دراجات"),
    Category(name: "Books", arabicName: "كتب"),
    Category(name: "Board - Card Games", arabicName: "ألعاب لوحية - ورقية"),
    Category(name: "Movies - Music", arabicName: "أفلام - موسيقى"),
    Category(name: "Musical Instruments", arabicName: "آلات موسيقية"),
    Category(name: "Sports Equipment", arabicName: "أدوات رياضية"),
    Category(name: "Study Tools", arabicName: "أدوات دراسة"),
    Category(name: "Tickets - Vouchers", arabicName: "تذاكر - قسائم"),
    Category(name: "Luggage", arabicName: "شنط سفر"),
    Category(name: "Other Items", arabicName: "منتجات أخرى"),
  ],
);

const jobs = Category(
  name: "Jobs",
  arabicName: "وظائف",
  image: "assets/images/jobs.png",
  sons: [
    Category(
        name: "Accounting, Finance & Banking", arabicName: "محاسبة و بنوك"),
    Category(name: "Engineering", arabicName: "هندسة"),
    Category(name: "Designers", arabicName: "مصممين"),
    Category(name: "Customer Service & Call Center", arabicName: "خدمة عملاء"),
    Category(name: "Workers and Technicians", arabicName: "عمال و فنيين"),
    Category(
        name: "Management & Consulting", arabicName: "إدارة و أعمال إستشارية"),
    Category(name: "Drivers & Delivery", arabicName: "سائقين - توصيل"),
    Category(name: "Education", arabicName: "تعليم"),
    Category(name: "HR", arabicName: "موارد بشرية"),
    Category(name: "Tourism, Travel & Hospitality", arabicName: "سياحة و سفر"),
    Category(name: "IT - Telecom", arabicName: "تكنولوجيا و معلومات"),
    Category(
        name: "Marketing and Public Relations",
        arabicName: "تسويق و علاقات عامة"),
    Category(
        name: "Medical, Healthcare, & Nursing", arabicName: "طب - صحة - تمريض"),
    Category(name: "Sales", arabicName: "مبيعات"),
    Category(name: "Secretarial", arabicName: "سكرتارية"),
    Category(name: "Guards and Security", arabicName: "حراسات و أمن"),
    Category(name: "Legal - Lawyers", arabicName: "محامين - شئون قانونية"),
    Category(name: "Other Job", arabicName: "وظيفة أخرى")
  ],
);

const business = Category(
  name: "Business - Industrial - Agriculture",
  arabicName: "تجارة - صناعة - زراعة",
  image: "assets/images/busness.png",
  sons: [
    Category(name: "Construction", arabicName: "اعمال بناء"),
    Category(name: "Industrial Equipment", arabicName: "معدات صناعية"),
    Category(name: "Medical Equipment", arabicName: "مستلزمات طبية"),
    Category(
        name: "Office Furniture & Equipment",
        arabicName: "أثاث و مستلزمات المكتب"),
    Category(name: "Restaurants Equipment", arabicName: "معدات مطاعم"),
    Category(name: "Whole Business for Sale", arabicName: "مشروع كامل للبيع"),
    Category(
        name: "Other Business, Industrial & Agriculture",
        arabicName: "تجارة، صناعة وزراعة أخرى")
  ],
);

const services = Category(
  name: "Services",
  arabicName: "خدمات",
  image: "assets/images/services.png",
  sons: [
    Category(name: "Business", arabicName: "خدمات شركات"),
    Category(name: "Car", arabicName: "سيارات"),
    Category(name: "Events", arabicName: "حفلات - مناسبات"),
    Category(name: "Health & Beauty", arabicName: "صحة و جمال"),
    Category(name: "Home", arabicName: "خدمات منزلية"),
    Category(name: "Medical", arabicName: "طبية"),
    Category(name: "Movers", arabicName: "توصيل وشحن"),
    Category(name: "Pets", arabicName: "حيوانات"),
    Category(name: "Education", arabicName: "تعليم"),
    Category(name: "Other Services", arabicName: "خدمات أخرى")
  ],
);
