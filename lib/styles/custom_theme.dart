import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilefirst/styles/styles.dart';
import 'package:mobilefirst/utils/preference_utils.dart';
import 'package:mobilefirst/utils/theme_constants.dart';
import 'package:mobilefirst/utils/utils.dart';

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = PreferenceUtils.getBool(theme_mode);
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    PreferenceUtils.putBool(theme_mode, _isDarkTheme);
    notifyListeners();
  }

  static ThemeData get lightTheme {
    //1
    return ThemeData(
      //2
      primaryColor: primaryLight,
      scaffoldBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      secondaryHeaderColor: secondaryLight,
      cardColor: greyColor,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        titleSpacing: 5,
        titleTextStyle: kLabelStyleBold.copyWith(fontSize: 18),
        foregroundColor: darkColor,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      tabBarTheme: const TabBarTheme(
        unselectedLabelColor: greyColor,
        labelColor: primaryLight,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: primaryLight, width: 2.0),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: secondaryLight,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: greyColor),
        ),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: greyColor)),
        errorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: redColor)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: greyColor)),
        focusedErrorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: redColor)),
        fillColor: Colors.transparent,
      ),
      hintColor: greyColor,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedLabelStyle: TextStyle(
          color: primaryLight,
          fontSize: 14,
        ),
        unselectedLabelStyle: TextStyle(
          color: greyColor,
          fontSize: 12,
        ),
        backgroundColor: secondaryLight,
        elevation: 0,
        selectedItemColor: secondaryLight,
        unselectedItemColor: greyColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        unselectedIconTheme: IconThemeData(
          color: greyColor,
          size: 22,
        ),
        selectedIconTheme: IconThemeData(
          color: secondaryLight,
          size: 25,
        ),
      ),
      brightness: Brightness.light,
      fontFamily: GoogleFonts.lato().fontFamily,
      textTheme: TextTheme(
        headline1: kTitleStyle.copyWith(color: darkColor),
        headline2: kTitleStyleSmall.copyWith(color: darkColor),
        headline3: kQuoteStyle.copyWith(color: darkColor),
        caption: kLabelStyle.copyWith(color: darkColor),
        bodyText1: const TextStyle(
          color: darkColor,
          fontSize: 18,
        ),
        subtitle1: const TextStyle(
          color: darkColor,
          fontSize: 14,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
        //minimumSize: Size(Get.height * .2, Get.height * .07),
        //elevation: 1,
        textStyle: const TextStyle(fontSize: 18),
        primary: secondaryLight,
        side: const BorderSide(color: secondaryLight, width: 1),
      )),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          textStyle: kLabelStyleBold.copyWith(
            fontSize: 16,
          ),
          onPrimary: secondaryLight,
          primary: primaryLight,
        ),
      ),
      buttonTheme: ButtonThemeData(
        // 4
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: secondaryLight,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: secondaryLight,
        brightness: Brightness.light,
      ),
    );
  }
}
