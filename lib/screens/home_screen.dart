import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/app_providers.dart';
import '../widgets/process_card.dart';
import '../widgets/task_card.dart';
import '../widgets/sync_indicator.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  Future<void> _refreshAll() async {
    ref.invalidate(processesProvider);
    ref.invalidate(tasksProvider);
    ref.invalidate(notificationsProvider);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount = ref.watch(unreadNotificationsCountProvider);
    final processesFuture = ref.watch(processesProvider);
    final tasksFuture = ref.watch(tasksProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workflow Cliente'),
        elevation: 0,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none),
                onPressed: () => context.pushNamed('notifications'),
              ),
              if (unreadCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$unreadCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => context.pushNamed('profile'),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Procesos'),
            Tab(text: 'Tareas'),
          ],
        ),
      ),
      body: Stack(
        children: [
          TabBarView(
            controller: _tabController,
            children: [
              // Tab 1: Procesos
              processesFuture.when(
                data: (processes) {
                  return RefreshIndicator(
                    onRefresh: _refreshAll,
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
                      itemCount: processes.isEmpty ? 2 : processes.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Card(
                              child: ListTile(
                                leading: const Icon(Icons.add_circle_outline),
                                title: const Text('Solicitar nuevo trámite'),
                                subtitle: const Text('Inicia un proceso desde una política publicada'),
                                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                                onTap: () => context.pushNamed('new-process'),
                              ),
                            ),
                          );
                        }
                        if (processes.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.inbox_outlined,
                                    size: 64,
                                    color: Colors.grey[300],
                                  ),
                                  const SizedBox(height: 16),
                                  const Text('No hay procesos en ejecución'),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Puedes iniciar uno nuevo desde arriba.',
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        final process = processes[index - 1];
                        return ProcessCard(
                          process: process,
                          onTap: () => context.pushNamed(
                            'process-detail',
                            pathParameters: {'id': process.id},
                          ),
                        );
                      },
                    ),
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stack) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red[300],
                      ),
                      const SizedBox(height: 16),
                      const Text('Error cargando procesos'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          ref.invalidate(processesProvider);
                        },
                        child: const Text('Reintentar'),
                      ),
                    ],
                  ),
                ),
              ),

              // Tab 2: Tareas
              tasksFuture.when(
                data: (tasks) {
                  if (tasks.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.assignment_outlined,
                            size: 64,
                            color: Colors.grey[300],
                          ),
                          const SizedBox(height: 16),
                          const Text('No hay tareas asignadas'),
                        ],
                      ),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: _refreshAll,
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return TaskCard(
                          task: task,
                          onTap: () => context.pushNamed(
                            'task-detail',
                            pathParameters: {'id': task.id},
                          ),
                        );
                      },
                    ),
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stack) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red[300],
                      ),
                      const SizedBox(height: 16),
                      const Text('Error cargando tareas'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          ref.invalidate(tasksProvider);
                        },
                        child: const Text('Reintentar'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                final userId = ref.read(currentUserProvider);
                ref.read(workflowControllerProvider.notifier)
                    .syncAllData(userId);
                _refreshAll();
              },
              tooltip: 'Sincronizar',
              child: const Icon(Icons.refresh),
            ),
          ),
          const Positioned(
            bottom: 80,
            right: 16,
            child: SyncIndicator(),
          ),
        ],
      ),
    );
  }
}
