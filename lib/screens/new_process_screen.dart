import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/app_providers.dart';

class NewProcessScreen extends ConsumerStatefulWidget {
  const NewProcessScreen({super.key});

  @override
  ConsumerState<NewProcessScreen> createState() => _NewProcessScreenState();
}

class _NewProcessScreenState extends ConsumerState<NewProcessScreen> {
  final _formKey = GlobalKey<FormState>();
  final _customerReferenceController = TextEditingController();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();

  String? _selectedPolicyId;
  bool _submitting = false;

  @override
  void dispose() {
    _customerReferenceController.dispose();
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _startProcess() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedPolicyId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona una política para continuar')),
      );
      return;
    }

    final userId = ref.read(currentUserProvider);
    if (userId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sesión inválida. Inicia sesión nuevamente.')),
      );
      return;
    }

    setState(() => _submitting = true);
    try {
      final process = await ref.read(workflowControllerProvider.notifier).startProcess(
            policyId: _selectedPolicyId!,
            userId: userId,
            variables: {
              'customerReference': _customerReferenceController.text.trim(),
              'requestedAmount': double.tryParse(_amountController.text.trim()) ?? 0,
              'notes': _notesController.text.trim(),
              'channel': 'mobile',
            },
          );

      if (!mounted) return;
      ref.invalidate(processesProvider);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Trámite creado correctamente')),
      );
      context.goNamed('process-detail', pathParameters: {'id': process.id});
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo iniciar el trámite: $e')),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final policiesState = ref.watch(publishedPoliciesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Trámite')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Solicitar trámite',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Selecciona una política publicada y envía los datos iniciales.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          policiesState.when(
            data: (policies) {
              if (policies.isEmpty) {
                return const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('No hay políticas publicadas disponibles.'),
                  ),
                );
              }
              return DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Política',
                  border: OutlineInputBorder(),
                ),
                value: _selectedPolicyId,
                items: policies
                    .map(
                      (p) => DropdownMenuItem<String>(
                        value: p.id,
                        child: Text('${p.name} (v${p.version})'),
                      ),
                    )
                    .toList(),
                onChanged: (value) => setState(() => _selectedPolicyId = value),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Card(
              child: ListTile(
                leading: const Icon(Icons.error_outline, color: Colors.red),
                title: const Text('No se pudieron cargar políticas'),
                subtitle: Text(error.toString()),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _customerReferenceController,
                  decoration: const InputDecoration(
                    labelText: 'Referencia de cliente',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null || value.trim().isEmpty ? 'Este campo es obligatorio' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                    labelText: 'Monto solicitado',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return 'Ingresa un monto';
                    final parsed = double.tryParse(value.trim());
                    if (parsed == null || parsed <= 0) return 'Ingresa un monto válido';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _notesController,
                  decoration: const InputDecoration(
                    labelText: 'Observaciones',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _submitting ? null : _startProcess,
              icon: const Icon(Icons.play_arrow),
              label: Text(_submitting ? 'Enviando...' : 'Iniciar trámite'),
            ),
          ),
        ],
      ),
    );
  }
}
