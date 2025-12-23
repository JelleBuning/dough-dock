import 'package:dough_dock/utils/theme_provider.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.themeProvider});

  final ThemeProvider themeProvider;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Switch(
          value: widget.themeProvider.themeMode == ThemeMode.light,
          onChanged: (value) {
            setState(() {
              widget.themeProvider.setTheme(
                value ? ThemeMode.light : ThemeMode.dark,
              );
            });
          },
        ),
      ),
    );
  }
}
