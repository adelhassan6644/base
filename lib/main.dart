import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'app/core/utils/app_storage_keys.dart';
import 'app/core/utils/un_focus.dart';
import 'app/theme/dark_theme.dart';
import 'app/theme/light_theme.dart';
import 'controller/localization_provider.dart';
import 'controller/theme_provider.dart';
import 'di.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app/core/utils/app_strings.dart';
import 'domain/localization/app_localization.dart';
import 'navigation/custom_navigation.dart';
import 'navigation/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  await di.init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<LocalizationProvider>()),
  ], child: const MyApp()));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    List<Locale> locals = [];
    for (var language in AppStorageKey.languages) {
      locals.add(Locale(language.languageCode!, language.countryCode));
    }
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light));
    return MaterialApp(
      builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Unfocus(child: child!)),
      initialRoute: Routes.SPLASH,
      navigatorKey: CustomNavigator.navigatorState,
      onGenerateRoute: CustomNavigator.onCreateRoute,
      navigatorObservers: [CustomNavigator.routeObserver],
      title: AppStrings.appName,
      supportedLocales: locals,
      scaffoldMessengerKey: CustomNavigator.scaffoldState,
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(
        context,
      ).darkTheme
          ? dark
          : light,
      locale: Provider.of<LocalizationProvider>(
        context,
      ).locale,
      localizationsDelegates: const [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
