import 'package:book_lab/const/theme/app_theme_tokens.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    AppThemeTokens appThemeTokens = Theme.of(
      context,
    ).extension<AppThemeTokens>()!;

    return NavigationBarTheme(
      data: NavigationBarThemeData(
        backgroundColor: appThemeTokens.navBg,
        indicatorColor: Colors.transparent,
        height: 85,
        labelTextStyle: WidgetStateProperty.resolveWith((state) {
          bool isSelected = state.contains(WidgetState.selected);
          return TextStyle(
            fontSize: isSelected ? 12 : 11,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected
                ? appThemeTokens.onBackground
                : appThemeTokens.textSecondary,
          );
        }),
      ),
      child: Container(
        padding: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: appThemeTokens.border)),
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          destinations: [
            _destination(Icon(Icons.folder_open), "Books"),
            _destination(Icon(Icons.groups_sharp), "Authors"),
            _destination(Icon(Icons.settings), "Config"),
          ],
        ),
      ),
    );
  }

  NavigationDestination _destination(Icon icon, String label) {
    AppThemeTokens appThemeTokens = Theme.of(
      context,
    ).extension<AppThemeTokens>()!;
    final selectedIcon = ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          colors: [appThemeTokens.primaryLight, appThemeTokens.secondary],
        ).createShader(rect);
      },
      child: Icon(icon.icon, color: appThemeTokens.onPrimary, size: 24),
    );
    return NavigationDestination(
      icon: icon,
      label: label,
      selectedIcon: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.9, end: 1.0),
        duration: Duration(microseconds: 300),
        builder: (BuildContext context, double value, Widget? child) {
          return Transform.translate(
            offset: Offset(0, -2),
            child: Transform.scale(scale: value, child: child),
          );
        },
        child: selectedIcon,
      ),
    );
  }
}
