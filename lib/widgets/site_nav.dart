import 'package:flutter/material.dart';
import 'package:resume_website/data/resume_data.dart';
import 'package:resume_website/services/resume_service.dart';
import 'package:resume_website/theme/app_theme.dart';
import 'package:resume_website/widgets/common/interactive.dart';
import 'package:resume_website/widgets/common/ui_kit.dart';

class NavItem {
  final String label;
  final String id;

  const NavItem(this.label, this.id);
}

class SiteNav extends StatelessWidget {
  static const double height = 64;
  static const double phoneHeight = 56;

  final bool elevated;
  final String? activeId;
  final ValueChanged<String> onNavigate;
  final List<NavItem> items;

  const SiteNav({
    super.key,
    required this.elevated,
    required this.activeId,
    required this.onNavigate,
    required this.items,
  });

  Future<void> _openMenu(BuildContext context) async {
    final profile = ResumeData.profile;
    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.paper,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(Space.xl, 0, Space.xl, Space.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final item in items)
                Interactive(
                  onTap: () => Navigator.pop(context, item.id),
                  builder: (context, hovered, focused) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: Space.md + 2),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.label,
                            style: context.h3.copyWith(
                              color: item.id == activeId
                                  ? AppColors.accent
                                  : AppColors.ink,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          size: 20,
                          color: AppColors.inkSubtle,
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: Space.lg),
              const Hairline(),
              const SizedBox(height: Space.lg),
              Wrap(
                spacing: Space.xl,
                runSpacing: Space.sm,
                children: [
                  TextLink(label: 'LinkedIn', uri: Uri.parse(profile.linkedInUrl)),
                  TextLink(label: 'GitHub', uri: Uri.parse(profile.githubUrl)),
                  if (ResumeService.instance.url.value != null)
                    TextLink(
                      label: 'Résumé',
                      uri: ResumeService.instance.url.value!,
                      icon: Icons.file_download_outlined,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    if (selected != null) onNavigate(selected);
  }

  @override
  Widget build(BuildContext context) {
    final phone = context.isPhone;
    final compact = context.isCompact;

    return Semantics(
      container: true,
      explicitChildNodes: true,
      child: AnimatedContainer(
        duration: context.reduceMotion ? Duration.zero : Motion.medium,
        curve: Motion.curve,
        decoration: BoxDecoration(
          color: elevated
              ? AppColors.paper.withValues(alpha: 0.96)
              : AppColors.paper.withValues(alpha: 0),
          border: Border(
            bottom: BorderSide(
              color: elevated ? AppColors.line : AppColors.line.withValues(alpha: 0),
            ),
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: context.contentMaxWidth),
              child: SizedBox(
                height: phone ? phoneHeight : height,
                child: Padding(
                  padding: context.pagePadding,
                  child: Row(
                    children: [
                      Flexible(
                        child: Interactive(
                          onTap: () => onNavigate('top'),
                          focusRadius: BorderRadius.circular(4),
                          builder: (context, hovered, focused) => Semantics(
                            label: 'Tushar Dubey, back to top',
                            excludeSemantics: true,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Tushar Dubey',
                                    style: context.h4.copyWith(
                                      fontFamily: AppFonts.display,
                                      fontWeight: FontWeight.w600,
                                      fontSize: phone ? 18 : 19,
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                                  if (!phone)
                                    TextSpan(
                                      text: '   Flutter Engineer',
                                      style: context.monoSmall,
                                    ),
                                ],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (!compact) ...[
                        for (final item in items)
                          Padding(
                            padding: const EdgeInsets.only(left: Space.xs),
                            child: _NavLink(
                              label: item.label,
                              active: item.id == activeId,
                              onTap: () => onNavigate(item.id),
                            ),
                          ),
                        const SizedBox(width: Space.lg),
                        ValueListenableBuilder<Uri?>(
                          valueListenable: ResumeService.instance.url,
                          builder: (context, resume, _) => resume == null
                              ? AppButton(
                                  label: 'Contact',
                                  dense: true,
                                  variant: ButtonVariant.secondary,
                                  onTap: () => onNavigate('contact'),
                                )
                              : AppButton(
                                  label: 'Résumé',
                                  icon: Icons.file_download_outlined,
                                  dense: true,
                                  variant: ButtonVariant.secondary,
                                  uri: resume,
                                ),
                        ),
                      ] else
                        Interactive(
                          onTap: () => _openMenu(context),
                          tooltip: 'Menu',
                          builder: (context, hovered, focused) => Semantics(
                            label: 'Open navigation menu',
                            child: Container(
                              width: 44,
                              height: 44,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: hovered ? AppColors.sunken : Colors.transparent,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Icon(
                                Icons.menu_rounded,
                                size: 24,
                                color: AppColors.ink,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavLink({required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Interactive(
      onTap: onTap,
      focusRadius: BorderRadius.circular(4),
      builder: (context, hovered, focused) {
        final color = active || hovered ? AppColors.ink : AppColors.inkSubtle;
        return Semantics(
          selected: active,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: context.button.copyWith(
                    color: color,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.5,
                  ),
                ),
                const SizedBox(height: 4),
                AnimatedContainer(
                  duration: context.reduceMotion ? Duration.zero : Motion.fast,
                  height: 1.5,
                  width: active ? 18 : 0,
                  color: AppColors.accent,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
