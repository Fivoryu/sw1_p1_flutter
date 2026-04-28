import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/app_providers.dart';

class ProcessDocumentsScreen extends ConsumerStatefulWidget {
  final String processId;

  const ProcessDocumentsScreen({super.key, required this.processId});

  @override
  ConsumerState<ProcessDocumentsScreen> createState() => _ProcessDocumentsScreenState();
}

class _ProcessDocumentsScreenState extends ConsumerState<ProcessDocumentsScreen> {
  bool _submitting = false;

  Future<void> _uploadDocument() async {
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
            processId: widget.processId,
            fileName: fileName,
            fileBase64: base64Encode(utf8.encode(content)),
            mimeType: 'text/plain',
          );
      if (!mounted) return;
      ref.invalidate(documentsProvider(widget.processId));
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
    final documentsState = ref.watch(documentsProvider(widget.processId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Documentos'),
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
        actions: [
          IconButton(
            tooltip: 'Adjuntar',
            onPressed: _submitting ? null : _uploadDocument,
            icon: const Icon(Icons.upload_file),
          ),
        ],
      ),
      body: documentsState.when(
        data: (documents) {
          if (documents.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('No hay documentos cargados para este trámite.'),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final doc = documents[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: const Icon(Icons.description_outlined),
                  title: Text(doc.fileName),
                  subtitle: Text(doc.status),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 12),
              Text('Error cargando documentos: $err'),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => ref.refresh(documentsProvider(widget.processId)),
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

