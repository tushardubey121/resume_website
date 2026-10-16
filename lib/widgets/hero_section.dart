import 'package:flutter/material.dart';
import 'package:resume_website/data/resume_data.dart';
import 'package:resume_website/services/resume_service.dart';
import 'package:resume_website/theme/app_theme.dart';
import 'package:resume_website/widgets/common/ui_kit.dart';
import 'package:resume_website/widgets/fade_in_view.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onViewWork;
  final VoidCallback onContact;

  const HeroSection({
    super.key,
    required this.onViewWork,
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    final profile = ResumeData.profile;
    final phone = context.isPhone;
    final years = profile.yearsOfExperience;
    final topInset = phone ? 104.0 : 152.0;

    return PageSection(
      padding: context.pagePadding.copyWith(
        top: topInset,
        bottom: phone ? Space.x3 : Space.x4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (profile.availability != null)
            FadeInView(child: _Availability(profile.availability!)),
          SizedBox(height: phone ? Space.xl : Space.x2),
          FadeInView(
            delay: const Duration(milliseconds: 60),
            child: Text(
              '${profile.role.toUpperCase()} — ${profile.location.toUpperCase()}',
              style: context.eyebrow,
            ),
          ),
          const SizedBox(height: Space.lg),
          FadeInView(
            delay: const Duration(milliseconds: 120),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Heading(
                'Production Flutter apps for banking, payments and connected devices.',
                level: 1,
                style: context.display,
              ),
            ),
          ),
          SizedBox(height: phone ? Space.xl : Space.x2),
          FadeInView(
            delay: const Duration(milliseconds: 200),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 660),
              child: Text(
                'I’m ${profile.name}, a Flutter engineer with $years+ years of '
                'shipping Android, iOS and web apps. At Spice Money I build the '
                'Adhikari agent app and B2B portal (AePS, BBPS bill payments, '
                'eKYC and insurance) and migrated two production web portals '
                'to Flutter.',
                style: context.lead,
              ),
            ),
          ),
          SizedBox(height: phone ? Space.x2 : Space.x3 - Space.sm),
          FadeInView(
            delay: const Duration(milliseconds: 280),
            child: _Actions(onViewWork: onViewWork, onContact: onContact),
          ),
          SizedBox(height: phone ? Space.x3 : Space.x4 + Space.lg),
          FadeInView(
            delay: const Duration(milliseconds: 360),
            child: _SpecStrip(years: years, since: profile.careerStart.year),
          ),
        ],
      ),
    );
  }
}

class _Availability extends StatelessWidget {
  final String text;

  const _Availability(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 6, 12, 6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppColors.line),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              color: AppColors.available,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: Space.sm),
          Flexible(
            child: Text(
              text,
              style: context.bodySmall.copyWith(
                color: AppColors.inkMuted,
                fontWeight: FontWeight.w500,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Actions extends StatelessWidget {
  final VoidCallback onViewWork;
  final VoidCallback onContact;

  const _Actions({required this.onViewWork, required this.onContact});

  @override
  Widget build(BuildContext context) {
    final profile = ResumeData.profile;
    return Wrap(
      spacing: Space.xl,
      runSpacing: Space.lg,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Wrap(
          spacing: Space.md,
          runSpacing: Space.md,
          children: [
            AppButton(
              label: 'View selected work',
              icon: Icons.south_rounded,
              onTap: onViewWork,
            ),
            ValueListenableBuilder<Uri?>(
              valueListenable: ResumeService.instance.url,
              builder: (context, resume, _) => resume == null
                  ? AppButton(
                      label: 'Get in touch',
                      variant: ButtonVariant.secondary,
                      onTap: onContact,
                    )
                  : AppButton(
                      label: 'Download résumé',
                      icon: Icons.file_download_outlined,
                      variant: ButtonVariant.secondary,
                      uri: resume,
                    ),
            ),
          ],
        ),
        Wrap(
          spacing: Space.xl,
          runSpacing: Space.sm,
          children: [
            TextLink(label: 'LinkedIn', uri: Uri.parse(profile.linkedInUrl)),
            TextLink(label: 'GitHub', uri: Uri.parse(profile.githubUrl)),
            TextLink(
              label: 'Email',
              uri: Uri.parse('mailto:${profile.email}'),
              icon: Icons.mail_outline_rounded,
              newTab: false,
            ),
          ],
        ),
      ],
    );
  }
}

/// Verified facts only. No counters, no invented metrics.
class _SpecStrip extends StatelessWidget {
  final int years;
  final int since;

  const _SpecStrip({required this.years, required this.since});

  @override
  Widget build(BuildContext context) {
    final facts = [
      Fact(label: 'Experience', value: '$years+ years', detail: 'Flutter since $since'),
      const Fact(label: 'Currently', value: 'Spice Money', detail: 'Associate Manager'),
      const Fact(
        label: 'Platforms',
        value: 'Android · iOS · Web',
        detail: 'Kotlin and Swift for native work',
      ),
      const Fact(
        label: 'Domains',
        value: 'Fintech · IoT · Commerce',
        detail: 'Banking, BLE, loyalty, travel',
      ),
    ];

    return Column(
      children: [
        const Hairline(),
        const SizedBox(height: Space.xl),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth < 330
                ? 1
                : (constraints.maxWidth < 860 ? 2 : 4);
            const gap = Space.xl;
            final width =
                (constraints.maxWidth - gap * (columns - 1)) / columns;
            return Wrap(
              spacing: gap,
              runSpacing: Space.xl,
              children: [
                for (final f in facts) SizedBox(width: width, child: f),
              ],
            );
          },
        ),
      ],
    );
  }
}
