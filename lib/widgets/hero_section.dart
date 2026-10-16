import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resume_website/data/resume_data.dart';
import 'package:resume_website/theme/app_theme.dart';
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
    final compact = context.isCompact;
    final height = MediaQuery.sizeOf(context).height;

    return SizedBox(
      width: double.infinity,
      height: math.max(height, compact ? 640.0 : 720.0),
      child: Stack(
        fit: StackFit.expand,
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF071A1C),
                  Color(0xFF0C2E32),
                  Color(0xFF123F42),
                  Color(0xFF0A2A2E),
                ],
                stops: [0.0, 0.35, 0.72, 1.0],
              ),
            ),
          ),
          const Positioned.fill(child: CustomPaint(painter: _HeroMeshPainter())),
          Positioned(
            right: compact ? -80 : -40,
            top: height * 0.12,
            child: IgnorePointer(
              child: Opacity(
                opacity: compact ? 0.07 : 0.11,
                child: Text(
                  'TD',
                  style: GoogleFonts.fraunces(
                    fontSize: compact ? 220 : 340,
                    fontWeight: FontWeight.w600,
                    height: 1,
                    color: AppColors.white,
                    letterSpacing: -12,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 120,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.foam.withValues(alpha: 0.0),
                    AppColors.foam,
                  ],
                  stops: const [0.0, 0.45, 1.0],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: context.contentMaxWidth),
                child: Padding(
                  padding: context.pagePadding.copyWith(
                    top: compact ? 96 : 120,
                    bottom: 88,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: compact ? double.infinity : 640,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FadeInView(
                            child: Text(
                              'FLUTTER  ·  MOBILE  ·  LEADERSHIP',
                              style: GoogleFonts.figtree(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 2.4,
                                color: const Color(0xFF7DD3C7),
                              ),
                            ),
                          ),
                          SizedBox(height: compact ? 22 : 28),
                          FadeInView(
                            delay: const Duration(milliseconds: 80),
                            child: Text(
                              profile.name,
                              style: GoogleFonts.fraunces(
                                fontSize: compact ? 48 : 76,
                                fontWeight: FontWeight.w600,
                                height: 1.02,
                                letterSpacing: -1.6,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: compact ? 20 : 26),
                          FadeInView(
                            delay: const Duration(milliseconds: 160),
                            child: Container(
                              width: 56,
                              height: 2,
                              color: const Color(0xFF2DD4BF),
                            ),
                          ),
                          SizedBox(height: compact ? 20 : 26),
                          FadeInView(
                            delay: const Duration(milliseconds: 220),
                            child: Text(
                              'Flutter apps & portals that ship.',
                              style: GoogleFonts.fraunces(
                                fontSize: compact ? 22 : 28,
                                fontWeight: FontWeight.w500,
                                height: 1.25,
                                color: AppColors.white.withValues(alpha: 0.92),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          FadeInView(
                            delay: const Duration(milliseconds: 280),
                            child: Text(
                              '${profile.title} in ${profile.location}. '
                              'Eight years building Android, iOS, and web products.',
                              style: GoogleFonts.figtree(
                                fontSize: compact ? 16 : 18,
                                height: 1.6,
                                fontWeight: FontWeight.w400,
                                color: AppColors.white.withValues(alpha: 0.68),
                              ),
                            ),
                          ),
                          SizedBox(height: compact ? 36 : 44),
                          FadeInView(
                            delay: const Duration(milliseconds: 360),
                            child: Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                _HeroButton(
                                  label: 'View projects',
                                  filled: true,
                                  onTap: onViewWork,
                                ),
                                _HeroButton(
                                  label: 'Get in touch',
                                  filled: false,
                                  onTap: onContact,
                                ),
                              ],
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
        ],
      ),
    );
  }
}

class _HeroButton extends StatefulWidget {
  final String label;
  final bool filled;
  final VoidCallback onTap;

  const _HeroButton({
    required this.label,
    required this.filled,
    required this.onTap,
  });

  @override
  State<_HeroButton> createState() => _HeroButtonState();
}

class _HeroButtonState extends State<_HeroButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    if (!widget.filled) {
      return MouseRegion(
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 180),
              style: GoogleFonts.figtree(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
                color: _hover
                    ? AppColors.white
                    : AppColors.white.withValues(alpha: 0.78),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.label),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: _hover ? 8 : 4,
                  ),
                  Icon(
                    Icons.arrow_forward,
                    size: 16,
                    color: _hover
                        ? AppColors.white
                        : AppColors.white.withValues(alpha: 0.78),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
          decoration: BoxDecoration(
            color: _hover ? const Color(0xFFF0FDFA) : AppColors.white,
            borderRadius: BorderRadius.circular(2),
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.figtree(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
              color: const Color(0xFF0A2A2E),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroMeshPainter extends CustomPainter {
  const _HeroMeshPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final glow = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 90);
    glow.color = const Color(0xFF14B8A6).withValues(alpha: 0.16);
    canvas.drawCircle(Offset(size.width * 0.78, size.height * 0.28), 260, glow);
    glow.color = const Color(0xFF0F766E).withValues(alpha: 0.12);
    canvas.drawCircle(Offset(size.width * 0.15, size.height * 0.7), 300, glow);

    final hairline = Paint()
      ..color = Colors.white.withValues(alpha: 0.035)
      ..strokeWidth = 1;
    canvas.drawLine(
      Offset(size.width * 0.55, 0),
      Offset(size.width * 0.72, size.height),
      hairline,
    );
    canvas.drawLine(
      Offset(size.width * 0.62, 0),
      Offset(size.width * 0.82, size.height),
      hairline,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
