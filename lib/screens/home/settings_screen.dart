import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        backgroundColorStart: Colors.cyan,
        backgroundColorEnd: Colors.indigo,
      ),
    );
  }
}
