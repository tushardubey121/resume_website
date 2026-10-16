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
            padding: context.pagePadding.copyWith(top: 88, bottom: 88),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FadeInView(
                  child: SectionHeader(
                    eyebrow: 'Selected work',
                    title: 'Apps that made it to the store.',
                    subtitle:
                        'Loyalty, video, IoT, travel, and food — shipped with Flutter.',
                  ),
                ),
                const SizedBox(height: 40),
                for (var i = 0; i < ResumeData.projects.length; i++) ...[
                  FadeInView(
                    delay: Duration(milliseconds: 60 * i),
                    child: _ProjectBlock(
                      project: ResumeData.projects[i],
                      imageOnRight: i.isOdd,
                    ),
                  ),
                  if (i != ResumeData.projects.length - 1)
                    const SizedBox(height: 48),
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

  const _ProjectBlock({
    required this.project,
    required this.imageOnRight,
  });

  @override
  State<_ProjectBlock> createState() => _ProjectBlockState();
}

class _ProjectBlockState extends State<_ProjectBlock> {
  bool _hover = false;

  Future<void> _openStore() async {
    final url = widget.project.playStoreUrl;
    if (url == null) return;
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final compact = context.isCompact;
    final project = widget.project;

    final image = MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedScale(
        scale: _hover ? 1.02 : 1,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
        child: AspectRatio(
          aspectRatio: compact ? 16 / 10 : 16 / 11,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
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
                    errorBuilder: (context, error, stackTrace) =>
                        const Center(
                      child: Icon(
                        Icons.apps,
                        size: 48,
                        color: AppColors.inkSoft,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: 80,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          AppColors.ink.withValues(alpha: 0.35),
                        ],
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
        Text(project.name, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 14),
        Text(
          project.description,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final tag in project.tags)
              Text(
                tag,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.accent,
                      fontSize: 13,
                    ),
              ),
          ],
        ),
        if (project.playStoreUrl != null) ...[
          const SizedBox(height: 22),
          GestureDetector(
            onTap: _openStore,
            child: Text(
              'View on Google Play →',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.ink,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.accent,
                  ),
            ),
          ),
        ],
      ],
    );

    if (compact) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          image,
          const SizedBox(height: 22),
          copy,
        ],
      );
    }

    final children = widget.imageOnRight
        ? [Expanded(child: copy), const SizedBox(width: 40), Expanded(child: image)]
        : [Expanded(child: image), const SizedBox(width: 40), Expanded(child: copy)];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
}
