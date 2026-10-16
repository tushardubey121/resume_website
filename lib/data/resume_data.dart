import 'package:flutter/painting.dart';
import 'package:resume_website/theme/app_theme.dart';

// Content source of truth. Everything here is taken from the published resume
// and the previous version of this site. Optional fields left null are hidden
// in the UI; fill them in only with verified information.

class ProfileInfo {
  final String name;
  final String role;
  final String location;
  final String email;
  final String linkedInUrl;
  final String githubUrl;
  final String sourceUrl;
  final DateTime careerStart;

  /// Shown as a status line in the hero. Set to null to hide it.
  final String? availability;

  /// Path relative to the site root. The download button only appears once a
  /// PDF is actually deployed at this path.
  final String resumePath;

  const ProfileInfo({
    required this.name,
    required this.role,
    required this.location,
    required this.email,
    required this.linkedInUrl,
    required this.githubUrl,
    required this.sourceUrl,
    required this.careerStart,
    required this.resumePath,
    this.availability,
  });

  int get yearsOfExperience {
    final now = DateTime.now();
    var months = (now.year - careerStart.year) * 12 + now.month - careerStart.month;
    if (now.day < careerStart.day) months--;
    return months ~/ 12;
  }
}

class ExperienceItem {
  final String role;
  final String company;
  final String companyContext;
  final DateTime start;
  final DateTime? end;
  final List<String> highlights;

  const ExperienceItem({
    required this.role,
    required this.company,
    required this.companyContext,
    required this.start,
    this.end,
    required this.highlights,
  });
}

class ProjectLink {
  final String label;
  final String url;

  const ProjectLink(this.label, this.url);
}

class ProjectVisual {
  final String asset;
  final double aspectRatio;
  final Color background;
  final BoxFit fit;
  final Alignment alignment;

  /// Fraction of the plate's shorter side used as inner padding, so brand
  /// marks sit on their colour instead of being cropped edge to edge.
  final double inset;

  /// Describes what the image is, so it is never mistaken for a screenshot.
  final String caption;
  final String semanticLabel;

  const ProjectVisual({
    required this.asset,
    required this.aspectRatio,
    required this.background,
    required this.caption,
    required this.semanticLabel,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.inset = 0,
  });
}

class ProjectItem {
  final String id;
  final String name;
  final String category;
  final String summary;
  final String builtAt;
  final String? period;
  final List<String> platforms;
  final String? story;
  final List<String> contributions;
  final List<String> stack;
  final ProjectVisual visual;
  final List<ProjectLink> links;
  final String? note;

  // Not yet supplied. Rendered only when filled in with verified facts.
  final String? outcome;

  const ProjectItem({
    required this.id,
    required this.name,
    required this.category,
    required this.summary,
    required this.builtAt,
    required this.visual,
    this.platforms = const [],
    this.period,
    this.story,
    this.contributions = const [],
    this.stack = const [],
    this.links = const [],
    this.note,
    this.outcome,
  });
}

class ExpertiseArea {
  final String title;
  final String description;
  final List<String> evidence;

  const ExpertiseArea({
    required this.title,
    required this.description,
    required this.evidence,
  });
}

class ToolGroup {
  final String label;
  final List<String> items;

  const ToolGroup(this.label, this.items);
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
  static final profile = ProfileInfo(
    name: 'Tushar Dubey',
    role: 'Flutter Engineer',
    location: 'Mumbai, India',
    email: 'tushardubey121@gmail.com',
    linkedInUrl: 'https://www.linkedin.com/in/tushar-dubey715371125/',
    githubUrl: 'https://github.com/tushardubey121',
    sourceUrl: 'https://github.com/tushardubey121/resume_website',
    careerStart: DateTime(2019, 2),
    availability: 'Open to senior Flutter and mobile roles',
    resumePath: 'resume/Tushar_Dubey_Resume.pdf',
  );

  static final experience = <ExperienceItem>[
    ExperienceItem(
      role: 'Associate Manager',
      company: 'Spice Money',
      companyContext:
          'Fintech. Assisted banking delivered through a network of local agents.',
      start: DateTime(2022, 8),
      highlights: const [
        'Build and ship features for the Spice Money Adhikari app and spicemoney.com, used by banking agents across rural and semi-urban India.',
        'Delivered AePS, BBPS bill payment, KYC/eKYC and insurance journeys across the Android app and the B2B web portal.',
        'Migrated the Adhikari and Travel Union portals to Flutter and optimised them for performance.',
        'Reworked the Travel Union portal to improve its user experience.',
      ],
    ),
    ExperienceItem(
      role: 'Software Engineer L1',
      company: 'Valuecoders',
      companyContext: 'Consulting. Embedded with a client’s development team.',
      start: DateTime(2021, 8),
      end: DateTime(2022, 7),
      highlights: const [
        'Worked directly with a client’s development team in a consulting role.',
        'Built the companion app for Teplo, a Bluetooth LE connected tea pot.',
      ],
    ),
    ExperienceItem(
      role: 'Software Engineer',
      company: 'Techahead Software',
      companyContext: 'Software agency. Flutter apps for client products.',
      start: DateTime(2019, 2),
      end: DateTime(2021, 8),
      highlights: const [
        'Built and maintained Flutter apps across video calling, fitness, logistics and social media.',
        'Delivered TheSkinDeep, Foodaholix, Travel Union and Zips Cannabis.',
      ],
    ),
  ];

  static const featuredProjects = <ProjectItem>[
    ProjectItem(
      id: 'spice-money',
      name: 'Spice Money Adhikari',
      category: 'Fintech · Assisted banking',
      summary:
          'The app and web portal Spice Money’s agents (Adhikaris) use to offer banking, bill payments and insurance to customers across rural and semi-urban India.',
      builtAt: 'Spice Money',
      period: '2022 — present',
      platforms: ['Android', 'Web portal'],
      contributions: [
        'AePS (Aadhaar Enabled Payment System) flows for cash withdrawal, cash deposit, balance inquiry and mini statement, with biometric authentication.',
        'Bharat Connect / BBPS assisted bill payments for utilities, loans, credit cards and insurance premiums, on the app and the B2B portal.',
        'KYC and Aadhaar-based eKYC journeys for agent onboarding and Spice Pay wallet activation.',
        'Insurance flows for two-wheeler, car, health and shopkeeper cover.',
        'Migration of the Adhikari web portal to Flutter, with performance optimisation.',
      ],
      stack: [
        'Flutter',
        'Flutter Web',
        'Riverpod',
        'get_it + injectable',
        'Dio',
        'Hive',
        'freezed',
        'Stage / UAT / production builds',
      ],
      visual: ProjectVisual(
        asset: 'assets/images/projects/spice_money_cover.webp',
        aspectRatio: 4 / 5,
        background: AppColors.plateSpice,
        alignment: Alignment(0, 0.72),
        caption: 'Google Play listing artwork for the Adhikari app',
        semanticLabel:
            'Spice Money Adhikari app artwork showing service tiles for cash withdrawal, collect cash, loans, money transfer, bank accounts, tickets, bill payments and credit cards',
      ),
      links: [
        ProjectLink(
          'Google Play',
          'https://play.google.com/store/apps/details?id=in.spicemudra&hl=en_IN',
        ),
        ProjectLink('spicemoney.com', 'https://www.spicemoney.com/'),
      ],
    ),
    ProjectItem(
      id: 'travel-union',
      name: 'Travel Union',
      category: 'B2B travel · Booking platform',
      summary:
          'A one-stop booking platform for travel agents covering flights, trains, buses, hotels and holiday packages.',
      builtAt: 'Techahead, then Spice Money',
      platforms: ['Android', 'Web portal'],
      story:
          'I worked on Travel Union twice. At Techahead I delivered the B2B booking app. Later, at Spice Money, I reworked the Travel Union portal to improve its user experience and migrated it to Flutter.',
      contributions: [
        'B2B booking app for flights, trains, buses, hotels and holiday packages.',
        'Portal UX rework and migration to Flutter, optimised for performance.',
      ],
      visual: ProjectVisual(
        asset: 'assets/images/projects/travel_union_cover.webp',
        aspectRatio: 4 / 5,
        background: AppColors.plateTravelUnion,
        fit: BoxFit.contain,
        inset: 0.26,
        caption: 'Travel Union brand mark',
        semanticLabel: 'Travel Union logo',
      ),
      links: [
        ProjectLink(
          'Google Play',
          'https://play.google.com/store/apps/details?id=com.travelunion.app',
        ),
      ],
    ),
  ];

  static const moreProjects = <ProjectItem>[
    ProjectItem(
      id: 'teplo',
      name: 'Teplo Tea',
      category: 'Connected hardware · BLE',
      summary:
          'Companion app for the Teplo connected tea pot. Users set up the device and control brewing over Bluetooth LE, pick a brew to suit their mood, and subscribe to teas.',
      builtAt: 'Valuecoders',
      stack: ['Flutter', 'Bluetooth LE'],
      visual: ProjectVisual(
        asset: 'assets/images/projects/teplo_cover.webp',
        aspectRatio: 16 / 10,
        background: AppColors.plateTeplo,
        fit: BoxFit.contain,
        inset: 0.12,
        caption: 'Teplo brand mark',
        semanticLabel: 'Teplo logo',
      ),
      links: [
        ProjectLink(
          'Google Play',
          'https://play.google.com/store/apps/details?id=com.loadandroad.teplo.android',
        ),
      ],
    ),
    ProjectItem(
      id: 'foodaholix',
      name: 'Foodaholix',
      category: 'Consumer · Food reviews',
      summary:
          'Rate dishes and restaurants. Users write reviews, add dish prices for others to see, and earn rewards after contributing a set amount of dish data.',
      builtAt: 'Techahead',
      platforms: ['Android', 'iOS'],
      stack: [
        'Flutter',
        'Riverpod',
        'get_it + injectable',
        'Firebase',
        'Google / Apple / Facebook sign-in',
      ],
      visual: ProjectVisual(
        asset: 'assets/images/projects/foodaholix_cover.webp',
        aspectRatio: 16 / 10,
        background: AppColors.plateFoodaholix,
        fit: BoxFit.contain,
        inset: 0.06,
        alignment: Alignment(0, -0.2),
        caption: 'Foodaholix marketing artwork',
        semanticLabel:
            'Foodaholix app artwork showing a user profile with recent dish reviews',
      ),
    ),
    ProjectItem(
      id: 'zips',
      name: 'Zips Cannabis',
      category: 'Retail · Loyalty',
      summary:
          'Loyalty app where customers earn points on purchases at Zips stores and redeem them later.',
      builtAt: 'Techahead',
      stack: ['Flutter', 'Firebase'],
      visual: ProjectVisual(
        asset: 'assets/images/projects/zips_cover.webp',
        aspectRatio: 16 / 10,
        background: AppColors.plateNeutral,
        alignment: Alignment(0.05, 0),
        caption: 'Zips Cannabis storefront signage',
        semanticLabel: 'Zips Cannabis sign above a city street',
      ),
      links: [
        ProjectLink(
          'Google Play',
          'https://play.google.com/store/apps/details?id=com.app.zipsloyalty',
        ),
      ],
    ),
    ProjectItem(
      id: 'skindeep',
      name: 'TheSkinDeep',
      category: 'Video calling · In-app purchases',
      summary:
          'Video calling app built around a card game. Users play cards from their chosen deck during a call or locally, and buy play counts through in-app subscriptions.',
      builtAt: 'Techahead',
      stack: ['Flutter', 'Video calling', 'In-app subscriptions'],
      note: 'No longer listed on Google Play',
      visual: ProjectVisual(
        asset: 'assets/images/projects/skindeep_cover.webp',
        aspectRatio: 16 / 10,
        background: AppColors.plateNeutral,
        alignment: Alignment(0, 0.3),
        caption: 'The Skin Deep studio set',
        semanticLabel: 'Two chairs facing each other on a rug in a film studio',
      ),
    ),
  ];

  static const expertise = <ExpertiseArea>[
    ExpertiseArea(
      title: 'One codebase, three platforms',
      description:
          'Flutter and Dart across Android, iOS and web, with Kotlin and Swift when a feature needs to go native. The Adhikari app and its B2B portal ship from Flutter.',
      evidence: ['Spice Money', 'Foodaholix'],
    ),
    ExpertiseArea(
      title: 'Regulated banking flows',
      description:
          'AePS transactions with biometric authentication, BBPS bill payments, Aadhaar eKYC and insurance: journeys that move real money for agents and their customers.',
      evidence: ['Spice Money'],
    ),
    ExpertiseArea(
      title: 'Payments and monetisation',
      description:
          'In-app subscriptions and payment gateways including Stripe, Razorpay, PayU, Paytm, PhonePe, Cashfree and PayPal.',
      evidence: ['TheSkinDeep', 'Spice Money'],
    ),
    ExpertiseArea(
      title: 'Hardware over Bluetooth LE',
      description:
          'Device setup and brewing control for a connected tea pot, over Bluetooth LE from the phone.',
      evidence: ['Teplo Tea'],
    ),
    ExpertiseArea(
      title: 'Portal migration to Flutter Web',
      description:
          'Moved two production B2B portals to Flutter and tuned them for performance, including a UX rework of the Travel Union portal.',
      evidence: ['Spice Money', 'Travel Union'],
    ),
    ExpertiseArea(
      title: 'Maintainable architecture',
      description:
          'SOLID and Clean Code, dependency injection with get_it and injectable, and state management with Riverpod, Bloc or Provider. Shipped through CI/CD in Agile teams.',
      evidence: ['Spice Money', 'Foodaholix'],
    ),
  ];

  static const toolbox = <ToolGroup>[
    ToolGroup('Languages', ['Dart', 'Kotlin', 'Swift']),
    ToolGroup(
      'State management',
      ['Riverpod', 'Bloc', 'Provider', 'GetX', 'MobX', 'Redux'],
    ),
    ToolGroup('Data', ['Firebase', 'SQL', 'Hive']),
    ToolGroup(
      'Payments',
      [
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
    ToolGroup('Practice', ['CI/CD', 'Git', 'Jira', 'Agile', 'OKRs']),
    ToolGroup('AI-assisted development', ['Cursor', 'Claude', 'Codex']),
  ];

  static const education = EducationItem(
    degree: 'B.Tech in Computer Science',
    school: 'IEC Group of Institutions, Greater Noida',
    year: '2019',
  );
}
