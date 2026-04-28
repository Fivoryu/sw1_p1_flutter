import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../widgets/app_providers.dart';

class ProcessTrackingScreen extends ConsumerWidget {
  final String processId;

  const ProcessTrackingScreen({super.key, required this.processId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final processState = ref.watch(processDetailProvider(processId));
    final formatter = DateFormat('dd/MM/yyyy HH:mm');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seguimiento'),
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
      body: processState.when(
        data: (process) {
          if (process == null) {
            return const Center(child: Text('Trámite no encontrado'));
          }

          final events = [...process.history]
            ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(process.policyName, style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          Chip(label: Text('Estado: ${process.status}')),
                          Chip(label: Text('Versión: ${process.policyVersion}')),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text('Iniciado: ${formatter.format(process.initiatedAt)}'),
                      if (process.completedAt != null)
                        Text('Completado: ${formatter.format(process.completedAt!)}'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text('Timeline', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              if (events.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('Aún no hay eventos en el historial.'),
                  ),
                )
              else
                ...events.map((e) {
                  final color = _statusColor(e.status);
                  final icon = _statusIcon(e.status);
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: color.withOpacity(0.15),
                        child: Icon(icon, color: color),
                      ),
                      title: Text(e.nodeName.isEmpty ? '(sin nombre)' : e.nodeName),
                      subtitle: Text(e.status),
                      trailing: Text(
                        formatter.format(e.timestamp),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  );
                }),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 12),
              Text('Error cargando seguimiento: $err'),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => ref.refresh(processDetailProvider(processId)),
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Color _statusColor(String status) {
    switch (status) {
      case 'COMPLETED':
        return Colors.green;
      case 'FAILED':
      case 'REJECTED':
        return Colors.red;
      case 'IN_PROGRESS':
      case 'RUNNING':
        return Colors.blue;
      case 'PENDING':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  static IconData _statusIcon(String status) {
    switch (status) {
      case 'COMPLETED':
        return Icons.check_circle_outline;
      case 'FAILED':
      case 'REJECTED':
        return Icons.error_outline;
      case 'IN_PROGRESS':
      case 'RUNNING':
        return Icons.timelapse;
      case 'PENDING':
        return Icons.schedule;
      default:
        return Icons.info_outline;
    }
  }
}

