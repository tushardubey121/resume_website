import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resume_website/theme/app_theme.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

typedef InteractiveBuilder = Widget Function(
  BuildContext context,
  bool hovered,
  bool focused,
);

/// Hover, focus ring, keyboard activation and pointer cursor for any tappable
/// element. Use this instead of a bare GestureDetector.
class Interactive extends StatefulWidget {
  final VoidCallback? onTap;
  final InteractiveBuilder builder;
  final BorderRadius focusRadius;
  final Color focusColor;
  final bool isButton;
  final String? tooltip;

  const Interactive({
    super.key,
    required this.onTap,
    required this.builder,
    this.focusRadius = const BorderRadius.all(Radius.circular(6)),
    this.focusColor = AppColors.focusRing,
    this.isButton = true,
    this.tooltip,
  });

  @override
  State<Interactive> createState() => _InteractiveState();
}

class _InteractiveState extends State<Interactive> {
  bool _hovered = false;
  bool _focused = false;

  static const _shortcuts = <ShortcutActivator, Intent>{
    SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
    SingleActivator(LogicalKeyboardKey.numpadEnter): ActivateIntent(),
    SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
  };

  late final Map<Type, Action<Intent>> _actions = {
    ActivateIntent: CallbackAction<ActivateIntent>(
      onInvoke: (_) {
        widget.onTap?.call();
        return null;
      },
    ),
  };

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onTap != null;
    Widget child = FocusableActionDetector(
      enabled: enabled,
      shortcuts: _shortcuts,
      actions: _actions,
      mouseCursor: enabled ? SystemMouseCursors.click : MouseCursor.defer,
      onShowHoverHighlight: (value) => setState(() => _hovered = value),
      onShowFocusHighlight: (value) => setState(() => _focused = value),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        excludeFromSemantics: !widget.isButton,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            widget.builder(context, _hovered, _focused),
            if (_focused)
              Positioned(
                left: -4,
                top: -4,
                right: -4,
                bottom: -4,
                child: IgnorePointer(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: widget.focusRadius,
                      border: Border.all(color: widget.focusColor, width: 2),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );

    if (widget.isButton) {
      child = Semantics(button: true, enabled: enabled, child: child);
    }
    if (widget.tooltip != null) {
      child = Tooltip(message: widget.tooltip!, child: child);
    }
    return child;
  }
}

/// A real anchor element on the web: works with middle-click, "open in new
/// tab", screen readers and crawlers, unlike a tap handler that calls
/// launchUrl.
class ExternalLink extends StatelessWidget {
  final Uri uri;
  final InteractiveBuilder builder;
  final BorderRadius focusRadius;
  final Color focusColor;
  final bool newTab;

  const ExternalLink({
    super.key,
    required this.uri,
    required this.builder,
    this.focusRadius = const BorderRadius.all(Radius.circular(6)),
    this.focusColor = AppColors.focusRing,
    this.newTab = true,
  });

  @override
  Widget build(BuildContext context) {
    return Link(
      uri: uri,
      target: newTab ? LinkTarget.blank : LinkTarget.self,
      builder: (context, followLink) => Interactive(
        isButton: false,
        focusRadius: focusRadius,
        focusColor: focusColor,
        onTap: followLink ?? () => launchUrl(uri),
        builder: builder,
      ),
    );
  }
}
