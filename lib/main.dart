import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trivia_game_app/ListProvider.dart';
import 'package:trivia_game_app/pages/HomePage.dart';



void main() {
  runApp(const myApp());
}

class myApp extends StatefulWidget {
  const myApp({super.key});

  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => ListProvider(),)
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trivia Game',
      theme: ThemeData(
        fontFamily: GoogleFonts.prompt().fontFamily,
        useMaterial3: false,
      ),
      home: HomePage(),
    ),
    );
}
}

