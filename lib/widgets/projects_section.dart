import 'package:flutter/material.dart';
import 'package:resume_website/data/resume_data.dart';
import 'package:resume_website/theme/app_theme.dart';
import 'package:resume_website/widgets/common/ui_kit.dart';
import 'package:resume_website/widgets/section_header.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final featured = ResumeData.featuredProjects;
    return PageSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            index: '01',
            label: 'Selected work',
            title:
                'Production apps, from regulated banking to connected hardware.',
            intro:
                'Two case studies from my work at Spice Money, followed by apps '
                'I delivered for clients. Images are the products’ own store '
                'artwork and brand marks.',
          ),
          SizedBox(height: context.sectionGap),
          for (var i = 0; i < featured.length; i++) ...[
            _CaseStudy(
              project: featured[i],
              figure: i + 1,
              imageFirst: i.isEven,
            ),
            SizedBox(height: context.isPhone ? Space.x3 : Space.x4 + Space.lg),
          ],
          const _MoreWorkHeader(),
          const SizedBox(height: Space.xl),
          _ProjectGrid(
            projects: ResumeData.moreProjects,
            figureOffset: featured.length + 1,
          ),
        ],
      ),
    );
  }
}

class _MoreWorkHeader extends StatelessWidget {
  const _MoreWorkHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Hairline(),
        const SizedBox(height: Space.xl),
        Heading('More shipped apps', level: 3, style: context.h3),
      ],
    );
  }
}

class _CaseStudy extends StatelessWidget {
  final ProjectItem project;
  final int figure;
  final bool imageFirst;

  const _CaseStudy({
    required this.project,
    required this.figure,
    required this.imageFirst,
  });

  @override
  Widget build(BuildContext context) {
    final plate = _Plate(visual: project.visual, figure: figure);
    final content = _CaseStudyContent(project: project, figure: figure);

    if (context.isCompact) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: context.isPhone ? double.infinity : 460,
            ),
            child: plate,
          ),
          const SizedBox(height: Space.x2),
          content,
        ],
      );
    }

    final gap = context.isDesktop ? Space.x4 : Space.x3;
    final plateCol = Expanded(flex: 5, child: plate);
    final contentCol = Expanded(flex: 6, child: content);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: imageFirst
          ? [plateCol, SizedBox(width: gap), contentCol]
          : [contentCol, SizedBox(width: gap), plateCol],
    );
  }
}

class _CaseStudyContent extends StatelessWidget {
  final ProjectItem project;
  final int figure;

  const _CaseStudyContent({required this.project, required this.figure});

  @override
  Widget build(BuildContext context) {
    final facts = <Widget>[
      Fact(label: 'Built at', value: project.builtAt),
      if (project.period != null) Fact(label: 'Period', value: project.period!),
      if (project.platforms.isNotEmpty)
        Fact(label: 'Platforms', value: project.platforms.join(' · ')),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CASE STUDY ${figure.toString().padLeft(2, '0')} · ${project.category.toUpperCase()}',
          style: context.eyebrow,
        ),
        const SizedBox(height: Space.md),
        Heading(project.name, level: 3, style: context.h2),
        const SizedBox(height: Space.lg),
        Text(project.summary, style: context.lead),
        const SizedBox(height: Space.xl),
        _FactRow(facts: facts),
        if (project.story != null) ...[
          const SizedBox(height: Space.xl),
          Text(project.story!, style: context.body),
        ],
        if (project.contributions.isNotEmpty) ...[
          const SizedBox(height: Space.x2),
          Heading('What I built', level: 4, style: context.h4),
          const SizedBox(height: Space.md),
          BulletList(project.contributions),
        ],
        if (project.outcome != null) ...[
          const SizedBox(height: Space.xl),
          Heading('Outcome', level: 4, style: context.h4),
          const SizedBox(height: Space.sm),
          Text(project.outcome!, style: context.body),
        ],
        if (project.stack.isNotEmpty) ...[
          const SizedBox(height: Space.x2),
          Text(
            'STACK',
            style: context.eyebrow.copyWith(color: AppColors.inkSubtle),
          ),
          const SizedBox(height: Space.md),
          TagWrap(project.stack),
        ],
        if (project.links.isNotEmpty) ...[
          const SizedBox(height: Space.x2),
          _Links(project.links),
        ],
      ],
    );
  }
}

class _FactRow extends StatelessWidget {
  final List<Widget> facts;

  const _FactRow({required this.facts});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: Space.lg),
      decoration: const BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(color: AppColors.line)),
      ),
      child: Wrap(spacing: Space.x2, runSpacing: Space.lg, children: facts),
    );
  }
}

class _Links extends StatelessWidget {
  final List<ProjectLink> links;

  const _Links(this.links);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: Space.xl,
      runSpacing: Space.sm,
      children: [
        for (final l in links) TextLink(label: l.label, uri: Uri.parse(l.url)),
      ],
    );
  }
}

/// A project visual on its brand colour, with an honest figure caption.
class _Plate extends StatelessWidget {
  final ProjectVisual visual;
  final int figure;
  final bool hovered;
  final bool showCaption;
  final BorderRadius radius;

  const _Plate({
    required this.visual,
    required this.figure,
    this.hovered = false,
    this.showCaption = true,
    this.radius = const BorderRadius.all(Radius.circular(8)),
  });

  @override
  Widget build(BuildContext context) {
    final dpr = MediaQuery.devicePixelRatioOf(context);
    final image = LayoutBuilder(
      builder: (context, constraints) {
        final inset = constraints.biggest.shortestSide * visual.inset;
        final cacheWidth = (constraints.maxWidth * dpr).round();
        return Padding(
          padding: EdgeInsets.all(inset),
          child: Image.asset(
            visual.asset,
            fit: visual.fit,
            alignment: visual.alignment,
            width: double.infinity,
            height: double.infinity,
            cacheWidth: visual.fit == BoxFit.cover ? null : cacheWidth,
            filterQuality: FilterQuality.medium,
            semanticLabel: visual.semanticLabel,
            gaplessPlayback: true,
            frameBuilder: (context, child, frame, sync) {
              if (sync || frame != null) return child;
              return const SizedBox.expand();
            },
            errorBuilder: (context, error, stack) => const SizedBox.expand(),
          ),
        );
      },
    );

    final plate = AspectRatio(
      aspectRatio: visual.aspectRatio,
      child: ClipRRect(
        borderRadius: radius,
        child: ColoredBox(
          color: visual.background,
          child: AnimatedScale(
            scale: hovered && !context.reduceMotion ? 1.025 : 1,
            duration: Motion.medium,
            curve: Motion.curve,
            child: image,
          ),
        ),
      ),
    );

    if (!showCaption) return plate;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        plate,
        const SizedBox(height: Space.md),
        ExcludeSemantics(
          child: Text(
            'Fig. ${figure.toString().padLeft(2, '0')} — ${visual.caption}',
            style: context.monoSmall,
          ),
        ),
      ],
    );
  }
}

class _ProjectGrid extends StatelessWidget {
  final List<ProjectItem> projects;
  final int figureOffset;

  const _ProjectGrid({required this.projects, required this.figureOffset});

  @override
  Widget build(BuildContext context) {
    if (context.isPhone) {
      return Column(
        children: [
          for (var i = 0; i < projects.length; i++) ...[
            if (i > 0) const SizedBox(height: Space.xl),
            _ProjectCard(project: projects[i], figure: figureOffset + i),
          ],
        ],
      );
    }

    final gap = context.isDesktop ? Space.x2 : Space.xl;
    final rows = <Widget>[];
    for (var i = 0; i < projects.length; i += 2) {
      if (rows.isNotEmpty) rows.add(SizedBox(height: gap));
      if (i + 1 == projects.length) {
        rows.add(
          _ProjectCard(
            project: projects[i],
            figure: figureOffset + i,
            wide: true,
          ),
        );
        break;
      }
      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _ProjectCard(
                  project: projects[i],
                  figure: figureOffset + i,
                ),
              ),
              SizedBox(width: gap),
              Expanded(
                child: _ProjectCard(
                  project: projects[i + 1],
                  figure: figureOffset + i + 1,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Column(children: rows);
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectItem project;
  final int figure;

  /// Full-width horizontal layout, used for an unpaired last card.
  final bool wide;

  const _ProjectCard({
    required this.project,
    required this.figure,
    this.wide = false,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final pad = context.isPhone ? Space.lg + 4 : Space.xl;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: context.reduceMotion ? Duration.zero : Motion.medium,
        curve: Motion.curve,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _hovered ? AppColors.lineStrong : AppColors.line,
          ),
        ),
        child: widget.wide
            ? _wideLayout(context, pad)
            : _stackedLayout(context, pad),
      ),
    );
  }

  Widget _plate() => Padding(
    padding: const EdgeInsets.all(6),
    child: _Plate(
      visual: widget.project.visual,
      figure: widget.figure,
      hovered: _hovered,
      showCaption: false,
      radius: const BorderRadius.all(Radius.circular(6)),
    ),
  );

  Widget _stackedLayout(BuildContext context, double pad) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _plate(),
        Expanded(
          flex: context.isPhone ? 0 : 1,
          child: Padding(
            padding: EdgeInsets.fromLTRB(pad, Space.lg, pad, pad),
            child: _details(context, fill: !context.isPhone),
          ),
        ),
      ],
    );
  }

  Widget _wideLayout(BuildContext context, double pad) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Align(alignment: Alignment.topCenter, child: _plate()),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(pad, pad, pad + Space.sm, pad),
              child: _details(context, fill: true),
            ),
          ),
        ],
      ),
    );
  }

  Widget _details(BuildContext context, {required bool fill}) {
    final p = widget.project;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(p.category.toUpperCase(), style: context.eyebrow),
        const SizedBox(height: Space.sm),
        Heading(p.name, level: 4, style: context.h3),
        const SizedBox(height: Space.md),
        Text(p.summary, style: context.body),
        const SizedBox(height: Space.lg),
        Text(
          [
            'Built at ${p.builtAt}',
            if (p.platforms.isNotEmpty) p.platforms.join(' · '),
          ].join('  ·  '),
          style: context.monoSmall,
        ),
        if (p.stack.isNotEmpty) ...[
          const SizedBox(height: Space.md),
          TagWrap(p.stack),
        ],
        if (fill) const Spacer(),
        if (p.links.isNotEmpty || p.note != null)
          const SizedBox(height: Space.xl),
        if (p.links.isNotEmpty) _Links(p.links),
        if (p.note != null)
          Text(
            p.note!,
            style: context.bodySmall.copyWith(fontStyle: FontStyle.italic),
          ),
      ],
    );
  }
}
