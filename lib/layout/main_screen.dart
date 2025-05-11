import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatefulWidget {
  final Widget child;

  const MainScreen({super.key, required this.child});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<String> _routes = [
    '/home',
    '/search',
    '/diet',
    '/profile',
    '/settings',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    context.go(_routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        backgroundColor: Color(0xFFD1D696),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
          BottomNavigationBarItem(icon: Icon(Icons.format_list_bulleted), label: 'Mis comidas'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome_rounded), label: 'Logros'),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu_sharp), label: 'Comidas del mundo'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline_sharp), label: 'Perfil'),
        ],
      ),
    );
  }
}
