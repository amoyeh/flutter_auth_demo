import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScreenShell extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const ScreenShell({required this.navigationShell, Key? key}) : super(key: key ?? const ValueKey<String>('StatefulNavigationShell'));
  @override
  State<ScreenShell> createState() => _ScreenShellState();
}

class _ScreenShellState extends State<ScreenShell> {
  void _onTap(BuildContext context, int index) {
    widget.navigationShell.goBranch(index, initialLocation: index == widget.navigationShell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'home',
            icon: Icon(Icons.home_outlined, color: Theme.of(context).colorScheme.secondary),
            activeIcon: Icon(Icons.home, color: Colors.orangeAccent.shade400),
          ),
          BottomNavigationBarItem(
            label: 'content',
            icon: Icon(Icons.favorite_border_rounded, color: Theme.of(context).colorScheme.secondary),
            activeIcon: Icon(Icons.favorite_rounded, color: Colors.orangeAccent.shade400),
          ),
          BottomNavigationBarItem(
            label: 'me',
            icon: Icon(Icons.person_outline_rounded, color: Theme.of(context).colorScheme.secondary),
            activeIcon: Icon(Icons.person, color: Colors.orangeAccent.shade400),
          ),
        ],
        currentIndex: widget.navigationShell.currentIndex,
        onTap: (int index) => _onTap(context, index),
      ),
    );
  }
}
