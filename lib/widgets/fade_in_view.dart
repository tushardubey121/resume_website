import 'package:flutter/material.dart';
import 'package:resume_website/theme/app_theme.dart';

class FadeInView extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final Offset offset;

  const FadeInView({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 700),
    this.offset = const Offset(0, 28),
  });

  @override
  State<FadeInView> createState() => _FadeInViewState();
}

class _FadeInViewState extends State<FadeInView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;
  bool _started = false;
  bool _skipAnimation = false;
  ScrollPosition? _position;
  int _attachAttempts = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _slide = Tween<Offset>(begin: widget.offset, end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      // Phone / narrow web: show content immediately so nothing stays blank
      // if scroll/visibility detection fails (common on mobile browsers).
      if (context.isPhone) {
        setState(() => _skipAnimation = true);
        return;
      }
      _attachAndCheck();
    });
  }

  @override
  void dispose() {
    _position?.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() => _checkVisibility();

  void _reveal() {
    if (!mounted || _started) return;
    _started = true;
    _position?.removeListener(_onScroll);
    if (widget.delay == Duration.zero) {
      _controller.forward();
      return;
    }
    Future<void>.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  void _attachAndCheck() {
    if (!mounted || _started || _skipAnimation) return;

    final position = Scrollable.maybeOf(context)?.position;
    if (position != null && position != _position) {
      _position?.removeListener(_onScroll);
      _position = position;
      _position!.addListener(_onScroll);
    }

    _checkVisibility();

    if (!_started && _attachAttempts < 16) {
      _attachAttempts++;
      WidgetsBinding.instance.addPostFrameCallback((_) => _attachAndCheck());
    }
  }

  void _checkVisibility() {
    if (!mounted || _started || _skipAnimation) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;

    final offset = box.localToGlobal(Offset.zero);
    final size = box.size;
    final viewHeight = MediaQuery.sizeOf(context).height;
    final visible =
        offset.dy < viewHeight * 0.98 && (offset.dy + size.height) > -80;

    if (visible) _reveal();
  }

  @override
  Widget build(BuildContext context) {
    if (_skipAnimation) return widget.child;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacity.value,
          child: Transform.translate(
            offset: _slide.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
