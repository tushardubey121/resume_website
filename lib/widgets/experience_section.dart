import 'package:flutter/material.dart';
import 'package:resume_website/data/resume_data.dart';
import 'package:resume_website/theme/app_theme.dart';
import 'package:resume_website/widgets/fade_in_view.dart';
import 'package:resume_website/widgets/section_header.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.mist,
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
                    eyebrow: 'Experience',
                    title: 'Where I have been shipping.',
                    subtitle:
                        'From consulting engagements to leading Flutter migrations at scale.',
                  ),
                ),
                const SizedBox(height: 40),
                for (var i = 0; i < ResumeData.experience.length; i++) ...[
                  FadeInView(
                    delay: Duration(milliseconds: 80 * i),
                    child: _ExperienceRow(item: ResumeData.experience[i]),
                  ),
                  if (i != ResumeData.experience.length - 1)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 28),
                      child: Divider(color: AppColors.line, height: 1),
                    ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ExperienceRow extends StatelessWidget {
  final ExperienceItem item;

  const _ExperienceRow({required this.item});

  @override
  Widget build(BuildContext context) {
    final compact = context.isCompact;

    final meta = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.role, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 6),
        Text(
          item.company,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.accent,
              ),
        ),
        const SizedBox(height: 6),
        Text(item.period, style: Theme.of(context).textTheme.bodySmall),
      ],
    );

    final bullets = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final point in item.highlights) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 9),
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.accentSoft,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  point,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ],
    );

    if (compact) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          meta,
          const SizedBox(height: 18),
          bullets,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 280, child: meta),
        const SizedBox(width: 40),
        Expanded(child: bullets),
      ],
    );
  }
}
