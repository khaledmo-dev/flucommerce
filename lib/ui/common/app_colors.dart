import 'package:flucommerce/app/app.locator.dart';
import 'package:flucommerce/services/local_storage_service.dart';
import 'package:flutter/material.dart';

// const Color kcPrimaryColor = Color(0xFF9600FF);
const Color kcPrimaryColorDark = Color(0xFF300151);
const Color kcDarkGreyColor = Color(0xFF1A1B1E);
const Color kcMediumGrey = Color(0xFF474A54);
const Color kcLightGrey = Color.fromARGB(255, 187, 187, 187);
const Color kcVeryLightGrey = Color(0xFFE3E3E3);
const Color kcBackgroundColor = kcDarkGreyColor;

const Color kcPrimaryDarkThemeColor = Color(0xffFDFDFD);
const Color kcPrimaryLightThemeColor = Color(0xff181A20);

const Color kcLightSecondaryColor = Color(0xffE7E7E7);
const Color kcDarkSecondaryColor = Color(0xff35383F);

bool get isLightTheme => !locator<LocalStorageService>().isDarkMode;

Color get kcPrimaryColor =>
    isLightTheme ? kcPrimaryLightThemeColor : kcPrimaryDarkThemeColor;

Color get kcSecondaryColor =>
    isLightTheme ? kcLightSecondaryColor : kcDarkSecondaryColor;

Color get kcButtonIconColor =>
    isLightTheme ? kcPrimaryDarkThemeColor : kcPrimaryLightThemeColor;

Color get kcCartItemBackgroundColor =>
    isLightTheme ? const Color(0xffF3F3F3) : const Color(0xff1F222A);

String get notFoundImage => isLightTheme ? 'light-not-found' : 'dark-not-found';

Color get kcBottomNavIconColor =>
    isLightTheme ? kcLightSubtitleTextColor : kcDarkSubtitleTextColor;

const Color kcLightHeadersColor = Color(0xFF000000);
const Color kcDarkHeadersColor = Color(0xffffffff);

const Color kcLightBodyTextColor = Color(0xff212121);
const Color kcDarkBodyTextColor = Color(0xffFAFAFA);

const Color kcLightSubtitleTextColor = Color(0xff616161);
const Color kcDarkSubtitleTextColor = Color(0xffE0E0E0);
// ---------------------------------------------------------

const Color kcMediumGreyColorLightTheme = Color(0xffA6BCD0);
// const Color kcMediumGreyColorDarkTheme = Color(0xff748A9D);
// const Color kcLightGreyColor = Color(0xffe5e5e5);
// const Color kcVeryLightGreyColor = Color(0xffF0F4F8);

// const Color kcLightPrimaryColor = Color(0xffF2FFF1);
