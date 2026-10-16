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

  Future<void> _openMenu(BuildContext context) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.foam,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 12, top: 4),
                    decoration: BoxDecoration(
                      color: AppColors.line,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: Text(
                    'Navigate',
                    style: GoogleFonts.fraunces(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.ink,
                    ),
                  ),
                ),
                for (final item in items)
                  ListTile(
                    title: Text(
                      item.label,
                      style: GoogleFonts.figtree(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.ink,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                      color: AppColors.inkSoft,
                    ),
                    onTap: () => Navigator.pop(context, item.id),
                  ),
              ],
            ),
          ),
        );
      },
    );
    if (selected != null) onNavigate(selected);
  }

  @override
  Widget build(BuildContext context) {
    final phone = context.isPhone;
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
                vertical: phone ? 12 : 16,
              ),
              child: Row(
                children: [
                  Flexible(
                    child: GestureDetector(
                      onTap: () => onNavigate('hero'),
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 220),
                        style: GoogleFonts.fraunces(
                          fontSize: phone ? 18 : 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.4,
                          color: brandColor,
                        ),
                        child: Text(
                          phone ? 'Tushar' : 'Tushar Dubey',
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
                    IconButton(
                      tooltip: 'Menu',
                      onPressed: () => _openMenu(context),
                      icon: Icon(Icons.menu_rounded, color: menuIconColor),
                      visualDensity: VisualDensity.compact,
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
