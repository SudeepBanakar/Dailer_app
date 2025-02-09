import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/theme_provider.dart'; // Import your theme provider
import 'screens/login_screen.dart'; // Import the LoginScreen

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: LoginScreen(), // Set LoginScreen as the initial screen
    );
  }
}
