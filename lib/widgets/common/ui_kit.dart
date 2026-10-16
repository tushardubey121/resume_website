import 'package:flutter/material.dart';
import 'package:resume_website/theme/app_theme.dart';
import 'package:resume_website/widgets/common/interactive.dart';

/// Text exposed to assistive technology as a heading of the given level.
class Heading extends StatelessWidget {
  final String text;
  final int level;
  final TextStyle style;
  final TextAlign? textAlign;

  const Heading(
    this.text, {
    super.key,
    required this.level,
    required this.style,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      headingLevel: level,
      child: Text(text, style: style, textAlign: textAlign),
    );
  }
}

/// Full-bleed band with centred, width-constrained content.
class PageSection extends StatelessWidget {
  final Widget child;
  final Color background;
  final EdgeInsets? padding;

  const PageSection({
    super.key,
    required this.child,
    this.background = AppColors.paper,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: background,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: context.contentMaxWidth),
          child: Padding(
            padding: padding ?? context.sectionPadding,
            child: child,
          ),
        ),
      ),
    );
  }
}

enum ButtonVariant { primary, secondary, onDark }

class AppButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final ButtonVariant variant;
  final VoidCallback? onTap;
  final Uri? uri;
  final bool dense;

  const AppButton({
    super.key,
    required this.label,
    this.icon,
    this.variant = ButtonVariant.primary,
    this.onTap,
    this.uri,
    this.dense = false,
  }) : assert(onTap != null || uri != null);

  Widget _build(BuildContext context, bool hovered, bool focused) {
    final (Color bg, Color fg, Color border) = switch (variant) {
      ButtonVariant.primary => (
          hovered ? AppColors.accentStrong : AppColors.accent,
          AppColors.surface,
          Colors.transparent,
        ),
      ButtonVariant.secondary => (
          hovered ? AppColors.sunken : Colors.transparent,
          AppColors.ink,
          hovered ? AppColors.ink : AppColors.lineStrong,
        ),
      ButtonVariant.onDark => (
          hovered ? AppColors.nightRaised : Colors.transparent,
          AppColors.nightText,
          hovered ? AppColors.nightMuted : AppColors.nightLine,
        ),
    };

    return AnimatedContainer(
      duration: context.reduceMotion ? Duration.zero : Motion.fast,
      curve: Motion.curve,
      constraints: BoxConstraints(minHeight: dense ? 40 : 48),
      padding: EdgeInsets.symmetric(horizontal: dense ? Space.lg : Space.xl),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              label,
              style: context.button.copyWith(
                color: fg,
                fontSize: dense ? 14 : 15,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (icon != null) ...[
            const SizedBox(width: Space.sm),
            Icon(icon, size: dense ? 16 : 18, color: fg),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final focusColor =
        variant == ButtonVariant.onDark ? AppColors.nightAccent : AppColors.focusRing;
    const radius = BorderRadius.all(Radius.circular(9));
    if (uri != null) {
      return ExternalLink(
        uri: uri!,
        focusColor: focusColor,
        focusRadius: radius,
        builder: _build,
      );
    }
    return Interactive(
      onTap: onTap,
      focusColor: focusColor,
      focusRadius: radius,
      builder: _build,
    );
  }
}

/// Underlined inline link with an outward arrow, for external destinations.
class TextLink extends StatelessWidget {
  final String label;
  final Uri uri;
  final Color color;
  final Color hoverColor;
  final IconData icon;
  final TextStyle? style;
  final bool newTab;

  const TextLink({
    super.key,
    required this.label,
    required this.uri,
    this.color = AppColors.ink,
    this.hoverColor = AppColors.accent,
    this.icon = Icons.north_east_rounded,
    this.style,
    this.newTab = true,
  });

  @override
  Widget build(BuildContext context) {
    final base = style ?? context.button;
    return ExternalLink(
      uri: uri,
      newTab: newTab,
      focusRadius: BorderRadius.circular(4),
      builder: (context, hovered, focused) {
        final c = hovered ? hoverColor : color;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: Space.xs),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  label,
                  style: base.copyWith(
                    color: c,
                    decoration: TextDecoration.underline,
                    decorationColor:
                        hovered ? hoverColor : c.withValues(alpha: 0.35),
                    decorationThickness: 1.4,
                  ),
                ),
              ),
              const SizedBox(width: 3),
              Icon(icon, size: (base.fontSize ?? 15) + 1, color: c),
            ],
          ),
        );
      },
    );
  }
}

class Tag extends StatelessWidget {
  final String label;
  final bool onDark;

  const Tag(this.label, {super.key, this.onDark = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: onDark ? AppColors.nightRaised : AppColors.surface,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: onDark ? AppColors.nightLine : AppColors.line),
      ),
      child: Text(
        label,
        style: context.monoSmall.copyWith(
          color: onDark ? AppColors.nightMuted : AppColors.inkMuted,
        ),
      ),
    );
  }
}

class TagWrap extends StatelessWidget {
  final List<String> tags;

  const TagWrap(this.tags, {super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [for (final t in tags) Tag(t)],
    );
  }
}

class BulletList extends StatelessWidget {
  final List<String> items;
  final TextStyle? style;

  const BulletList(this.items, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    final textStyle = style ?? context.body;
    final lineHeight = (textStyle.fontSize ?? 16) * (textStyle.height ?? 1.5);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < items.length; i++)
          Padding(
            padding: EdgeInsets.only(top: i == 0 ? 0 : Space.md),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: lineHeight / 2 - 0.75),
                  child: Container(width: 10, height: 1.5, color: AppColors.accent),
                ),
                const SizedBox(width: Space.md),
                Expanded(child: Text(items[i], style: textStyle)),
              ],
            ),
          ),
      ],
    );
  }
}

/// A small mono label above a value, used for project and hero facts.
class Fact extends StatelessWidget {
  final String label;
  final String value;
  final String? detail;

  const Fact({super.key, required this.label, required this.value, this.detail});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: context.eyebrow.copyWith(color: AppColors.inkSubtle)),
        const SizedBox(height: Space.sm),
        Text(value, style: context.h4),
        if (detail != null) ...[
          const SizedBox(height: 2),
          Text(detail!, style: context.bodySmall),
        ],
      ],
    );
  }
}

class Hairline extends StatelessWidget {
  final Color color;

  const Hairline({super.key, this.color = AppColors.line});

  @override
  Widget build(BuildContext context) => Container(height: 1, color: color);
}
