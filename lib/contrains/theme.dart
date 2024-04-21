import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '/contrains/theme_text.dart';
import 'theme_color.dart';

class AppTheme {
  static ThemeData defaulTheme = ThemeData(
    fontFamily: 'Montserrat',
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black87,
      // selectionColor: Colors.black,
      // selectionHandleColor: Colors.black,
    ),
    scaffoldBackgroundColor: ThemeColor.bgColor,
    primaryColor: ThemeColor.primaryColor,
    textTheme: DTextTheme.textTheme,
    colorScheme: ColorScheme.light(
      primary: ThemeColor.primaryColor,
    ),
    actionIconTheme: ActionIconThemeData(
      backButtonIconBuilder: (BuildContext context) =>
          const Icon(Iconsax.arrow_left_2),
    ),
    highlightColor: ThemeColor.primaryColor,
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.only(top: 13),
      errorStyle: TextStyle(
        color: Colors.red,
        fontSize: 11,
      ),
      errorMaxLines: 1,
      // enabledBorder: OutlineInputBorder(
      //   borderSide: BorderSide(color: Colors.black),
      // ),
    ),

    appBarTheme: AppBarTheme(
      color: ThemeColor.primaryColor,
      titleTextStyle:
          DTextTheme.textTheme.titleLarge!.copyWith(color: Colors.black),
    ),
    snackBarTheme: SnackBarThemeData(backgroundColor: ThemeColor.bgColor),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: ThemeColor.bgColor,
      indicatorColor: ThemeColor.primaryColor,
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
      surfaceTintColor: ThemeColor.itemColor,
      color: ThemeColor.itemColor,
      shadowColor: ThemeColor.bgColor,
      elevation: 1,
    ),
    dialogBackgroundColor: ThemeColor.itemColor,
    datePickerTheme: DatePickerThemeData(
        rangeSelectionBackgroundColor: Colors.amber.withOpacity(0.3)),
    tabBarTheme: TabBarTheme(
      indicatorColor: ThemeColor.textButtonColor,
      labelColor: Colors.black,
      unselectedLabelColor: Colors.black54,
    ),
    // iconTheme: IconThemeData(color: ThemeColor.iconColor),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        // backgroundColor: MaterialStateProperty.all(ThemeColor.itemColor),
        foregroundColor: MaterialStateProperty.all(ThemeColor.textButtonColor),
        // shape: MaterialStateProperty.all(
        //   RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(30),
        //     side: BorderSide(color: ThemeColor.textButtonColor, width: 1),
        //   ),
        // ),
      ),
    ),
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