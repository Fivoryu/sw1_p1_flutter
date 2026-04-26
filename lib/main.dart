import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'config/app_config.dart';
import 'config/router_config.dart' as router_config;
import 'widgets/app_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar servicios
  await AppConfig.init();
  
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = router_config.RouterConfig.createRouter();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Almacenamiento local ya está inicializado en AppConfig.init()
    print('MyApp._initializeApp: Initializing...');

    // Inicializar notificaciones push
    try {
      final notificationService = ref.read(notificationServiceProvider);
      await notificationService.init(_handleNotification);
      print('MyApp._initializeApp: Notifications initialized');
    } catch (e) {
      print('MyApp._initializeApp: Error initializing notifications: $e');
    }

    print('MyApp._initializeApp: Complete');
  }

  void _handleNotification(dynamic message) {
    // Manejar notificaciones recibidas
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message.notification?.title ?? 'Nueva notificación'),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Workflow Mobile Client',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      themeMode: ThemeMode.system,
      routerConfig: _router,
    );
  }
}
