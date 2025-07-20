import 'package:flutter/material.dart';
import 'package:application/src/models/student.dart';
import 'package:application/src/provider/student_list_controller.dart';
import 'package:application/src/utils/utils.dart';
import 'package:application/src/core/injector.dart';
import 'package:application/src/models/student_log.dart';
import 'package:application/src/provider/student_log_controller.dart';

final logController = CustomInjector.instance.get<StudentLogController>();

Future<void> handleEditStudent({
  required BuildContext context,
  required Student student,
  required StudentListController controller,
}) async {
  try {
    final response = await Navigator.pushNamed(
      context,
      '/register_page',
      arguments: {
        'student': student,
        'titleAction': 'Editar aluno',
        'buttonAction': 'Salvar',
      },
    );

    if (response is Map && response['success'] == true) {
      final updatedStudent = response['student'] as Student;
      controller.updateStudent(updatedStudent);

      logController.addLog(
        StudentLog(
          name: updatedStudent.name,
          action: StudentLogAction.edited,
          timestamp: DateTime.now(),
        ),
      );

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Aluno atualizado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  } catch (e) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Erro ao editar aluno: $e'),
        backgroundColor: Colors.red,
      ),
    );
  }
}

Future<void> handleDeleteStudent({
  required BuildContext context,
  required int index,
  required StudentListController controller,
}) async {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Excluir aluno'),
        content: const Text('Tem certeza que deseja excluir este aluno?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              try {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) =>
                      const Center(child: CircularProgressIndicator()),
                );

                final studentToDelete = controller.students[index];

                final result = await controller.deleteStudent(index);

                if (!context.mounted) return;

                Navigator.of(context).pop();

                final success = result['id'] != null;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      success
                          ? 'Aluno excluído com sucesso!'
                          : 'Erro ao excluir aluno.',
                    ),
                    backgroundColor: success ? Colors.green : Colors.red,
                  ),
                );

                if (success) {
                  logController.addLog(
                    StudentLog(
                      name: studentToDelete.name,
                      action: StudentLogAction.deleted,
                      timestamp: DateTime.now(),
                    ),
                  );
                  Navigator.of(context).pop();
                }
              } catch (e) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Erro ao excluir aluno: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text('Excluir'),
          ),
        ],
      );
    },
  );
}

Future<void> handleAddStudent({
  required BuildContext context,
  required StudentListController controller,
}) async {
  try {
    final response = await Navigator.pushNamed(
      context,
      '/register_page',
      arguments: {
        'student': Student.empty(),
        'titleAction': 'Adicionar aluno',
        'buttonAction': 'Adicionar',
      },
    );

    if (response is Map && response['success'] == true) {
      final newStudent = response['student'] as Student;
      controller.addStudent(newStudent);

      logController.addLog(
        StudentLog(
          name: newStudent.name,
          action: StudentLogAction.added,
          timestamp: DateTime.now(),
        ),
      );

      if (!context.mounted) return;

      showCustomDialog(
        context: context,
        title: 'Aviso',
        description: 'O aluno foi adicionado com sucesso!',
        primaryButtonText: 'Ok',
      );
    }
  } catch (e) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Erro ao adicionar aluno: $e'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
