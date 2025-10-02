import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants/app_constants.dart';
import 'models/app_theme.dart';
import 'services/gratitude_provider.dart';
import 'services/theme_service.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await ThemeService().initialize();
  runApp(const InkaMaxApp());
}

class InkaMaxApp extends StatelessWidget {
  const InkaMaxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GratitudeProvider()..initialize()),
        StreamProvider.value(
          value: ThemeService().themeStream,
          initialData: ThemeService().currentTheme,
        ),
      ],
      child: Consumer<AppThemeData>(
        builder: (context, theme, child) {
          return MaterialApp(
            title: AppConstants.appName,
            theme: ThemeService().toFlutterTheme(),
            home: const SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
