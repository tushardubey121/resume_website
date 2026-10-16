import 'package:flutter/material.dart';
import 'package:resume_website/data/resume_data.dart';
import 'package:resume_website/theme/app_theme.dart';
import 'package:resume_website/widgets/fade_in_view.dart';
import 'package:resume_website/widgets/section_header.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final edu = ResumeData.education;
    final phone = context.isPhone;

    return Container(
      width: double.infinity,
      color: AppColors.foam,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: context.contentMaxWidth),
          child: Padding(
            padding: context.pagePadding.copyWith(
              top: phone ? 48 : 72,
              bottom: phone ? 48 : 72,
            ),
            child: FadeInView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                    eyebrow: 'Education',
                    title: 'Foundations.',
                  ),
                  SizedBox(height: phone ? 18 : 24),
                  Text(
                    edu.degree,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: phone ? 17 : null,
                        ),
                  ),
                  SizedBox(height: phone ? 6 : 8),
                  Text(
                    phone
                        ? '${edu.school}\n${edu.year}'
                        : '${edu.school}  ·  ${edu.year}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: phone ? 15 : null,
                          height: phone ? 1.45 : null,
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
