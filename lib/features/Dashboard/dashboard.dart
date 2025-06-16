import 'package:flutter/material.dart';
import 'package:food_diet/features/Dashboard/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool hasDiet = false;

  @override
  void initState() {
    super.initState();
    _checkDietStatus();
  }

  Future<void> _checkDietStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool? dietStatus = prefs.getBool('hasDiet') ?? false;

    if (!mounted) return;
    setState(() {
      hasDiet = dietStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return HomePage(hasDiet: hasDiet, onDietCreated: _checkDietStatus,);
  }
}
