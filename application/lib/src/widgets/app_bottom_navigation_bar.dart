import 'package:application/src/screens/help_page.dart';
import 'package:application/src/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:application/src/screens/student_list_page.dart';
import 'package:application/src/screens/notifications_page.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final BuildContext context;
  final int currentIndex;

  const AppBottomNavigationBar({
    super.key,
    required this.context,
    required this.currentIndex,
  });

  void _navigateWithSlide({required Widget page, required bool slideToLeft}) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final begin = Offset(slideToLeft ? 1.0 : -1.0, 0.0);
          final end = Offset.zero;
          final tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: Curves.easeInOut));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        pageBuilder: (_, __, ___) => page,
      ),
    );
  }

  void _onItemTapped(int newIndex) {
    if (newIndex == currentIndex) return;

    final slideToLeft = newIndex > currentIndex;

    switch (newIndex) {
      case 0:
        _navigateWithSlide(
          page: const StudentsListPage(),
          slideToLeft: slideToLeft,
        );
        break;
      case 1:
        _navigateWithSlide(page: const HelpPage(), slideToLeft: slideToLeft);
        break;
      case 2:
        _navigateWithSlide(
          page: const NotificationsPage(),
          slideToLeft: slideToLeft,
        );
        break;
      case 3:
        _navigateWithSlide(page: const ProfilePage(), slideToLeft: slideToLeft);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
        BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Ajuda'),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notificações',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
      ],
    );
  }
}
