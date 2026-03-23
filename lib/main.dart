import 'package:dough_dock/app/dependencies.dart';
import 'package:dough_dock/app/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future main() async {
  runApp(
    MultiProvider(providers: providers, builder: (context, child) => App()),
  );
}
