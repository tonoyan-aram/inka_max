import 'dart:io';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter/foundation.dart';
import '../constants/app_constants.dart';

class AppsFlyerService {
  AppsFlyerService._internal();
  static final AppsFlyerService _instance = AppsFlyerService._internal();
  factory AppsFlyerService() => _instance;

  AppsflyerSdk? _sdk;
  bool _initialized = false;

  bool get isInitialized => _initialized;

  Future<void> initialize() async {
    if (_initialized) return;

    final String sanitizedIosAppId = AppConstants.appsFlyerAppId
        .replaceFirst(RegExp(r'^id', caseSensitive: false), '');

    final AppsFlyerOptions afOptions = Platform.isIOS
        ? AppsFlyerOptions(
            afDevKey: AppConstants.appsFlyerDevKey,
            appId: sanitizedIosAppId,
            showDebug: kDebugMode,
          )
        : AppsFlyerOptions(
            afDevKey: AppConstants.appsFlyerDevKey,
            showDebug: kDebugMode,
          );

    _sdk = AppsflyerSdk(afOptions);

    try {
      await _sdk!.initSdk(
        registerConversionDataCallback: true,
        registerOnAppOpenAttributionCallback: true,
        registerOnDeepLinkingCallback: true,
      );
      _initialized = true;
    } catch (e) {
      if (kDebugMode) {
        // ignore: avoid_print
        print('AppsFlyer init error: $e');
      }
    }
  }

  Future<void> logEvent(String eventName, Map<String, dynamic> values) async {
    if (_sdk == null) return;
    try {
      await _sdk!.logEvent(eventName, values);
    } catch (_) {}
  }
}


