import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final Logger _logger = Logger();

  /// Inicializa Firebase Cloud Messaging
  Future<void> init(Function(RemoteMessage) onMessageHandler) async {
    try {
      // Solicitar permisos en iOS
      await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      // Obtener token FCM
      final token = await _firebaseMessaging.getToken();
      _logger.i('FCM Token: $token');

      // Handler para mensajes en primer plano
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        _logger.i('Mensaje en primer plano recibido: ${message.notification?.title}');
        onMessageHandler(message);
      });

      // Handler para mensajes cuando app está en background
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        _logger.i('Notificación abierta: ${message.notification?.title}');
        onMessageHandler(message);
      });

      // Handler para mensajes recibidos en background
      FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);

      _logger.i('NotificationService initialized');
    } catch (e) {
      _logger.e('Error initializing NotificationService: $e');
    }
  }

  /// Obtiene el token FCM actual
  Future<String?> getToken() async {
    try {
      return await _firebaseMessaging.getToken();
    } catch (e) {
      _logger.e('Error getting FCM token: $e');
      return null;
    }
  }

  /// Suscribe a un tópico
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      _logger.i('Subscribed to topic: $topic');
    } catch (e) {
      _logger.e('Error subscribing to topic: $e');
    }
  }

  /// Desuscribe de un tópico
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      _logger.i('Unsubscribed from topic: $topic');
    } catch (e) {
      _logger.e('Error unsubscribing from topic: $e');
    }
  }

  /// Handler para mensajes en background
  static Future<void> _backgroundMessageHandler(RemoteMessage message) async {
    final logger = Logger();
    logger.i('Mensaje en background: ${message.notification?.title}');
    // Aquí se pueden hacer operaciones en background
  }
}
