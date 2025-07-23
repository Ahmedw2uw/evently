import 'package:evently/ui/utiliti/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheem {
  static final TextTheme _lightTextTheme = TextTheme(
    //! text styles
    // 🔹 1. labelMedium: يُستخدم للعناصر البسيطة مثل نص الزر أو شارات صغيرة
    labelMedium: TextStyle(
      fontSize: 16,
      color: AppColors.purple,
      fontWeight: FontWeight.bold,
    ),
    labelLarge: TextStyle(
      fontSize: 20,
      color: AppColors.white,
      fontWeight: FontWeight.w500,
    ),

    // 🔹 2. titleSmall: يُستخدم للنصوص الثانوية مثل الـ hint داخل حقل إدخال (TextField)
    titleSmall: TextStyle(
      fontSize: 16,
      color: AppColors.gray,
      fontWeight: FontWeight.w500,
    ),

    // 🔹 3. titleMedium: يُستخدم للعناوين المتوسطة مثل عنوان قسم أو شاشة داخلية
    titleMedium: TextStyle(
      fontSize: 20,
      color: AppColors.black,
      fontWeight: FontWeight.w500,
    ),
  ); //* 🌞 هذا يحتوي على تنسيقات النصوص في الوضع الفاتح (Light Mode)

  //* 🌚 هذا يحتوي على تنسيقات النصوص في الوضع الداكن (Dark Mode)، ويمكنك تعديله لاحقًا
  static final TextTheme _darkTextThem = TextTheme(
    //! hear change the difrent between the modes
    // 🔹 1. labelMedium: يُستخدم للعناصر البسيطة مثل نص الزر أو شارات صغيرة
    labelMedium: TextStyle(
      fontSize: 16,
      color: AppColors.white,
      fontWeight: FontWeight.bold,
    ),
    labelLarge: TextStyle(
      inherit: true,
      fontSize: 20,
      color: AppColors.white,
      fontWeight: FontWeight.w500,
    ),
    // 🔹 2. titleSmall: يُستخدم للنصوص الثانوية مثل الـ hint داخل حقل إدخال (TextField)
    titleSmall: TextStyle(
      fontSize: 16,
      color: AppColors.white,
      fontWeight: FontWeight.w500,
    ),

    // 🔹 3. titleMedium: يُستخدم للعناوين المتوسطة مثل عنوان قسم أو شاشة داخلية
    titleMedium: TextStyle(
      fontSize: 20,
      color: AppColors.white,
      fontWeight: FontWeight.w500,
    ),
  );

  //* 🟢 الثيم الفاتح للتطبيق، يستخدم Light Text Theme
  static ThemeData lightTheme = ThemeData(
    textTheme: _lightTextTheme,

    scaffoldBackgroundColor:
        AppColors.white, //* to assin to scafold background the white
    primaryColor: AppColors.purple, //*the most usage color
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.purple,
    ), //* the initial color to the app

    elevatedButtonTheme: ElevatedButtonThemeData(
      //* the color of this button
      style: ElevatedButton.styleFrom(
        //* this constructor taik the color directly
        backgroundColor:
            AppColors.purple, //* this is a defolt color in elevated button
        padding: EdgeInsets.symmetric(vertical: 16),
        textStyle: _lightTextTheme.labelLarge!.copyWith(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.purple),
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.purple,
      shape: RoundedRectangleBorder(
        //* cange the shape and color
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
    ),

    //* input decoration in ligth theme
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: AppColors.gray,
      suffixIconColor: AppColors.gray,
      hintStyle: const TextStyle(
        fontSize: 16,
        color: AppColors.gray,
        fontWeight: FontWeight.bold,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(color: AppColors.gray),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.babyBlue),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    dividerTheme: DividerThemeData(color: AppColors.purple, thickness: 1),
  );

  //* ⚫ الثيم الداكن للتطبيق، يستخدم Dark Text Theme
  static ThemeData darkTheme = ThemeData(
    textTheme: _darkTextThem, //*assign this to all text
    scaffoldBackgroundColor:
        AppColors.darkpurple, //*defolt color to the scafold
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.purple,
    ), //* the initial color to the app
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 16),
        textStyle: _darkTextThem.labelLarge!.copyWith(color: AppColors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.purple),
        ),
      ),
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkpurple,
      shape: RoundedRectangleBorder(
        //* cange the shape and color
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
    ),
    //* input decoration
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: AppColors.purple,
      suffixIconColor: AppColors.purple,
      hintStyle: const TextStyle(
        fontSize: 16,
        color: AppColors.white,
        fontWeight: FontWeight.bold,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(color: AppColors.purple),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.gray),
      ),
      // prefixIconConstraints: BoxConstraints(maxHeight: 24, maxWidth: 24),
    ),
    dividerTheme: DividerThemeData(color: AppColors.purple, thickness: 1),
  );
}
