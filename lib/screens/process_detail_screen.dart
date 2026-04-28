import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
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
    final formatter = DateFormat('dd/MM/yyyy HH:mm');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Proceso'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Estado:', style: TextStyle(fontWeight: FontWeight.bold)),
                            Chip(label: Text(process.status)),
                          ],
                        ),
                        _buildInfoRow('Versión:', process.policyVersion.toString()),
                        _buildInfoRow('Iniciado:', formatter.format(process.initiatedAt)),
                        if (process.completedAt != null)
                          _buildInfoRow('Completado:', formatter.format(process.completedAt!)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () => context.pushNamed(
                          'process-tracking',
                          pathParameters: {'id': process.id},
                        ),
                        icon: const Icon(Icons.timeline),
                        label: const Text('Ver seguimiento'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => context.pushNamed(
                          'process-documents',
                          pathParameters: {'id': process.id},
                        ),
                        icon: const Icon(Icons.attach_file),
                        label: const Text('Documentos'),
                      ),
                    ),
                  ],
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
                        trailing: Text(formatter.format(event.timestamp)),
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
