import 'package:flutter/material.dart';
import 'package:resume_website/data/resume_data.dart';
import 'package:resume_website/theme/app_theme.dart';
import 'package:resume_website/widgets/fade_in_view.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _launch(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final profile = ResumeData.profile;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0B3D3A),
            Color(0xFF0F766E),
          ],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: context.contentMaxWidth),
          child: Padding(
            padding: context.pagePadding.copyWith(top: 96, bottom: 72),
            child: FadeInView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Let us build something.',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: AppColors.white,
                        ),
                  ),
                  const SizedBox(height: 16),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 520),
                    child: Text(
                      'Open to conversations about Flutter products, migrations, and mobile leadership roles.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.white.withValues(alpha: 0.85),
                          ),
                    ),
                  ),
                  const SizedBox(height: 36),
                  _ContactLink(
                    label: profile.email,
                    onTap: () => _launch('mailto:${profile.email}'),
                  ),
                  const SizedBox(height: 12),
                  _ContactLink(
                    label: profile.phone,
                    onTap: () => _launch('tel:${profile.phone.replaceAll(' ', '')}'),
                  ),
                  const SizedBox(height: 12),
                  _ContactLink(
                    label: 'LinkedIn',
                    onTap: () => _launch(profile.linkedInUrl),
                  ),
                  const SizedBox(height: 56),
                  Text(
                    '© ${DateTime.now().year} ${profile.name}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.white.withValues(alpha: 0.55),
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ContactLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _ContactLink({required this.label, required this.onTap});

  @override
  State<_ContactLink> createState() => _ContactLinkState();
}

class _ContactLinkState extends State<_ContactLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(
          widget.label,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.white,
                decoration: TextDecoration.underline,
                decorationColor: _hover
                    ? AppColors.accentSoft
                    : AppColors.white.withValues(alpha: 0.4),
              ),
        ),
      ),
    );
  }
}
