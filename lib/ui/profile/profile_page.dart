import 'package:dough_dock/utils/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return Scaffold(
      body: Center(
        child: Switch(
          value: themeProvider.themeMode == ThemeMode.light,
          onChanged: (value) {
            context.read<ThemeProvider>().setTheme(
              value ? ThemeMode.light : ThemeMode.dark,
            );
          },
        ),
      ),
    );
  }
}
