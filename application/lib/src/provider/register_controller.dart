import 'package:flutter/material.dart';
import 'package:application/src/models/student.dart';
import 'package:application/src/repositories/student_repository.dart';

class RegisterController extends ChangeNotifier {
  final StudentRepository _studentRepository;

  RegisterController(this._studentRepository);

  Future<Map<String, dynamic>> addStudent(Student student) async {
    final result = await _studentRepository.addStudent(student);
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> updateStudent(Student student) async {
    final result = await _studentRepository.updateStudent(student);
    notifyListeners();
    return result;
  }
}
