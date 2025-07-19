import 'package:application/src/provider/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:application/src/models/student.dart';

Future<void> studentSubmit({
  required BuildContext context,
  required GlobalKey<FormState> formKey,
  required TextEditingController nameController,
  required TextEditingController birthdateController,
  required TextEditingController cpfController,
  required TextEditingController raController,
  required TextEditingController emailController,
  required Student student,
  required RegisterController controller,
  required Function(bool) onError,
}) async {
  final isValid = formKey.currentState!.validate();
  onError(!isValid);

  if (!isValid) return;

  final newStudent = Student(
    id: student.id,
    name: nameController.text.trim(),
    birthdate: birthdateController.text.trim(),
    cpf: cpfController.text.trim().replaceAll('.', '').replaceAll('-', ''),
    academic_record: raController.text.trim(),
    email: emailController.text.trim(),
  );

  final result = newStudent.id == null
      ? await controller.addStudent(newStudent)
      : await controller.updateStudent(newStudent);

  if (!context.mounted) return;

  if (result['id'] != null) {
    final updatedStudent = newStudent.copyWith(id: result['id']);
    Navigator.of(context).pop({"success": true, "student": updatedStudent});
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          newStudent.id == null
              ? 'Erro ao cadastrar aluno.'
              : 'Erro ao atualizar aluno.',
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
