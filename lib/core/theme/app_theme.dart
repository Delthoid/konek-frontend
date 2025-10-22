import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:konek_frontend/config/sizing_config.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      visualDensity: VisualDensity.compact,
      fontFamily: GoogleFonts.lato().fontFamily,
      splashFactory: InkSparkle.splashFactory,
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.linux: ZoomPageTransitionsBuilder(),
          TargetPlatform.macOS: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.windows: ZoomPageTransitionsBuilder(),
        },
      ),
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink, brightness: Brightness.light),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        isDense: true,
        // fillColor: Colors.grey[100],
        visualDensity: VisualDensity.compact,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizingConfig.borderRadiusMedium)
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          visualDensity: VisualDensity.compact,
        )
      )
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      visualDensity: VisualDensity.compact,
      fontFamily: GoogleFonts.nunitoSans().fontFamily,
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.linux: ZoomPageTransitionsBuilder(),
          TargetPlatform.macOS: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.windows: ZoomPageTransitionsBuilder(),
        },
      ),
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0A84FF), brightness: Brightness.dark),
    );
  }
}
