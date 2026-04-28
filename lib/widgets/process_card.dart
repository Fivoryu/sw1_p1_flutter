import 'package:flutter/material.dart';
import '../models/workflow_models.dart';
import 'package:intl/intl.dart';

class ProcessCard extends StatelessWidget {
  final ProcessInstance process;
  final VoidCallback onTap;

  const ProcessCard({
    Key? key,
    required this.process,
    required this.onTap,
  }) : super(key: key);

  Color _getStatusColor() {
    switch (process.status) {
      case 'RUNNING':
        return Colors.blue;
      case 'COMPLETED':
        return Colors.green;
      case 'FAILED':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusLabel() {
    switch (process.status) {
      case 'RUNNING':
        return 'En ejecución';
      case 'COMPLETED':
        return 'Completado';
      case 'FAILED':
        return 'Fallido';
      default:
        return process.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: onTap,
        title: Text(
          process.policyName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'ID: ${process.id.length > 8 ? '${process.id.substring(0, 8)}...' : process.id}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              'Iniciado: ${dateFormat.format(process.initiatedAt)}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _getStatusColor().withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            _getStatusLabel(),
            style: TextStyle(
              color: _getStatusColor(),
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
