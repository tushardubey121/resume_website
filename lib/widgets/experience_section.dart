import 'package:flutter/material.dart';
import 'package:resume_website/data/resume_data.dart';
import 'package:resume_website/theme/app_theme.dart';
import 'package:resume_website/widgets/common/ui_kit.dart';
import 'package:resume_website/widgets/section_header.dart';

const _months = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

String _formatMonth(DateTime d) => '${_months[d.month - 1]} ${d.year}';

String _duration(DateTime start, DateTime? end) {
  final to = end ?? DateTime.now();
  final total = (to.year - start.year) * 12 + to.month - start.month;
  final years = total ~/ 12;
  final months = total % 12;
  final parts = [
    if (years > 0) '$years yr${years == 1 ? '' : 's'}',
    if (months > 0) '$months mo${months == 1 ? '' : 's'}',
  ];
  return parts.isEmpty ? '1 mo' : parts.join(' ');
}

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = ResumeData.experience;
    final edu = ResumeData.education;

    return PageSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            index: '03',
            label: 'Experience',
            title: 'From agency projects to a production fintech platform.',
          ),
          SizedBox(height: context.sectionGap),
          for (final item in items) ...[
            const Hairline(),
            _Row(
              rail: _Rail(
                primary: '${_formatMonth(item.start)} — '
                    '${item.end == null ? 'Present' : _formatMonth(item.end!)}',
                secondary: _duration(item.start, item.end),
              ),
              child: _Role(item: item),
            ),
          ],
          const Hairline(),
          _Row(
            rail: _Rail(primary: edu.year, secondary: 'Education'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Heading(edu.degree, level: 3, style: context.h3),
                const SizedBox(height: Space.xs),
                Text(edu.school, style: context.body),
              ],
            ),
          ),
          const Hairline(),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final Widget rail;
  final Widget child;

  const _Row({required this.rail, required this.child});

  @override
  Widget build(BuildContext context) {
    final vertical = context.isPhone ? Space.xl + 4 : Space.x2 + 4;
    if (context.isCompact) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: vertical),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [rail, const SizedBox(height: Space.md), child],
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vertical),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: context.railWidth,
            child: Padding(
              padding: const EdgeInsets.only(top: 6, right: Space.xl),
              child: rail,
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _Rail extends StatelessWidget {
  final String primary;
  final String secondary;

  const _Rail({required this.primary, required this.secondary});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(primary, style: context.mono.copyWith(color: AppColors.ink)),
        const SizedBox(height: 2),
        Text(secondary, style: context.monoSmall),
      ],
    );
  }
}

class _Role extends StatelessWidget {
  final ExperienceItem item;

  const _Role({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Heading(item.role, level: 3, style: context.h3),
        const SizedBox(height: Space.xs),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: item.company,
                style: context.h4.copyWith(color: AppColors.accent),
              ),
              TextSpan(text: '   ${item.companyContext}', style: context.bodySmall),
            ],
          ),
        ),
        const SizedBox(height: Space.lg + 2),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: BulletList(item.highlights),
        ),
      ],
    );
  }
}
