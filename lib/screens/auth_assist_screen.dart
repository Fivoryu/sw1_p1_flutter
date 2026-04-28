import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/app_providers.dart';

class AuthAssistScreen extends ConsumerStatefulWidget {
  const AuthAssistScreen({super.key});

  @override
  ConsumerState<AuthAssistScreen> createState() => _AuthAssistScreenState();
}

class _AuthAssistScreenState extends ConsumerState<AuthAssistScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final _registerFormKey = GlobalKey<FormState>();
  final _forgotFormKey = GlobalKey<FormState>();
  final _resetFormKey = GlobalKey<FormState>();

  final _regUsernameController = TextEditingController();
  final _regEmailController = TextEditingController();
  final _regPasswordController = TextEditingController();
  final _regEmpresaController = TextEditingController();

  final _identifierController = TextEditingController();
  final _empresaController = TextEditingController();
  final _tokenController = TextEditingController();
  final _newPasswordController = TextEditingController();

  bool _loadingRegister = false;
  bool _loadingForgot = false;
  bool _loadingReset = false;
  String? _error;
  String? _resetToken;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _regUsernameController.dispose();
    _regEmailController.dispose();
    _regPasswordController.dispose();
    _regEmpresaController.dispose();
    _identifierController.dispose();
    _empresaController.dispose();
    _tokenController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_registerFormKey.currentState!.validate()) return;
    setState(() {
      _loadingRegister = true;
      _error = null;
    });
    try {
      final authService = ref.read(authServiceProvider);
      final localStorage = ref.read(localStorageProvider);

      final res = await authService.registerClient(
        username: _regUsernameController.text.trim(),
        email: _regEmailController.text.trim(),
        password: _regPasswordController.text,
        empresa: _regEmpresaController.text.trim(),
      );

      final token = res['token'] as String?;
      final user = res['user'] as Map<String, dynamic>?;
      final userId = user?['id']?.toString();
      final username = user?['username']?.toString();

      if (token == null || userId == null || username == null) {
        throw Exception('Respuesta inválida del servidor');
      }

      await localStorage.saveAuthSession(token, userId, username);
      ref.read(authTokenProvider.notifier).state = token;
      ref.read(userIdProvider.notifier).state = userId;
      ref.read(usernameProvider.notifier).state = username;

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cuenta creada. Sesión iniciada.')),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      setState(() {
        _error = e.toString().replaceFirst('Exception: ', '');
      });
    } finally {
      if (mounted) setState(() => _loadingRegister = false);
    }
  }

  Future<void> _forgot() async {
    if (!_forgotFormKey.currentState!.validate()) return;
    setState(() {
      _loadingForgot = true;
      _error = null;
      _resetToken = null;
    });
    try {
      final authService = ref.read(authServiceProvider);
      final res = await authService.forgotPassword(
        identifier: _identifierController.text.trim(),
        empresa: _empresaController.text.trim(),
      );
      final token = res['resetToken']?.toString();
      setState(() {
        _resetToken = token;
        if (token != null && token.isNotEmpty) {
          _tokenController.text = token;
        }
      });
    } catch (e) {
      setState(() {
        _error = e.toString().replaceFirst('Exception: ', '');
      });
    } finally {
      if (mounted) setState(() => _loadingForgot = false);
    }
  }

  Future<void> _reset() async {
    if (!_resetFormKey.currentState!.validate()) return;
    setState(() {
      _loadingReset = true;
      _error = null;
    });
    try {
      final authService = ref.read(authServiceProvider);
      await authService.resetPassword(
        token: _tokenController.text.trim(),
        newPassword: _newPasswordController.text,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Contraseña actualizada. Ya puedes iniciar sesión.')),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      setState(() {
        _error = e.toString().replaceFirst('Exception: ', '');
      });
    } finally {
      if (mounted) setState(() => _loadingReset = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayuda de acceso'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Crear cuenta'),
            Tab(text: 'Recuperar contraseña'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (_error != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Text(_error!, style: const TextStyle(color: Colors.red)),
                ),
                const SizedBox(height: 12),
              ],
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _registerFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Registro de cliente', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _regEmpresaController,
                          decoration: const InputDecoration(
                            labelText: 'Empresa (tenant)',
                            hintText: 'Ej: Workflow Cloud',
                          ),
                          validator: (v) => (v == null || v.trim().isEmpty) ? 'Campo requerido' : null,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _regUsernameController,
                          decoration: const InputDecoration(labelText: 'Usuario'),
                          validator: (v) => (v == null || v.trim().length < 3) ? 'Mínimo 3 caracteres' : null,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _regEmailController,
                          decoration: const InputDecoration(labelText: 'Email'),
                          validator: (v) => (v == null || !v.contains('@')) ? 'Email inválido' : null,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _regPasswordController,
                          decoration: const InputDecoration(labelText: 'Contraseña (min 8)'),
                          obscureText: true,
                          validator: (v) => (v == null || v.length < 8) ? 'Debe tener al menos 8 caracteres' : null,
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _loadingRegister ? null : _register,
                            child: Text(_loadingRegister ? 'Creando...' : 'Crear cuenta'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (_error != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Text(_error!, style: const TextStyle(color: Colors.red)),
                ),
                const SizedBox(height: 12),
              ],
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _forgotFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('1) Generar token', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _identifierController,
                          decoration: const InputDecoration(
                            labelText: 'Usuario o email',
                            hintText: 'Ej: cliente_cloud / cliente@correo.com',
                          ),
                          validator: (v) => (v == null || v.trim().isEmpty) ? 'Campo requerido' : null,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _empresaController,
                          decoration: const InputDecoration(
                            labelText: 'Empresa (opcional)',
                            hintText: 'Ej: Workflow Cloud',
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _loadingForgot ? null : _forgot,
                            child: Text(_loadingForgot ? 'Generando...' : 'Generar token'),
                          ),
                        ),
                        if (_resetToken != null && _resetToken!.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          SelectableText('Token (demo): $_resetToken'),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _resetFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('2) Resetear contraseña', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _tokenController,
                          decoration: const InputDecoration(labelText: 'Token'),
                          validator: (v) => (v == null || v.trim().isEmpty) ? 'Campo requerido' : null,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _newPasswordController,
                          decoration: const InputDecoration(labelText: 'Nueva contraseña (min 8)'),
                          obscureText: true,
                          validator: (v) => (v == null || v.length < 8) ? 'Debe tener al menos 8 caracteres' : null,
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _loadingReset ? null : _reset,
                            child: Text(_loadingReset ? 'Actualizando...' : 'Actualizar contraseña'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

