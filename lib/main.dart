import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'constants/app_constants.dart';
import 'models/app_theme.dart';
import 'services/gratitude_provider.dart';
import 'services/theme_service.dart';
import 'services/locale_service.dart';
import 'l10n/app_localizations.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await ThemeService().initialize();
  await LocaleService().initialize();
  runApp(const InkaMaxApp());
}

class InkaMaxApp extends StatelessWidget {
  const InkaMaxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GratitudeProvider()..initialize()),
        ChangeNotifierProvider.value(value: LocaleService()),
        StreamProvider.value(
          value: ThemeService().themeStream,
          initialData: ThemeService().currentTheme,
        ),
      ],
      child: Consumer2<AppThemeData, LocaleService>(
        builder: (context, theme, localeService, child) {
          return MaterialApp(
            title: AppConstants.appName,
            theme: ThemeService().toFlutterTheme(),
            locale: localeService.currentLocale,
            supportedLocales: LocaleService.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: const SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
