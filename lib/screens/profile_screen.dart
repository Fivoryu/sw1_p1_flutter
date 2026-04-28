import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/app_providers.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userIdProvider);
    final username = ref.watch(usernameProvider);
    final profileState = ref.watch(currentUserProfileProvider);
    final statsState = ref.watch(userStatsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                size: 64,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: profileState.when(
                  data: (profile) {
                    final roles = (profile?['roles'] as List?)?.join(', ') ?? 'Cliente';
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Información de Usuario',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 16),
                        _buildProfileField('Usuario', username ?? 'No asignado'),
                        _buildProfileField('ID de Usuario', userId ?? 'No asignado'),
                        _buildProfileField('Email', profile?['email']?.toString() ?? 'No disponible'),
                        _buildProfileField('Departamento', profile?['departamento']?.toString() ?? 'N/A'),
                        _buildProfileField('Roles', roles),
                        _buildProfileField(
                          'Estado',
                          (profile?['active'] == true) ? 'Activo' : 'No disponible',
                        ),
                      ],
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (_, __) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Información de Usuario',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      const Text('No se pudo cargar el perfil remoto.'),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: statsState.when(
                  data: (stats) {
                    final completedTasks = stats['completedTasks']?.toString() ?? '--';
                    final activeProcesses = stats['activeProcesses']?.toString() ?? '--';
                    final totalDocuments = stats['documentsUploaded']?.toString() ?? '--';
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Estadísticas',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildStatTile('Tareas\nCompletadas', completedTasks),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildStatTile('Procesos\nActivos', activeProcesses),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildStatTile('Documentos\nCargados', totalDocuments),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (_, __) => const Text('No se pudieron cargar estadísticas'),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Preferencias',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    const ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.notifications_active_outlined),
                      title: Text('Notificaciones push'),
                      subtitle: Text('Habilitadas en plataforma móvil nativa'),
                    ),
                    const ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.sync_outlined),
                      title: Text('Sincronización'),
                      subtitle: Text('Puedes forzar sincronización desde la pantalla principal'),
                    ),
                    const ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.dark_mode_outlined),
                      title: Text('Tema'),
                      subtitle: Text('Actualmente se usa el modo del sistema'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await ref.read(authControllerProvider.notifier).logout();
                  if (context.mounted) context.go('/login');
                },
                icon: const Icon(Icons.logout),
                label: const Text('Cerrar Sesión'),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('CU-22 Registro y CU-03 Recuperación pendientes de endpoint backend'),
                  ),
                );
              },
              icon: const Icon(Icons.info_outline),
              label: const Text('Registro / Recuperación'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildStatTile(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
