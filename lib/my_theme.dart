import 'package:flutter/material.dart';

import 'colors.dart';

class MyTheme {
  static List<ThemeData> themes = [
    /// Dark blue theme
    ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.black,
      ),
      scaffoldBackgroundColor: AppColors.black,
      iconTheme: IconThemeData(color: AppColors.sky),

      /// all icons
      textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white, fontSize: 24),

          ///drawer list
          headlineMedium: TextStyle(color: AppColors.sky, fontSize: 38),

          /// head"Tasks"  &&  gradient
          headlineSmall: TextStyle(
              color: Colors.white, fontSize: 28, decorationColor: Colors.white),

          /// Tasks content
          titleLarge: TextStyle(color: AppColors.sky, fontSize: 28),

          ///add new task

          titleMedium: TextStyle(
              color: AppColors.sky,
              fontSize: 23,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.sky),

          /// set due date
          titleSmall: TextStyle(
            color: Colors.white,
            fontSize: 20,
          )

          /// hint "what are you up to"

          ),
      dividerTheme: DividerThemeData(
        color: AppColors.lightBlue,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          onSurface: Colors.white,

          /// Border color(for the check circule)
          surfaceContainer: Colors.black38,

          /// the box of "add task"
          onSecondary: AppColors.darkblue,

          /// buttom sheet .

          tertiary: AppColors.Blue,
          onTertiary: AppColors.darkblue,
          onTertiaryFixed: AppColors.black

          /// gradient colors
          ),
    ),

    /// Light pink theme
    ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.T1pink1,
      ),
      scaffoldBackgroundColor: AppColors.T1pink2,
      iconTheme: IconThemeData(color: AppColors.T1lightPurble),

      /// all icons
      textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white, fontSize: 24),

          ///drawer list
          headlineMedium:
              TextStyle(color: AppColors.T1lightPurble, fontSize: 38),

          /// head"Tasks"
          headlineSmall: TextStyle(
              color: AppColors.T1lightPurble,
              fontSize: 28,
              decorationColor: AppColors.T1lightPurble),

          /// Tasks content  && calendar date
          titleLarge: TextStyle(color: AppColors.T1lightPurble, fontSize: 28),

          ///add new task

          titleMedium: TextStyle(
              color: AppColors.T1lightPurble,
              fontSize: 23,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.T1lightPurble),

          /// set due date

        titleSmall: TextStyle(
          color: AppColors.T1lightPurble ,
          decoration:  TextDecoration.underline,
          decorationColor:AppColors.T1lightPurble ,
          fontSize: 20,
        ),
        ///what are you up to

          ),
      dividerTheme: DividerThemeData(
        color: AppColors.lightBlue,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          onSurface: AppColors.T1lightPurble,

          /// Border color(for the check circule)
          surfaceContainer: AppColors.T1pink1,

          /// the box of "add task"

          tertiary: AppColors.T1pink2,
          onTertiary: AppColors.T1pink1,
          onTertiaryFixed: AppColors.T1pink1

          /// gradient colors
          ),
    ),

    /// olive theme
    ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.T2green,
      ),
      scaffoldBackgroundColor: AppColors.T2darkOffwhite,
      iconTheme: IconThemeData(color: AppColors.T2darkOffwhite),

      /// all icons
      textTheme: TextTheme(

          bodyLarge: TextStyle(color: Colors.white, fontSize: 24),

          ///drawer list
          headlineMedium:
              TextStyle(color: AppColors.T2darkOffwhite, fontSize: 38),

          /// head"Tasks"
          headlineSmall: TextStyle(
              color: AppColors.T2green,
              fontSize: 28,
              decorationColor: AppColors.T2olive),

          /// Tasks content  && calendar date
          titleLarge: TextStyle(color: AppColors.T2darkOffwhite, fontSize: 28),

          ///add new task

          titleMedium: TextStyle(
              color: AppColors.T2olive,
              fontSize: 23,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.T2olive),

          /// set due date

        titleSmall: TextStyle(
          color:AppColors.T2olive ,
          decoration:  TextDecoration.underline,
          decorationColor:AppColors.T2olive ,
          fontSize: 20,
        ),
        ///what are you up to

          ),
      dividerTheme: DividerThemeData(
        color: AppColors.lightBlue,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          onSurface: AppColors.T1lightPurble,

          /// Border color(for the check circule)
          surfaceContainer: AppColors.T2green,

          /// the box of "add task"

          tertiary: AppColors.T2lightGreen,
          onTertiary: AppColors.T2olive,
          onTertiaryFixed: AppColors.T2green

          /// gradient colors
          ),
    ),

    ///black blue theme
    ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.T3lightBlue,
      ),
      scaffoldBackgroundColor: AppColors.T3black,
      iconTheme: IconThemeData(color: AppColors.T3black),

      /// all icons
      textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white, fontSize: 24),

          ///drawer list
          headlineMedium:
              TextStyle(color: AppColors.T3black, fontSize: 38),

          /// head"Tasks"
          headlineSmall: TextStyle(
              color: AppColors.T3grey,
              fontSize: 28,
              decorationColor: AppColors.T3grey),

          /// Tasks content  && calendar date
          titleLarge: TextStyle(color: AppColors.T3grey, fontSize: 28),


          ///add new task

  titleSmall: TextStyle(
  color:AppColors.T3black ,
  decoration:  TextDecoration.underline,
  decorationColor:AppColors.T3black ,
  fontSize: 20,
  ),

  /// hint "what are you up to"


  titleMedium: TextStyle(
              color: AppColors.T3lightBlue,
              fontSize: 23,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.T3lightBlue)

          /// set due date

          ),
      dividerTheme: DividerThemeData(
        color: AppColors.T3lightBlack,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          onSurface: AppColors.T3grey,

          /// Border color(for the check circule)
          surfaceContainer: AppColors.T3lightBlack,

          /// the box of "add task"

          tertiary: AppColors.T3middleGradient,
          onTertiary: AppColors.T3middleGradient,
          onTertiaryFixed: AppColors.T3lightBlue

          /// gradient colors
          ),
    ),
  ];
}
