import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/app_providers.dart';

class ProcessDetailScreen extends ConsumerWidget {
  final String processId;

  const ProcessDetailScreen({
    Key? key,
    required this.processId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final processFuture = ref.watch(processDetailProvider(processId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Proceso'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: processFuture.when(
        data: (process) {
          if (process == null) {
            return const Center(child: Text('Proceso no encontrado'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          process.policyName,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 16),
                        _buildInfoRow('ID:', process.id),
                        _buildInfoRow('Estado:', process.status),
                        _buildInfoRow('Versión:', process.policyVersion.toString()),
                        _buildInfoRow('Iniciado:', process.initiatedAt.toString()),
                        if (process.completedAt != null)
                          _buildInfoRow('Completado:', process.completedAt.toString()),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Historial de Eventos',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: process.history.length,
                  itemBuilder: (context, index) {
                    final event = process.history[index];
                    return Card(
                      child: ListTile(
                        title: Text(event.nodeName),
                        subtitle: Text(event.status),
                        trailing: Text(event.timestamp.toString()),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    context.pushNamed(
                      'history',
                    );
                  },
                  child: const Text('Ver Historial Completo'),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text('Error cargando el proceso'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(processDetailProvider(processId)),
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
