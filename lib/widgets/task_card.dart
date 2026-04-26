import 'package:flutter/material.dart';
import '../models/workflow_models.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;
  final VoidCallback? onComplete;

  const TaskCard({
    Key? key,
    required this.task,
    required this.onTap,
    this.onComplete,
  }) : super(key: key);

  Color _getStatusColor() {
    switch (task.status) {
      case 'PENDING':
        return Colors.orange;
      case 'IN_PROGRESS':
        return Colors.blue;
      case 'COMPLETED':
        return Colors.green;
      case 'REJECTED':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusLabel() {
    switch (task.status) {
      case 'PENDING':
        return 'Pendiente';
      case 'IN_PROGRESS':
        return 'En Progreso';
      case 'COMPLETED':
        return 'Completada';
      case 'REJECTED':
        return 'Rechazada';
      default:
        return task.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getStatusColor(),
          child: Icon(
            _getStatusIcon(),
            color: Colors.white,
          ),
        ),
        title: Text(
          task.nodeName,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'Asignado a: ${task.assignee}',
              style: const TextStyle(fontSize: 12),
            ),
            Text(
              'Creado: ${task.createdAt.toString().split('.').first}',
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
        trailing: Chip(
          label: Text(_getStatusLabel()),
          backgroundColor: _getStatusColor().withOpacity(0.3),
          labelStyle: TextStyle(
            color: _getStatusColor(),
            fontWeight: FontWeight.w600,
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  IconData _getStatusIcon() {
    switch (task.status) {
      case 'PENDING':
        return Icons.schedule;
      case 'IN_PROGRESS':
        return Icons.hourglass_bottom;
      case 'COMPLETED':
        return Icons.check_circle;
      case 'REJECTED':
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }
}
