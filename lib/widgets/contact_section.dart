import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resume_website/data/resume_data.dart';
import 'package:resume_website/services/resume_service.dart';
import 'package:resume_website/theme/app_theme.dart';
import 'package:resume_website/widgets/common/interactive.dart';
import 'package:resume_website/widgets/common/ui_kit.dart';
import 'package:resume_website/widgets/section_header.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = ResumeData.profile;
    final phone = context.isPhone;

    return PageSection(
      background: AppColors.night,
      padding: context.sectionPadding.copyWith(bottom: Space.x2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            index: '04',
            label: 'Contact',
            title: 'Hiring for a senior mobile role? Let’s talk.',
            intro:
                'I’m based in Mumbai and open to senior Flutter and mobile '
                'engineering roles. Email is the fastest way to reach me.',
            onDark: true,
          ),
          SizedBox(height: context.sectionGap),
          Padding(
            padding: EdgeInsets.only(
              left: context.isCompact ? 0 : context.railWidth,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _EmailRow(email: profile.email),
                const SizedBox(height: Space.x2),
                Wrap(
                  spacing: Space.md,
                  runSpacing: Space.md,
                  children: [
                    AppButton(
                      label: 'LinkedIn',
                      icon: Icons.north_east_rounded,
                      variant: ButtonVariant.onDark,
                      uri: Uri.parse(profile.linkedInUrl),
                    ),
                    AppButton(
                      label: 'GitHub',
                      icon: Icons.north_east_rounded,
                      variant: ButtonVariant.onDark,
                      uri: Uri.parse(profile.githubUrl),
                    ),
                    ValueListenableBuilder<Uri?>(
                      valueListenable: ResumeService.instance.url,
                      builder: (context, resume, _) => resume == null
                          ? const SizedBox.shrink()
                          : AppButton(
                              label: 'Résumé (PDF)',
                              icon: Icons.file_download_outlined,
                              variant: ButtonVariant.onDark,
                              uri: resume,
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: phone ? Space.x4 : Space.x5),
          const Hairline(color: AppColors.nightLine),
          const SizedBox(height: Space.xl),
          const _Footer(),
        ],
      ),
    );
  }
}

class _EmailRow extends StatelessWidget {
  final String email;

  const _EmailRow({required this.email});

  Future<void> _copy(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: email));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Email address copied'),
          duration: Duration(seconds: 2),
          width: 260,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final size = context.isPhone ? 22.0 : (context.isCompact ? 30.0 : 38.0);
    return Wrap(
      spacing: Space.md,
      runSpacing: Space.sm,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ExternalLink(
          uri: Uri.parse('mailto:$email'),
          newTab: false,
          focusColor: AppColors.nightAccent,
          builder: (context, hovered, focused) => Text(
            email,
            style: context.h2.copyWith(
              fontSize: size,
              color: hovered ? AppColors.nightAccent : AppColors.nightText,
              decoration: TextDecoration.underline,
              decorationColor: hovered
                  ? AppColors.nightAccent
                  : AppColors.nightText.withValues(alpha: 0.3),
              decorationThickness: 1.2,
            ),
          ),
        ),
        Interactive(
          onTap: () => _copy(context),
          tooltip: 'Copy email address',
          focusColor: AppColors.nightAccent,
          builder: (context, hovered, focused) => Semantics(
            label: 'Copy email address',
            child: AnimatedContainer(
              duration: Motion.fast,
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: hovered ? AppColors.nightRaised : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.nightLine),
              ),
              child: const Icon(
                Icons.content_copy_rounded,
                size: 18,
                color: AppColors.nightMuted,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    final profile = ResumeData.profile;
    final style = context.monoSmall.copyWith(color: AppColors.nightMuted);
    return SizedBox(
      width: double.infinity,
      child: Wrap(
      alignment: WrapAlignment.spaceBetween,
      spacing: Space.xl,
      runSpacing: Space.md,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text('© ${DateTime.now().year} ${profile.name}', style: style),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: Text('Designed and built with Flutter Web.  ', style: style)),
            TextLink(
              label: 'Source',
              uri: Uri.parse(profile.sourceUrl),
              style: style,
              color: AppColors.nightMuted,
              hoverColor: AppColors.nightAccent,
            ),
          ],
        ),
      ],
      ),
    );
  }
}
