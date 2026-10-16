import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resume_website/theme/app_theme.dart';

class NavItem {
  final String label;
  final String id;

  const NavItem(this.label, this.id);
}

class SiteNav extends StatelessWidget {
  final bool elevated;
  final ValueChanged<String> onNavigate;
  final List<NavItem> items;

  const SiteNav({
    super.key,
    required this.elevated,
    required this.onNavigate,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final compact = context.isCompact;
    final onDark = !elevated;
    final brandColor = onDark ? AppColors.white : AppColors.ink;
    final linkColor = onDark
        ? AppColors.white.withValues(alpha: 0.72)
        : AppColors.inkSoft;
    final hoverColor = onDark ? AppColors.white : AppColors.accent;
    final menuIconColor = onDark ? AppColors.white : AppColors.ink;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: elevated
            ? AppColors.foam.withValues(alpha: 0.94)
            : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: elevated ? AppColors.line : Colors.transparent,
          ),
        ),
        boxShadow: elevated
            ? [
                BoxShadow(
                  color: AppColors.ink.withValues(alpha: 0.04),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ]
            : null,
      ),
      child: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: context.contentMaxWidth),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.pagePadding.horizontal / 2,
                vertical: 16,
              ),
              child: Row(
                children: [
                  Flexible(
                    child: GestureDetector(
                      onTap: () => onNavigate('hero'),
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 220),
                        style: GoogleFonts.fraunces(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.4,
                          color: brandColor,
                        ),
                        child: const Text(
                          'Tushar Dubey',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  if (!compact)
                    Row(
                      children: [
                        for (final item in items) ...[
                          _NavLink(
                            label: item.label,
                            color: linkColor,
                            hoverColor: hoverColor,
                            onTap: () => onNavigate(item.id),
                          ),
                          const SizedBox(width: 4),
                        ],
                      ],
                    )
                  else
                    PopupMenuButton<String>(
                      tooltip: 'Menu',
                      onSelected: onNavigate,
                      itemBuilder: (context) => [
                        for (final item in items)
                          PopupMenuItem(
                            value: item.id,
                            child: Text(item.label),
                          ),
                      ],
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(Icons.menu_rounded, color: menuIconColor),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final Color color;
  final Color hoverColor;
  final VoidCallback onTap;

  const _NavLink({
    required this.label,
    required this.color,
    required this.hoverColor,
    required this.onTap,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final color = _hover ? widget.hoverColor : widget.color;

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 180),
            style: GoogleFonts.figtree(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.2,
              color: color,
            ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}
