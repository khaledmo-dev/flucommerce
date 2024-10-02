import 'package:flucommerce/services/hive_db.dart';
import 'package:flucommerce/services/local_storage_service.dart';
import 'package:flucommerce/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flucommerce/app/app.bottomsheets.dart';
import 'package:flucommerce/app/app.dialogs.dart';
import 'package:flucommerce/app/app.locator.dart';
import 'package:flucommerce/app/app.router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

ValueNotifier themeNotifier = ValueNotifier(false);
ValueNotifier langNotifier = ValueNotifier("en");

Future<void> _setupHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CartItemAdapter());
  Hive.registerAdapter(FavoriteAdapter());
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _setupHive();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();

  themeNotifier.value = locator<LocalStorageService>().isDarkMode;
  langNotifier.value = locator<LocalStorageService>().lang;

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: langNotifier,
        builder: (context, langValue, _) {
          var fontFamily = langValue == 'en' ? "Urbanist" : "Cairo";
          return ValueListenableBuilder(
            valueListenable: themeNotifier,
            builder: (context, value, _) {
              var theme =
                  value ? ThemeService.darkTheme : ThemeService.lightTheme;
              return MaterialApp(
                initialRoute: Routes.startupView,
                onGenerateRoute: StackedRouter().onGenerateRoute,
                navigatorKey: StackedService.navigatorKey,
                navigatorObservers: [
                  StackedService.routeObserver,
                ],
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [Locale("en"), Locale("ar")],
                locale: Locale(langValue),
                theme: theme.copyWith(
                  textTheme: theme.textTheme.apply(fontFamily: fontFamily),
                  appBarTheme: theme.appBarTheme.copyWith(
                    titleTextStyle: theme.appBarTheme.titleTextStyle!.apply(
                      fontFamily: fontFamily,
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}
