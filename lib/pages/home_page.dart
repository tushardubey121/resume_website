import 'package:flutter/material.dart';
import 'package:resume_website/theme/app_theme.dart';
import 'package:resume_website/widgets/about_section.dart';
import 'package:resume_website/widgets/contact_section.dart';
import 'package:resume_website/widgets/education_section.dart';
import 'package:resume_website/widgets/experience_section.dart';
import 'package:resume_website/widgets/hero_section.dart';
import 'package:resume_website/widgets/projects_section.dart';
import 'package:resume_website/widgets/site_nav.dart';
import 'package:resume_website/widgets/skills_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final _sectionKeys = <String, GlobalKey>{
    'hero': GlobalKey(),
    'about': GlobalKey(),
    'experience': GlobalKey(),
    'projects': GlobalKey(),
    'skills': GlobalKey(),
    'contact': GlobalKey(),
  };

  bool _navElevated = false;

  static const _navItems = [
    NavItem('About', 'about'),
    NavItem('Experience', 'experience'),
    NavItem('Projects', 'projects'),
    NavItem('Skills', 'skills'),
    NavItem('Contact', 'contact'),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final elevated = _scrollController.offset > 24;
    if (elevated != _navElevated) {
      setState(() => _navElevated = elevated);
    }
  }

  Future<void> _scrollTo(String id) async {
    final key = _sectionKeys[id];
    final context = key?.currentContext;
    if (context == null) return;
    final phone = MediaQuery.sizeOf(this.context).width < Breakpoints.phone;
    await Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeInOutCubic,
      alignment: id == 'hero' ? 0 : (phone ? 0.04 : 0.08),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.foam,
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  KeyedSubtree(
                    key: _sectionKeys['hero'],
                    child: HeroSection(
                      onViewWork: () => _scrollTo('projects'),
                      onContact: () => _scrollTo('contact'),
                    ),
                  ),
                  KeyedSubtree(
                    key: _sectionKeys['about'],
                    child: const AboutSection(),
                  ),
                  KeyedSubtree(
                    key: _sectionKeys['experience'],
                    child: const ExperienceSection(),
                  ),
                  KeyedSubtree(
                    key: _sectionKeys['projects'],
                    child: const ProjectsSection(),
                  ),
                  KeyedSubtree(
                    key: _sectionKeys['skills'],
                    child: const SkillsSection(),
                  ),
                  const EducationSection(),
                  KeyedSubtree(
                    key: _sectionKeys['contact'],
                    child: const ContactSection(),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SiteNav(
              elevated: _navElevated,
              items: _navItems,
              onNavigate: _scrollTo,
            ),
          ),
        ],
      ),
    );
  }
}
