import 'package:flutter/material.dart';
import 'package:news_api/screens/loading_screen.dart';
import 'package:news_api/utilities/utilities.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      textTheme: const TextTheme(
        bodySmall: TextStyle(fontFamily: 'Montserrat'),
        bodyMedium: TextStyle(fontFamily: 'Montserrat'),
        bodyLarge: TextStyle(fontFamily: 'Montserrat'),
      ),
    ),
    home: const LoadingScreen(
      newsType: NewsType.headlines,
    ),
  ));
}
