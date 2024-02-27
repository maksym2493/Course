import 'package:final_project/screens/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kMainColor = Color.fromARGB(255, 183, 240, 222);

final kText = GoogleFonts.roboto(
  fontSize: 20,
);
final kText2 = GoogleFonts.roboto(
  fontSize: 28,
);
final kText3 = GoogleFonts.roboto(
  fontSize: 28,
  fontWeight: FontWeight.bold,
);
final kText4 = GoogleFonts.roboto(
  fontSize: 22,
  fontWeight: FontWeight.bold,
);
final kText5 = GoogleFonts.roboto(
  fontSize: 15,
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Final Project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 24),
        ),
      ),
      home: const MainScreen(),
    );
  }
}
