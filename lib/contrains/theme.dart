import 'package:beanfast_customer/contrains/theme_text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:google_fonts/google_fonts.dart';


import 'theme_color.dart';

class AppTheme {
  static ThemeData defaulTheme = ThemeData(
    fontFamily: 'Montserrat',
    
    scaffoldBackgroundColor: ThemeColor.bgColor,
    primaryColor: ThemeColor.primaryColor,
    textTheme: DTextTheme.textTheme,
    colorScheme: const ColorScheme.light(
      primary: Colors.green,
    ),
    actionIconTheme: ActionIconThemeData(
      backButtonIconBuilder: (BuildContext context) =>
          const Icon(Iconsax.arrow_left_2),
    ),
    highlightColor: ThemeColor.primaryColor,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: ThemeColor.inputColor,
      ), // Màu chữ khi có label
      // hintStyle: TextStyle(fontSize: 1), // Màu chữ hint
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ThemeColor.inputColor),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ThemeColor.inputColor),
        borderRadius: BorderRadius.circular(10),
      ),
      // border: OutlineInputBorder(
      //   borderSide: BorderSide(
      //     color: ThemeColor.primaryColor,
      //     width: 2.0,
      //   ),
      //   borderRadius: BorderRadius.circular(10),
      // ),

      // filled: true,
      // fillColor: Colors.grey[200],
    ),
    appBarTheme: AppBarTheme(color: ThemeColor.primaryColor),
    snackBarTheme: SnackBarThemeData(backgroundColor: ThemeColor.bgColor),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: ThemeColor.bgColor,
      indicatorColor: ThemeColor.primaryColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ThemeColor.bgColor2,
      selectedItemColor: ThemeColor.inputColor,
      unselectedItemColor: ThemeColor.primaryColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        extendedTextStyle: TextStyle(color: ThemeColor.primaryColor),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        backgroundColor: ThemeColor.primaryColor,
        elevation: 0.8,
        hoverElevation: 1),
    cardTheme: CardTheme(
      color: ThemeColor.itemColor,
      shadowColor: ThemeColor.bgColor,
      elevation: 1,
    ),
    dialogBackgroundColor: ThemeColor.itemColor,
  );
}

    // return ThemeData(
    //   colorScheme: colorScheme,
    //   brightness: colorScheme.brightness,
    //   primaryColor: primarySurfaceColor,
    //   canvasColor: colorScheme.background,
    //   scaffoldBackgroundColor: colorScheme.background,
    //   bottomAppBarColor: colorScheme.surface,
    //   cardColor: colorScheme.surface,
    //   dividerColor: colorScheme.onSurface.withOpacity(0.12),
    //   backgroundColor: colorScheme.background,
    //   dialogBackgroundColor: colorScheme.background,
    //   indicatorColor: onPrimarySurfaceColor,
    //   errorColor: colorScheme.error,
    //   textTheme: textTheme,
    //   applyElevationOverlayColor: isDark,
    //   useMaterial3: useMaterial3,
    // );