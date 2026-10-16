import 'package:flutter/material.dart';
import 'package:resume_website/data/resume_data.dart';
import 'package:resume_website/theme/app_theme.dart';
import 'package:resume_website/widgets/fade_in_view.dart';
import 'package:resume_website/widgets/section_header.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

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
                    eyebrow: 'Skills',
                    title: 'What I work with every day.',
                  ),
                ),
                const SizedBox(height: 36),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final columns = constraints.maxWidth > 800
                        ? 2
                        : (constraints.maxWidth > 520 ? 2 : 1);
                    return Wrap(
                      spacing: 28,
                      runSpacing: 28,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(group.label, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 14),
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
