import 'package:flutter/material.dart';

// final ThemeData lightMode = ThemeData(
//     primaryColor: Colors.blueGrey,
//     colorScheme: const ColorScheme.light(
//         primary: Colors.blueGrey,
//         secondary: Color.fromARGB(255, 141, 183, 204),
//         tertiary: Color.fromARGB(255, 172, 224, 250),
//         inversePrimary: Color.fromARGB(255, 218, 216, 207),
//         surface: Color.fromARGB(255, 17, 189, 106)));

final ThemeData lightMode = ThemeData(
    primaryColor: Colors.blueGrey,
    colorScheme: const ColorScheme.dark(
        primary: Color.fromARGB(255, 53, 69, 77),
        secondary: Color.fromARGB(255, 69, 90, 100),
        tertiary: Color.fromARGB(255, 104, 137, 153),
        inversePrimary: Color.fromARGB(255, 136, 134, 134),
        surface: Color.fromARGB(255, 23, 109, 68)));

// final ThemeData lightMode = ThemeData(
//     primaryColor: const Color(0x00265c4b),
//     colorScheme: const ColorScheme.light(
//         primary: Color.fromARGB(255, 38, 92, 75),
//         secondary: Color.fromARGB(255, 20, 101, 81),
//         tertiary: Color.fromARGB(255, 0, 117, 101),
//         inversePrimary: Color.fromARGB(255, 143, 193, 181),
//         surface: Color.fromARGB(255, 88, 154, 141)));

final ThemeData darkMode = ThemeData(
    primaryColor: const Color.fromARGB(255, 36, 0, 70),
    colorScheme: const ColorScheme.light(
        primary: Color.fromARGB(255, 36, 0, 70),
        secondary: Color.fromARGB(255, 60, 9, 108),
        tertiary: Color.fromARGB(255, 89, 24, 154),
        inversePrimary: Color.fromARGB(255, 122, 44, 191),
        surface: Color.fromARGB(255, 199, 125, 255)));
