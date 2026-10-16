import 'package:flutter/material.dart';
import 'package:resume_website/data/resume_data.dart';
import 'package:resume_website/theme/app_theme.dart';
import 'package:resume_website/widgets/fade_in_view.dart';
import 'package:resume_website/widgets/section_header.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final phone = context.isPhone;

    return Container(
      width: double.infinity,
      color: AppColors.mist,
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
                    eyebrow: 'Experience',
                    title: 'Where I have been shipping.',
                    subtitle:
                        'From consulting engagements to leading Flutter migrations at scale.',
                  ),
                ),
                SizedBox(height: context.sectionGap),
                for (var i = 0; i < ResumeData.experience.length; i++) ...[
                  FadeInView(
                    delay: Duration(milliseconds: 80 * i),
                    child: _ExperienceRow(item: ResumeData.experience[i]),
                  ),
                  if (i != ResumeData.experience.length - 1)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: phone ? 22 : 28),
                      child: const Divider(color: AppColors.line, height: 1),
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
    final phone = context.isPhone;
    final compact = context.isCompact;

    final meta = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.role,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: phone ? 18 : null,
              ),
        ),
        SizedBox(height: phone ? 4 : 6),
        Text(
          item.company,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.accent,
                fontSize: phone ? 15 : null,
              ),
        ),
        SizedBox(height: phone ? 4 : 6),
        Text(
          item.period,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: phone ? 13 : null,
              ),
        ),
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
                padding: EdgeInsets.only(top: phone ? 7 : 9),
                child: Container(
                  width: phone ? 5 : 6,
                  height: phone ? 5 : 6,
                  decoration: const BoxDecoration(
                    color: AppColors.accentSoft,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              SizedBox(width: phone ? 10 : 12),
              Expanded(
                child: Text(
                  point,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: phone ? 14.5 : null,
                        height: phone ? 1.5 : null,
                      ),
                ),
              ),
            ],
          ),
          SizedBox(height: phone ? 10 : 12),
        ],
      ],
    );

    if (compact) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (phone)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
              decoration: BoxDecoration(
                color: AppColors.foam,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: AppColors.line.withValues(alpha: 0.7)),
              ),
              child: meta,
            )
          else
            meta,
          SizedBox(height: phone ? 16 : 18),
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
