import 'package:flutter/material.dart';
import 'package:resume_website/theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String? subtitle;

  const SectionHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final phone = context.isPhone;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eyebrow.toUpperCase(),
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.accent,
                letterSpacing: phone ? 1.2 : 1.6,
                fontSize: phone ? 11 : 12,
              ),
        ),
        SizedBox(height: phone ? 10 : 12),
        Text(
          title,
          style: phone
              ? Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontSize: 26,
                    height: 1.15,
                  )
              : context.isCompact
                  ? Theme.of(context).textTheme.headlineMedium
                  : Theme.of(context).textTheme.headlineLarge,
        ),
        if (subtitle != null) ...[
          SizedBox(height: phone ? 10 : 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Text(
              subtitle!,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: phone ? 15 : null,
                    height: phone ? 1.5 : null,
                  ),
            ),
          ),
        ],
      ],
    );
  }
}
