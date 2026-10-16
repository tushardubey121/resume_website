import 'dart:math' as math;

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
                  TextLink(
                    label: 'LinkedIn',
                    uri: Uri.parse(profile.linkedInUrl),
                  ),
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
              color: elevated
                  ? AppColors.line
                  : AppColors.line.withValues(alpha: 0),
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
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
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
                      ),
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
                        _MenuButton(onOpen: () => _openMenu(context)),
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

/// Two-line menu glyph that morphs into a close mark while the menu sheet is
/// open. The short lower line extends on hover or focus.
class _MenuButton extends StatefulWidget {
  final Future<void> Function() onOpen;

  const _MenuButton({required this.onOpen});

  @override
  State<_MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<_MenuButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: Motion.medium,
  );
  bool _open = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _toggle() async {
    if (_open) return;
    final reduce = context.reduceMotion;
    setState(() => _open = true);
    reduce ? _controller.value = 1 : _controller.forward();
    await widget.onOpen();
    if (!mounted) return;
    setState(() => _open = false);
    reduce ? _controller.value = 0 : _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final fast = context.reduceMotion ? Duration.zero : Motion.fast;

    return Interactive(
      onTap: _toggle,
      focusRadius: BorderRadius.circular(24),
      builder: (context, hovered, focused) {
        final active = hovered || focused || _open;
        return Semantics(
          label: _open ? 'Close navigation menu' : 'Open navigation menu',
          expanded: _open,
          excludeSemantics: true,
          child: AnimatedContainer(
            duration: fast,
            curve: Motion.curve,
            height: 40,
            padding: const EdgeInsets.only(left: 14, right: 12),
            decoration: BoxDecoration(
              color: active ? AppColors.surface : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: active ? AppColors.lineStrong : AppColors.line,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedSize(
                  duration: fast,
                  curve: Motion.curve,
                  child: AnimatedSwitcher(
                    duration: fast,
                    child: Text(
                      _open ? 'CLOSE' : 'MENU',
                      key: ValueKey(_open),
                      style: context.monoSmall.copyWith(
                        color: AppColors.ink,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                TweenAnimationBuilder<double>(
                  tween: Tween(end: hovered || focused ? 1 : 0),
                  duration: fast,
                  curve: Motion.curve,
                  builder: (context, extend, _) => AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) => _Glyph(
                      progress: Motion.curve.transform(_controller.value),
                      extend: extend,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Glyph extends StatelessWidget {
  static const double _size = 18;
  static const double _gap = 6;
  static const double _stroke = 1.75;

  /// 0 = menu lines, 1 = close mark.
  final double progress;

  /// 0 = short lower line, 1 = full width.
  final double extend;

  const _Glyph({required this.progress, required this.extend});

  Widget _line(double width, double dy, double angle) => Transform.translate(
    offset: Offset(0, dy),
    child: Transform.rotate(
      angle: angle,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: width,
          height: _stroke,
          decoration: BoxDecoration(
            color: AppColors.ink,
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final dy = _gap / 2 * (1 - progress);
    final angle = math.pi / 4 * progress;
    final lower = 0.6 + 0.4 * math.max(extend, progress);

    return SizedBox(
      width: _size,
      height: _size,
      child: Stack(
        children: [_line(_size, -dy, angle), _line(_size * lower, dy, -angle)],
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavLink({
    required this.label,
    required this.active,
    required this.onTap,
  });

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
