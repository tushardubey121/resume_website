import 'package:flutter/material.dart';
import 'package:resume_website/theme/app_theme.dart';
import 'package:resume_website/widgets/contact_section.dart';
import 'package:resume_website/widgets/experience_section.dart';
import 'package:resume_website/widgets/expertise_section.dart';
import 'package:resume_website/widgets/hero_section.dart';
import 'package:resume_website/widgets/projects_section.dart';
import 'package:resume_website/widgets/site_nav.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _navItems = [
    NavItem('Work', 'work'),
    NavItem('Expertise', 'expertise'),
    NavItem('Experience', 'experience'),
    NavItem('Contact', 'contact'),
  ];

  final _scrollController = ScrollController();
  final _sectionKeys = {for (final item in _navItems) item.id: GlobalKey()};

  bool _navElevated = false;
  String? _activeId;

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
    final elevated = _scrollController.offset > 8;
    final active = _currentSection();
    if (elevated != _navElevated || active != _activeId) {
      setState(() {
        _navElevated = elevated;
        _activeId = active;
      });
    }
  }

  String? _currentSection() {
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 4) {
      return _navItems.last.id;
    }
    final threshold = MediaQuery.sizeOf(context).height * 0.35;
    String? current;
    for (final item in _navItems) {
      final box = _sectionKeys[item.id]?.currentContext?.findRenderObject();
      if (box is! RenderBox || !box.attached) continue;
      if (box.localToGlobal(Offset.zero).dy <= threshold) current = item.id;
    }
    return current;
  }

  Future<void> _scrollTo(String id) async {
    final duration = context.reduceMotion
        ? Duration.zero
        : const Duration(milliseconds: 600);
    final double offset;
    if (id == 'top') {
      offset = 0;
    } else {
      final box = _sectionKeys[id]?.currentContext?.findRenderObject();
      if (box is! RenderBox) return;
      final navHeight = context.isPhone ? SiteNav.phoneHeight : SiteNav.height;
      offset =
          (_scrollController.offset +
                  box.localToGlobal(Offset.zero).dy -
                  navHeight +
                  1)
              .clamp(0.0, _scrollController.position.maxScrollExtent);
    }
    if (duration == Duration.zero) {
      _scrollController.jumpTo(offset);
    } else {
      await _scrollController.animateTo(
        offset,
        duration: duration,
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      body: Stack(
        children: [
          Positioned.fill(
            child: Scrollbar(
              controller: _scrollController,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    HeroSection(
                      onViewWork: () => _scrollTo('work'),
                      onContact: () => _scrollTo('contact'),
                    ),
                    KeyedSubtree(
                      key: _sectionKeys['work'],
                      child: const ProjectsSection(),
                    ),
                    KeyedSubtree(
                      key: _sectionKeys['expertise'],
                      child: const ExpertiseSection(),
                    ),
                    KeyedSubtree(
                      key: _sectionKeys['experience'],
                      child: const ExperienceSection(),
                    ),
                    KeyedSubtree(
                      key: _sectionKeys['contact'],
                      child: const ContactSection(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SiteNav(
              elevated: _navElevated,
              activeId: _activeId,
              items: _navItems,
              onNavigate: _scrollTo,
            ),
          ),
        ],
      ),
    );
  }
}
