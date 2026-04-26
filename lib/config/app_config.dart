import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../services/local_storage_service.dart';

// Singleton instance de LocalStorageService
late LocalStorageService _localStorageService;

class AppConfig {
  static Future<void> init() async {
    print('AppConfig: Starting initialization...');
    
    // Inicializar almacenamiento local primero (needed for all other services)
    print('AppConfig: Initializing LocalStorageService...');
    _localStorageService = LocalStorageService();
    await _localStorageService.init();
    print('AppConfig: LocalStorageService initialized');
    
    // Inicializar Firebase solo en plataformas nativas (iOS, Android)
    if (!kIsWeb) {
      try {
        print('AppConfig: Initializing Firebase...');
        await Firebase.initializeApp();
        print('AppConfig: Firebase initialized');
      } catch (e) {
        print('Firebase init error: $e');
      }
    } else {
      print('AppConfig: Skipping Firebase init on web platform');
    }

    print('AppConfig: Initialization complete');
  }

  // Obtener la instancia de localStorage
  static LocalStorageService get localStorage => _localStorageService;

  // Configuraciones según ambiente
  static const String developmentApiUrl = 'http://localhost:8080';
  static const String developmentGraphQLUrl = 'http://localhost:8080/api/graphql';
  
  static const String productionApiUrl = 'https://api.banco.com';
  static const String productionGraphQLUrl = 'https://api.banco.com/graphql';

  // Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration graphQLTimeout = Duration(seconds: 30);

  // Limites de almacenamiento
  static const int maxCacheSize = 104857600; // 100 MB
  static const int maxNotificationsCached = 100;
  static const int maxProcessesCached = 50;
  static const int maxTasksCached = 100;
}
