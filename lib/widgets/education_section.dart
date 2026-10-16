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

    return Container(
      width: double.infinity,
      color: AppColors.foam,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: context.contentMaxWidth),
          child: Padding(
            padding: context.pagePadding.copyWith(top: 72, bottom: 72),
            child: FadeInView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                    eyebrow: 'Education',
                    title: 'Foundations.',
                  ),
                  const SizedBox(height: 24),
                  Text(edu.degree, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(
                    '${edu.school}  ·  ${edu.year}',
                    style: Theme.of(context).textTheme.bodyLarge,
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
