import 'package:flutter/material.dart';
import 'package:navigate/pages/Homepage/homepage.dart';
import 'package:navigate/pages/forum/form.dart';
import 'package:navigate/pages/profile/profile.dart';

class BottomNavigationBarExampleApp extends StatelessWidget {
  const BottomNavigationBarExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNavigationBarExample(),
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBarStateful(
      selectedIndex: _selectedIndex,
      onItemTapped: _onItemTapped,
    );
  }
}

class BottomNavigationBarStateful extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavigationBarStateful({
    required this.selectedIndex,
    required this.onItemTapped,
    Key? key,
  }) : super(key: key);

  @override
  _BottomNavigationBarStatefulState createState() =>
      _BottomNavigationBarStatefulState();
}

class _BottomNavigationBarStatefulState
    extends State<BottomNavigationBarStateful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: widget.selectedIndex,
        children: const [
          HomePage(),
          Profile(),
          Forum(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: 'Forum',
          ),
        ],
        currentIndex: widget.selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: widget.onItemTapped,
      ),
    );
  }
}
