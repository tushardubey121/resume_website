class ProfileInfo {
  final String name;
  final String title;
  final String location;
  final String email;
  final String phone;
  final String linkedInUrl;
  final String linkedInLabel;
  final String summary;

  const ProfileInfo({
    required this.name,
    required this.title,
    required this.location,
    required this.email,
    required this.phone,
    required this.linkedInUrl,
    required this.linkedInLabel,
    required this.summary,
  });
}

class ExperienceItem {
  final String role;
  final String company;
  final String period;
  final List<String> highlights;

  const ExperienceItem({
    required this.role,
    required this.company,
    required this.period,
    required this.highlights,
  });
}

class ProjectItem {
  final String name;
  final String description;
  final String imageAsset;
  final String? playStoreUrl;
  final String? websiteUrl;
  final List<String> tags;

  const ProjectItem({
    required this.name,
    required this.description,
    required this.imageAsset,
    this.playStoreUrl,
    this.websiteUrl,
    required this.tags,
  });
}

class SkillGroup {
  final String label;
  final List<String> skills;

  const SkillGroup({required this.label, required this.skills});
}

class EducationItem {
  final String degree;
  final String school;
  final String year;

  const EducationItem({
    required this.degree,
    required this.school,
    required this.year,
  });
}

abstract final class ResumeData {
  static const profile = ProfileInfo(
    name: 'Tushar Dubey',
    title: 'Flutter Developer · Associate Manager',
    location: 'Mumbai, India',
    email: 'tushardubey121@gmail.com',
    phone: '+91 8005468041',
    linkedInUrl: 'https://www.linkedin.com/in/tushar-dubey715371125/',
    linkedInLabel: 'linkedin.com/in/tushar-dubey715371125',
    summary:
        'Flutter and Dart developer with 8+ years of experience building Android and iOS apps and websites, with Swift and Kotlin for native work. Currently an Associate Manager at Spice Money, building the Adhikari app and web portal across AePS, BBPS, KYC/eKYC and insurance, and migrating portals to Flutter. Has shipped apps to Google Play across video calling with in-app subscriptions, loyalty and rewards, BLE IoT and B2B travel booking. Works with Firebase and SQL, applies SOLID and Clean Code principles, and has experience of CI/CD and Agile.',
  );

  static const experience = <ExperienceItem>[
    ExperienceItem(
      role: 'Associate Manager',
      company: 'Spice Money',
      period: 'Aug 2022 — Present',
      highlights: [
        'Built and shipped features for the Spice Money Adhikari app and website (spicemoney.com), serving banking agents across rural and semi-urban India.',
        'Worked on AePS (Aadhaar Enabled Payment System) flows for cash withdrawal, cash deposit, balance inquiry and mini statement with biometric authentication.',
        'Implemented Bharat Connect / BBPS assisted bill payments for utilities, loans, credit cards and insurance premiums on app and B2B portal.',
        'Delivered KYC and Aadhaar-based eKYC journeys for Adhikari onboarding and Spice Pay wallet activation.',
        'Built insurance product flows covering two-wheeler, car, health and shopkeeper insurance through the Adhikari platforms.',
        'Migrated the Spice Money Adhikari and Travel Union portals to Flutter and optimized them for better performance.',
      ],
    ),
    ExperienceItem(
      role: 'Software Engineer L1',
      company: 'Valuecoders',
      period: 'Aug 2021 — Jul 2022',
      highlights: [
        'Worked directly with a client\'s development team in a consulting role.',
        'Worked on the Teplo Tea BLE IoT project.',
      ],
    ),
    ExperienceItem(
      role: 'Software Engineer',
      company: 'Techahead Software',
      period: 'Feb 2019 — Aug 2021',
      highlights: [
        'Built and managed several Flutter apps across video calling, fitness, logistics and social media.',
        'Delivered TheSkinDeep, Foodaholix, Travel Union and Zips Cannabis.',
      ],
    ),
  ];

  static const projects = <ProjectItem>[
    ProjectItem(
      name: 'Spice Money',
      description:
          'Adhikari banking-agent app and website for assisted banking across Bharat. Built Flutter features for AePS cash withdrawal/deposit, Bharat Connect (BBPS) bill payments, KYC/eKYC onboarding, and insurance (two-wheeler, car, health).',
      imageAsset: 'assets/images/projects/spice_money_cover.webp',
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=in.spicemudra&hl=en_IN',
      websiteUrl: 'https://www.spicemoney.com/',
      tags: ['Flutter', 'BFSI', 'AePS', 'BBPS', 'eKYC'],
    ),
    ProjectItem(
      name: 'Teplo Tea',
      description:
          'Companion app for the Teplo connected tea pot, a BLE IoT project. Users set up their Teplo and control brewing over Bluetooth, pick a brew based on mood, and subscribe to teas in the app.',
      imageAsset: 'assets/images/projects/teplo_cover.webp',
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.loadandroad.teplo.android',
      tags: ['Flutter', 'BLE', 'IoT'],
    ),
    ProjectItem(
      name: 'Travel Union',
      description:
          'B2B booking app for flights, trains, buses, hotels and holiday packages — a one-stop platform for travel agents.',
      imageAsset: 'assets/images/projects/travel_union_cover.webp',
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.travelunion.app',
      tags: ['Flutter', 'B2B', 'Travel'],
    ),
    ProjectItem(
      name: 'TheSkinDeep',
      description:
          'Video calling app with a card game. Users play cards from their chosen deck during a video call or locally, and buy play counts through in-app subscriptions.',
      imageAsset: 'assets/images/projects/skindeep_cover.png',
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.skindeep',
      tags: ['Flutter', 'Video', 'IAP'],
    ),
    ProjectItem(
      name: 'Zips Cannabis',
      description:
          'Loyalty app where users earn points on purchases at Zips stores and redeem them later. Built with Flutter and Firebase.',
      imageAsset: 'assets/images/projects/zips_cover.jpg',
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.app.zipsloyalty',
      tags: ['Flutter', 'Firebase', 'Loyalty'],
    ),
    ProjectItem(
      name: 'Foodaholix',
      description:
          'App for rating food and restaurants. Users write reviews, add dish prices for others to see, and earn rewards after submitting a set amount of dish data.',
      imageAsset: 'assets/images/projects/foodaholix_cover.webp',
      tags: ['Flutter', 'Social', 'Food'],
    ),
  ];

  static const skills = <SkillGroup>[
    SkillGroup(
      label: 'Mobile',
      skills: [
        'Flutter',
        'Dart',
        'Android',
        'iOS',
        'Kotlin',
        'Swift',
        'BLE',
        'IoT',
      ],
    ),
    SkillGroup(
      label: 'State management',
      skills: [
        'Provider',
        'Riverpod',
        'Bloc',
        'GetX',
        'MobX',
        'Redux',
      ],
    ),
    SkillGroup(
      label: 'Payment gateways',
      skills: [
        'In-app purchases',
        'Stripe',
        'Razorpay',
        'PayU',
        'Paytm',
        'PhonePe',
        'Cashfree',
        'PayPal',
      ],
    ),
    SkillGroup(
      label: 'Backend & data',
      skills: ['Firebase', 'SQL'],
    ),
    SkillGroup(
      label: 'Engineering practice',
      skills: ['SOLID', 'Clean Code', 'CI/CD', 'Agile', 'OKRs'],
    ),
    SkillGroup(
      label: 'Tools',
      skills: [
        'Git',
        'Jira',
        'VS Code',
        'Android Studio',
        'Xcode',
        'IntelliJ',
        'Claude',
        'Cursor',
        'Codex',
      ],
    ),
  ];

  static const education = EducationItem(
    degree: 'B.Tech in Computer Science',
    school: 'IEC Group of Institutions, Greater Noida, India',
    year: '2019',
  );
}
