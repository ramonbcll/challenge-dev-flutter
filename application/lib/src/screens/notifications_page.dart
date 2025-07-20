import 'package:application/src/models/student_log.dart';
import 'package:application/src/provider/student_log_controller.dart';
import 'package:application/src/core/injector.dart';
import 'package:application/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  String _getActionLabel(StudentLogAction action) {
    switch (action) {
      case StudentLogAction.added:
        return 'adicionado';
      case StudentLogAction.edited:
        return 'editado';
      case StudentLogAction.deleted:
        return 'excluído';
    }
  }

  IconData _getActionIcon(StudentLogAction action) {
    switch (action) {
      case StudentLogAction.added:
        return Icons.add;
      case StudentLogAction.edited:
        return Icons.edit;
      case StudentLogAction.deleted:
        return Icons.delete;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = CustomInjector.instance.get<StudentLogController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações'),
        automaticallyImplyLeading: false,
      ),
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, _) {
          final logs = controller.logs;

          if (logs.isEmpty) {
            return const Center(
              child: Text(
                'Nenhuma notificação.',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: logs.length,
            itemBuilder: (context, index) {
              final log = logs[index];
              return ListTile(
                leading: Icon(
                  _getActionIcon(log.action),
                  color: AppTheme.primaryColor,
                ),
                title: Text(
                  'Aluno "${log.name}" foi ${_getActionLabel(log.action)}.',
                ),
                subtitle: Text(
                  '${log.timestamp.hour.toString().padLeft(2, '0')}:${log.timestamp.minute.toString().padLeft(2, '0')} - ${log.timestamp.day}/${log.timestamp.month}/${log.timestamp.year}',
                ),
              );
            },
          );
        },
      ),
    );
  }
}
