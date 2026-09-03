import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:tugas3flutter/day_11/extensions/navigator.dart';
import 'package:tugas3flutter/day_8/stack.dart';
import 'package:tugas3flutter/tugas5flutter.dart';

import 'package:tugas3flutter/day_33/views/splash_view.dart';

class DrawerDay13 extends StatefulWidget {
  const DrawerDay13({super.key});

  @override
  State<DrawerDay13> createState() => _DrawerDay13State();
}

class _DrawerDay13State extends State<DrawerDay13> {
  int _selectedBottom = 0;

  void changeBottom(int index) {
    _selectedBottom = index;
    // ignore: avoid_print
    print("Ini adalah value dari $_selectedBottom");
    setState(() {});
    context.pop();
  }

  final List<Widget> _widgetOptions = [
    StackDay8(),
    Tugas5Flutter(),
    const SplashView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Drawer Menu")),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                changeBottom(0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text("School"),
              onTap: () {
                changeBottom(1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle, color: Color(0xFF4A00E0)),
              title: const Text("Tugas 16: Auth & CRUD (Day 33)"),
              onTap: () {
                changeBottom(2);
              },
            ),
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_selectedBottom),
    );
  }
}
