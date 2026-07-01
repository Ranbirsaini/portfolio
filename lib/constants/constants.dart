import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFF0F172A); // Slate 900
  static const Color surface = Color(0xFF1E293B); // Slate 800
  static const Color primary = Color(0xFF06B6D4); // Cyan 500
  static const Color primaryDark = Color(0xFF0891B2); // Cyan 600
  static const Color secondary = Color(0xFF6366F1); // Indigo 500
  static const Color textPrimary = Color(0xFFF8FAFC); // Slate 50
  static const Color textSecondary = Color(0xFF94A3B8); // Slate 400
  static const Color textMuted = Color(0xFF64748B); // Slate 500
  static const Color cardBorder = Color(0xFF334155); // Slate 700
  static const Color glowColor = Color(0x3306B6D4); // Neon glow cyan
}

class AppStrings {
  static const String name = "Ranbir Saini";
  static const String title = "Senior Flutter Developer";
  static const String experienceYears = "3.9+ Years";
  static const String email = "sainiranbir645@gmail.com";
  static const String phone = "+91 9467505762";
  static const String location = "Karnal, Haryana, India";
  static const String githubUrl = "https://github.com/RanbirSaini"; // Placeholder
  static const String linkedinUrl = "https://www.linkedin.com/in/ranbir-saini"; // Placeholder

  static const String bio = 
      "Flutter Developer with 3.9+ years of experience building high-performance, responsive Android and iOS applications using Flutter and Dart. "
      "Proven track record in integrating REST APIs, Firebase services, Socket.io, Google Maps, QR/Barcode scanning, and deploying stable builds to the Google Play Store and Apple App Store.";
}

class ProjectData {
  final String title;
  final String description;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final List<String> techStack;

  const ProjectData({
    required this.title,
    required this.description,
    this.playStoreUrl,
    this.appStoreUrl,
    required this.techStack,
  });
}

final List<ProjectData> projectsList = [
  const ProjectData(
    title: "E-Sign",
    description: "Independently designed and developed a digital document signing application in Flutter. Enables users to securely create, manage, and sign documents electronically with a streamlined UX.",
    playStoreUrl: "https://play.google.com/store/apps/details?id=com.e_sign_pr.e_sign_pr",
    techStack: ["Flutter", "Dart", "Cryptography", "PDF rendering", "Path Provider"],
  ),
  const ProjectData(
    title: "GetWeTap",
    description: "An innovative NFC & QR-based digital business card application. Allows swift contactless profile sharing, card scanning, and dynamic profile management.",
    playStoreUrl: "https://play.google.com/store/apps/details?id=com.zimblecode.wetap",
    appStoreUrl: "https://apps.apple.com/us/app/getwetap-nfc-business-card/id1660750697",
    techStack: ["Flutter", "NFC Manager", "QR Code", "Firebase", "GetX"],
  ),
  const ProjectData(
    title: "Tasty Punjab",
    description: "A comprehensive restaurant ordering, table booking, and takeaway application. Integrates full cart flow, location services, table reservation, and notifications.",
    playStoreUrl: "https://play.google.com/store/apps/details?id=com.tastypunjab",
    appStoreUrl: "https://apps.apple.com/us/app/tasty-punjab-au/id6475163123",
    techStack: ["Flutter", "Dart", "Firebase", "Stripe API", "Google Maps"],
  ),
  const ProjectData(
    title: "Tasty Punjab Driver",
    description: "A specialized delivery partner application featuring order management, route navigation, and real-time order tracking.",
    playStoreUrl: "https://play.google.com/store/apps/details?id=com.tastypunjabdriver",
    appStoreUrl: "https://apps.apple.com/us/app/tasty-punjab-driver/id6475163123",
    techStack: ["Flutter", "Geolocator", "Google Maps Navigation", "REST APIs", "WebSockets"],
  ),
  const ProjectData(
    title: "What's In It",
    description: "A multilingual barcode & ingredient scanner supporting 9 languages. Focuses on product verification, accessibility, and high-speed scanner performance.",
    playStoreUrl: "https://play.google.com/store/apps/details?id=com.nexever.whats",
    appStoreUrl: "https://apps.apple.com/us/app/whats-in-it/id1542297341",
    techStack: ["Flutter", "ML Kit Barcode Scanning", "Multilingual (9)", "Shared Preferences"],
  ),
  const ProjectData(
    title: "Enoteca World",
    description: "A premium Flutter iOS application designed for wine & spirits discovery, collection cataloging, and cellar management.",
    appStoreUrl: "https://apps.apple.com/us/app/enoteca-world/id6746676536",
    techStack: ["Flutter", "Dart", "iOS optimization", "REST APIs", "Hive Database"],
  ),
  const ProjectData(
    title: "Score My Game",
    description: "A specialized Water Polo scoring application designed specifically for tournament coaches and referees to manage match scores and statistics.",
    playStoreUrl: "https://play.google.com/store/apps/details?id=com.score_my_game.zimble",
    techStack: ["Flutter", "Bloc", "Local DB", "Match Timer APIs"],
  ),
];

class ExperienceData {
  final String company;
  final String location;
  final String role;
  final String duration;
  final List<String> highlights;

  const ExperienceData({
    required this.company,
    required this.location,
    required this.role,
    required this.duration,
    required this.highlights,
  });
}

final List<ExperienceData> experienceList = [
  const ExperienceData(
    company: "Zimble Code Solution Pvt. Ltd.",
    location: "Mohali, Punjab, India",
    role: "Flutter Developer",
    duration: "1.2 Years",
    highlights: [
      "Led the design and architecture of key projects, improving overall app quality and code reuse.",
      "Developed business-critical features including NFC-based digital cards and socket-driven real-time applications.",
      "Managed deployment pipelines for multiple applications to Google Play Store and Apple App Store.",
    ],
  ),
  const ExperienceData(
    company: "Nexever Pvt. Ltd.",
    location: "Mohali, Punjab, India",
    role: "Flutter Developer",
    duration: "1.1 Years",
    highlights: [
      "Worked on high-performance barcode scanning applications with robust multilingual localizations.",
      "Designed and integrated offline-first local storage solutions utilizing SQLite and Hive databases.",
      "Collaborated closely with backend developers to design efficient REST API schemas.",
    ],
  ),
  const ExperienceData(
    company: "Try Digital Solution Pvt. Ltd.",
    location: "Mohali, Punjab, India",
    role: "Flutter Developer",
    duration: "1 Year",
    highlights: [
      "Developed modular UI components for multiple cross-platform client applications.",
      "Integrated audio and video calling solutions using Zego Cloud SDK.",
      "Configured CI/CD automation pipelines for faster development builds.",
    ],
  ),
  const ExperienceData(
    company: "Connex Infotech Pvt. Ltd.",
    location: "India",
    role: "Flutter Developer",
    duration: "6 Months",
    highlights: [
      "Enhanced user experience by revamping legacy UI structures in existing mobile apps.",
      "Integrated payment gateways including Stripe and localized Razorpay configurations.",
      "Maintained version control systems and code review protocols on GitHub.",
    ],
  ),
  const ExperienceData(
    company: "Solitaire Infosys Pvt. Ltd.",
    location: "India",
    role: "Flutter Internship",
    duration: "Dec 2021 - May 2022",
    highlights: [
      "Gained hands-on training with Dart language, widget tree lifecycle, and basic State Management concepts.",
      "Built clean sample applications demonstrating Firebase integration and API consuming.",
    ],
  ),
];

class EducationData {
  final String degree;
  final String institution;
  final String year;

  const EducationData({
    required this.degree,
    required this.institution,
    required this.year,
  });
}

final List<EducationData> educationList = [
  const EducationData(
    degree: "BCA (Bachelor of Computer Applications)",
    institution: "Kurukshetra University",
    year: "2018 - 2021",
  ),
  const EducationData(
    degree: "Senior Secondary (HBSE)",
    institution: "Haryana Board of School Education",
    year: "2017",
  ),
  const EducationData(
    degree: "Matriculation (HBSE)",
    institution: "Haryana Board of School Education",
    year: "2015",
  ),
];

class SkillCategory {
  final String name;
  final List<String> skills;

  const SkillCategory({
    required this.name,
    required this.skills,
  });
}

final List<SkillCategory> skillsCategoriesList = [
  const SkillCategory(
    name: "Mobile & Core Languages",
    skills: ["Flutter", "Dart", "FlutterFlow", "Android Studio", "Xcode"],
  ),
  const SkillCategory(
    name: "State Management",
    skills: ["Bloc", "GetX", "Riverpod", "RxDart"],
  ),
  const SkillCategory(
    name: "APIs & Real-Time Sync",
    skills: ["REST APIs", "Socket.io", "MQTT", "JSON", "WebSockets"],
  ),
  const SkillCategory(
    name: "Hardware & Native Integrations",
    skills: ["NFC Integrations", "QR/Barcode Scanner", "Google Maps SDK", "Zego Calling (Audio/Video)", "In-App Purchases (Stripe)"],
  ),
  const SkillCategory(
    name: "Backend, Tools & DevOps",
    skills: ["Firebase Suite", "Shared Preferences", "Git & GitHub", "Azure Cloud", "CI/CD Pipelines", "Play Store Deployment", "App Store Deployment"],
  ),
];
