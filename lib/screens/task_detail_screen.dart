import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/app_providers.dart';

class TaskDetailScreen extends ConsumerStatefulWidget {
  final String taskId;

  const TaskDetailScreen({
    Key? key,
    required this.taskId,
  }) : super(key: key);

  @override
  ConsumerState<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends ConsumerState<TaskDetailScreen> {
  bool _submitting = false;

  Future<void> _completeTask(String taskId) async {
    setState(() => _submitting = true);
    try {
      await ref.read(workflowControllerProvider.notifier).completeTask(taskId, {
        'completedByMobileClient': true,
        'completedAt': DateTime.now().toIso8601String(),
      });
      if (!mounted) return;
      ref.invalidate(tasksProvider);
      ref.invalidate(taskDetailProvider(widget.taskId));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tarea completada')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo completar la tarea: $e')),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  Future<void> _rejectTask(String taskId) async {
    final reasonController = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rechazar tarea'),
        content: TextField(
          controller: reasonController,
          decoration: const InputDecoration(
            labelText: 'Motivo',
            border: OutlineInputBorder(),
          ),
          maxLines: 2,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Rechazar'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    final reason = reasonController.text.trim();
    if (reason.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debes indicar un motivo')),
      );
      return;
    }

    setState(() => _submitting = true);
    try {
      await ref.read(workflowControllerProvider.notifier).rejectTask(taskId, reason);
      if (!mounted) return;
      ref.invalidate(tasksProvider);
      ref.invalidate(taskDetailProvider(widget.taskId));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tarea rechazada')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo rechazar la tarea: $e')),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  Future<void> _uploadDocument(String processId) async {
    final fileNameController = TextEditingController();
    final contentController = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adjuntar documento'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: fileNameController,
              decoration: const InputDecoration(
                labelText: 'Nombre de archivo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(
                labelText: 'Contenido',
                hintText: 'Pega o escribe el contenido del documento',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Enviar'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    final fileName = fileNameController.text.trim();
    final content = contentController.text.trim();
    if (fileName.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debes completar nombre y contenido')),
      );
      return;
    }

    setState(() => _submitting = true);
    try {
      await ref.read(workflowControllerProvider.notifier).uploadDocument(
            processId: processId,
            fileName: fileName,
            fileBase64: base64Encode(utf8.encode(content)),
            mimeType: 'text/plain',
          );

      if (!mounted) return;
      ref.invalidate(documentsProvider(processId));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Documento enviado')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al subir documento: $e')),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final taskFuture = ref.watch(taskDetailProvider(widget.taskId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Tarea'),
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
      body: taskFuture.when(
        data: (task) {
          if (task == null) {
            return const Center(child: Text('Tarea no encontrada'));
          }

          final documentsState = ref.watch(documentsProvider(task.processInstanceId));

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
                          task.nodeName,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 16),
                        _buildInfoRow('Estado:', task.status),
                        _buildInfoRow('Asignado a:', task.assignee),
                        _buildInfoRow('Proceso:', task.processInstanceId),
                        _buildInfoRow('Creado:', task.createdAt.toString()),
                        if (task.dueDate != null)
                          _buildInfoRow('Vencimiento:', task.dueDate.toString()),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Documentos del proceso',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    TextButton.icon(
                      onPressed: _submitting ? null : () => _uploadDocument(task.processInstanceId),
                      icon: const Icon(Icons.upload_file),
                      label: const Text('Adjuntar'),
                    ),
                  ],
                ),
                documentsState.when(
                  data: (documents) {
                    if (documents.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text('No hay documentos cargados todavía.'),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final document = documents[index];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.description_outlined),
                          title: Text(document.fileName),
                          subtitle: Text(document.status),
                        );
                      },
                    );
                  },
                  loading: () => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: CircularProgressIndicator(),
                  ),
                  error: (_, __) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text('No se pudieron cargar documentos'),
                  ),
                ),
                const SizedBox(height: 24),
                if (task.requiredDocuments != null && task.requiredDocuments!.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Documentos requeridos',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      ...task.requiredDocuments!.map(
                        (requiredDoc) => ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.insert_drive_file_outlined),
                          title: Text(requiredDoc),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                if (task.status == 'PENDING')
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _submitting ? null : () => _completeTask(task.id),
                          icon: const Icon(Icons.check),
                          label: Text(_submitting ? 'Procesando...' : 'Completar tarea'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: _submitting ? null : () => _rejectTask(task.id),
                          icon: const Icon(Icons.close),
                          label: const Text('Rechazar'),
                        ),
                      ),
                    ],
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
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 12),
              Text('Error cargando la tarea: $error'),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => ref.refresh(taskDetailProvider(widget.taskId)),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
