import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../config/app_config.dart';
import '../screens/login_screen.dart';
import '../screens/auth_assist_screen.dart';
import '../screens/home_screen.dart';
import '../screens/process_detail_screen.dart';
import '../screens/process_documents_screen.dart';
import '../screens/process_tracking_screen.dart';
import '../screens/task_detail_screen.dart';
import '../screens/notifications_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/history_screen.dart';
import '../screens/new_process_screen.dart';

class RouterConfig {
  static GoRouter createRouter() {
    final hasToken = AppConfig.localStorage.getAuthToken() != null;
    return GoRouter(
      initialLocation: hasToken ? '/' : '/login',
      routes: [
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/auth-assist',
          name: 'auth-assist',
          builder: (context, state) => const AuthAssistScreen(),
        ),
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/process/:id',
          name: 'process-detail',
          builder: (context, state) => ProcessDetailScreen(
            processId: state.pathParameters['id']!,
          ),
        ),
        GoRoute(
          path: '/process/:id/tracking',
          name: 'process-tracking',
          builder: (context, state) => ProcessTrackingScreen(
            processId: state.pathParameters['id']!,
          ),
        ),
        GoRoute(
          path: '/process/:id/documents',
          name: 'process-documents',
          builder: (context, state) => ProcessDocumentsScreen(
            processId: state.pathParameters['id']!,
          ),
        ),
        GoRoute(
          path: '/task/:id',
          name: 'task-detail',
          builder: (context, state) => TaskDetailScreen(
            taskId: state.pathParameters['id']!,
          ),
        ),
        GoRoute(
          path: '/notifications',
          name: 'notifications',
          builder: (context, state) => const NotificationsScreen(),
        ),
        GoRoute(
          path: '/history',
          name: 'history',
          builder: (context, state) => const HistoryScreen(),
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: '/new-process',
          name: 'new-process',
          builder: (context, state) => const NewProcessScreen(),
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text('Página no encontrada'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Text('Volver al inicio'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
