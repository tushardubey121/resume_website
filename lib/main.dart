import 'package:flutter/material.dart';
import 'package:resume_website/pages/home_page.dart';
import 'package:resume_website/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ResumeWebsiteApp());
}

class ResumeWebsiteApp extends StatelessWidget {
  const ResumeWebsiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tushar Dubey',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const HomePage(),
    );
  }
}
