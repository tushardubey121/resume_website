import 'package:flutter/material.dart';
import 'package:resume_website/theme/app_theme.dart';
import 'package:resume_website/widgets/common/ui_kit.dart';

class SectionHeader extends StatelessWidget {
  final String index;
  final String label;
  final String title;
  final String? intro;
  final bool onDark;

  const SectionHeader({
    super.key,
    required this.index,
    required this.label,
    required this.title,
    this.intro,
    this.onDark = false,
  });

  @override
  Widget build(BuildContext context) {
    final eyebrow = Text(
      '$index — ${label.toUpperCase()}',
      style: context.eyebrow.copyWith(
        color: onDark ? AppColors.nightAccent : AppColors.accent,
      ),
    );

    final body = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Heading(
            title,
            level: 2,
            style: context.h1.copyWith(
              color: onDark ? AppColors.nightText : AppColors.ink,
            ),
          ),
        ),
        if (intro != null) ...[
          const SizedBox(height: Space.lg),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Text(
              intro!,
              style: context.lead.copyWith(
                color: onDark ? AppColors.nightMuted : AppColors.inkMuted,
              ),
            ),
          ),
        ],
      ],
    );

    if (context.isCompact) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          eyebrow,
          const SizedBox(height: Space.lg),
          body,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: context.railWidth,
          child: Padding(
            padding: const EdgeInsets.only(top: 14, right: Space.xl),
            child: eyebrow,
          ),
        ),
        Expanded(child: body),
      ],
    );
  }
}
