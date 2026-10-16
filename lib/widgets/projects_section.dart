import 'package:flutter/material.dart';
import 'package:resume_website/data/resume_data.dart';
import 'package:resume_website/theme/app_theme.dart';
import 'package:resume_website/widgets/fade_in_view.dart';
import 'package:resume_website/widgets/section_header.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.foam,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: context.contentMaxWidth),
          child: Padding(
            padding: context.sectionPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FadeInView(
                  child: SectionHeader(
                    eyebrow: 'Selected work',
                    title: 'Apps that made it to the store.',
                    subtitle: 'BFSI, IoT, video call, loyalty, travel, and food — shipped with Flutter.',
                  ),
                ),
                SizedBox(height: context.sectionGap),
                for (var i = 0; i < ResumeData.projects.length; i++) ...[
                  FadeInView(
                    delay: Duration(milliseconds: 60 * i),
                    child: _ProjectBlock(project: ResumeData.projects[i], imageOnRight: i.isOdd),
                  ),
                  if (i != ResumeData.projects.length - 1) SizedBox(height: context.blockGap),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProjectBlock extends StatefulWidget {
  final ProjectItem project;
  final bool imageOnRight;

  const _ProjectBlock({required this.project, required this.imageOnRight});

  @override
  State<_ProjectBlock> createState() => _ProjectBlockState();
}

class _ProjectBlockState extends State<_ProjectBlock> {
  bool _hover = false;

  Future<void> _openUrl(String? url) async {
    if (url == null) return;
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final phone = context.isPhone;
    final compact = context.isCompact;
    final project = widget.project;

    final image = MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedScale(
        scale: _hover && !phone ? 1.02 : 1,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
        child: AspectRatio(
          aspectRatio: phone ? 16 / 10 : (compact ? 16 / 10 : 16 / 11),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(phone ? 4 : 6),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ColoredBox(
                  color: AppColors.mistDeep,
                  child: Image.asset(
                    project.imageAsset,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.apps, size: 48, color: AppColors.inkSoft)),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: phone ? 56 : 80,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, AppColors.ink.withValues(alpha: 0.35)],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    final copy = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(project.name, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: phone ? 20 : null)),
        SizedBox(height: phone ? 10 : 14),
        Text(
          project.description,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: phone ? 15 : null, height: phone ? 1.55 : null),
        ),
        SizedBox(height: phone ? 14 : 18),
        Wrap(
          spacing: phone ? 6 : 8,
          runSpacing: phone ? 6 : 8,
          children: [
            for (final tag in project.tags)
              Container(
                padding: EdgeInsets.symmetric(horizontal: phone ? 8 : 0, vertical: phone ? 4 : 0),
                decoration: phone ? BoxDecoration(color: AppColors.mist, borderRadius: BorderRadius.circular(2)) : null,
                child: Text(
                  tag,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: AppColors.accent, fontSize: phone ? 12 : 13, fontWeight: FontWeight.w600),
                ),
              ),
          ],
        ),
        if (project.playStoreUrl != null || project.websiteUrl != null) ...[
          SizedBox(height: phone ? 16 : 22),
          Wrap(
            spacing: 20,
            runSpacing: 10,
            children: [
              if (project.playStoreUrl != null)
                GestureDetector(
                  onTap: () => _openUrl(project.playStoreUrl),
                  child: Text(
                    phone ? 'Google Play →' : 'View on Google Play →',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.ink,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.accent,
                      fontSize: phone ? 13 : null,
                    ),
                  ),
                ),
              if (project.websiteUrl != null)
                GestureDetector(
                  onTap: () => _openUrl(project.websiteUrl),
                  child: Text(
                    'Visit website →',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.ink,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.accent,
                      fontSize: phone ? 13 : null,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ],
    );

    if (compact) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          image,
          SizedBox(height: phone ? 16 : 22),
          copy,
        ],
      );
    }

    final children = widget.imageOnRight
        ? [Expanded(child: copy), const SizedBox(width: 40), Expanded(child: image)]
        : [Expanded(child: image), const SizedBox(width: 40), Expanded(child: copy)];

    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: children);
  }
}
