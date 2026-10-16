import 'package:flutter/material.dart';
import 'package:resume_website/data/resume_data.dart';
import 'package:resume_website/theme/app_theme.dart';
import 'package:resume_website/widgets/fade_in_view.dart';
import 'package:resume_website/widgets/section_header.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = ResumeData.profile;
    final phone = context.isPhone;

    return Container(
      width: double.infinity,
      color: AppColors.foam,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: context.contentMaxWidth),
          child: Padding(
            padding: context.sectionPadding,
            child: FadeInView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                    eyebrow: 'About',
                    title: 'Building products that people actually use.',
                  ),
                  SizedBox(height: phone ? 20 : 28),
                  Text(
                    profile.summary,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: phone ? 15.5 : (context.isCompact ? 17 : 19),
                          height: phone ? 1.6 : 1.65,
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
