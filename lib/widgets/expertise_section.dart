import 'package:flutter/material.dart';
import 'package:resume_website/data/resume_data.dart';
import 'package:resume_website/theme/app_theme.dart';
import 'package:resume_website/widgets/common/ui_kit.dart';
import 'package:resume_website/widgets/section_header.dart';

class ExpertiseSection extends StatelessWidget {
  const ExpertiseSection({super.key});

  @override
  Widget build(BuildContext context) {
    return PageSection(
      background: AppColors.sunken,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            index: '02',
            label: 'Expertise',
            title: 'What I bring to a mobile team.',
            intro:
                'Each area is backed by production work shown on this page, '
                'with the projects where you can see it.',
          ),
          SizedBox(height: context.sectionGap),
          const _ExpertiseGrid(),
          SizedBox(height: context.sectionGap),
          const _Toolbox(),
        ],
      ),
    );
  }
}

class _ExpertiseGrid extends StatelessWidget {
  const _ExpertiseGrid();

  @override
  Widget build(BuildContext context) {
    final items = ResumeData.expertise;
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth < 560
            ? 1
            : (constraints.maxWidth < 900 ? 2 : 3);
        final gapX = context.isDesktop ? Space.x3 : Space.x2;
        final width = (constraints.maxWidth - gapX * (columns - 1)) / columns;
        return Wrap(
          spacing: gapX,
          runSpacing: context.isPhone ? Space.x2 : Space.x3,
          children: [
            for (var i = 0; i < items.length; i++)
              SizedBox(
                width: width,
                child: _ExpertiseItem(index: i + 1, area: items[i]),
              ),
          ],
        );
      },
    );
  }
}

class _ExpertiseItem extends StatelessWidget {
  final int index;
  final ExpertiseArea area;

  const _ExpertiseItem({required this.index, required this.area});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(height: 2, width: 28, color: AppColors.accent),
        const SizedBox(height: Space.lg),
        Text(index.toString().padLeft(2, '0'), style: context.mono),
        const SizedBox(height: Space.xs),
        Heading(area.title, level: 3, style: context.h4),
        const SizedBox(height: Space.sm),
        Text(area.description, style: context.body),
        const SizedBox(height: Space.md),
        Text(
          'Seen in: ${area.evidence.join(' · ')}',
          style: context.monoSmall.copyWith(color: AppColors.inkSubtle),
        ),
      ],
    );
  }
}

class _Toolbox extends StatelessWidget {
  const _Toolbox();

  @override
  Widget build(BuildContext context) {
    final compact = context.isCompact;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.paper,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.line),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: context.isPhone ? Space.lg + 4 : Space.x2,
        vertical: Space.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Space.sm),
            child: Heading('Toolbox', level: 3, style: context.h4),
          ),
          for (final group in ResumeData.toolbox) ...[
            const Hairline(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Space.md + 2),
              child: compact
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          group.label.toUpperCase(),
                          style: context.eyebrow.copyWith(
                            color: AppColors.inkSubtle,
                          ),
                        ),
                        const SizedBox(height: Space.xs + 2),
                        Text(
                          group.items.join('  ·  '),
                          style: context.body.copyWith(color: AppColors.ink),
                        ),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: context.railWidth - Space.x2,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Text(
                              group.label.toUpperCase(),
                              style: context.eyebrow.copyWith(
                                color: AppColors.inkSubtle,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            group.items.join('  ·  '),
                            style: context.body.copyWith(color: AppColors.ink),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ],
      ),
    );
  }
}
