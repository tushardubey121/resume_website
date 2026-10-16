import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:resume_website/data/resume_data.dart';
import 'package:resume_website/pages/home_page.dart';
import 'package:resume_website/services/resume_service.dart';
import 'package:resume_website/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    // Without this, Flutter web only builds its accessibility DOM after a
    // user finds the hidden "Enable accessibility" button.
    SemanticsBinding.instance.ensureSemantics();
  }
  ResumeService.instance.resolve(ResumeData.profile.resumePath);
  runApp(const ResumeWebsiteApp());
}

class ResumeWebsiteApp extends StatelessWidget {
  const ResumeWebsiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tushar Dubey · Flutter Engineer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const HomePage(),
    );
  }
}
