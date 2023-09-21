import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/viewmodels/scanner/scanner_provider.dart';
import 'package:scanner_poin/ui/screens/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ScannerProvider(),
      child: MaterialApp(
        title: 'ID Scanner',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
