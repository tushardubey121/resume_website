import 'package:flutter/material.dart';
import 'package:resume_website/data/resume_data.dart';
import 'package:resume_website/theme/app_theme.dart';
import 'package:resume_website/widgets/fade_in_view.dart';
import 'package:resume_website/widgets/section_header.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

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
                    eyebrow: 'Skills',
                    title: 'What I work with every day.',
                  ),
                ),
                SizedBox(height: phone ? 28 : 36),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final columns = phone
                        ? 1
                        : (constraints.maxWidth > 800
                            ? 2
                            : (constraints.maxWidth > 520 ? 2 : 1));
                    return Wrap(
                      spacing: phone ? 0 : 28,
                      runSpacing: phone ? 24 : 28,
                      children: [
                        for (var i = 0; i < ResumeData.skills.length; i++)
                          FadeInView(
                            delay: Duration(milliseconds: 70 * i),
                            child: SizedBox(
                              width: columns == 1
                                  ? constraints.maxWidth
                                  : (constraints.maxWidth - 28) / 2,
                              child: _SkillGroupBlock(
                                group: ResumeData.skills[i],
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SkillGroupBlock extends StatelessWidget {
  final SkillGroup group;

  const _SkillGroupBlock({required this.group});

  @override
  Widget build(BuildContext context) {
    final phone = context.isPhone;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          group.label,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: phone ? 17 : null,
              ),
        ),
        SizedBox(height: phone ? 12 : 14),
        if (phone)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final skill in group.skills)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.foam,
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(
                      color: AppColors.line.withValues(alpha: 0.8),
                    ),
                  ),
                  child: Text(
                    skill,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 13.5,
                          color: AppColors.ink,
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                        ),
                  ),
                ),
            ],
          )
        else
          Text(
            group.skills.join('  ·  '),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  height: 1.7,
                ),
          ),
      ],
    );
  }
}
