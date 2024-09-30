import 'package:flutter/material.dart';
import 'package:webview_flutter_app/screens/my_webview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 78, 44, 145)),
        useMaterial3: true,
      ),
      home: const MyWebviewScreen(),
    );
  }
}
