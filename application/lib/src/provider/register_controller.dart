import 'package:flutter/material.dart';
import 'package:application/src/models/student.dart';
import 'package:application/src/repositories/student_repository.dart';

class RegisterController extends ChangeNotifier {
  final StudentRepository _studentRepository;

  RegisterController(this._studentRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>> addStudent(Student student) async {
    try {
      _setLoading(true);
      final result = await _studentRepository.addStudent(student);
      return result;
    } finally {
      _setLoading(false);
    }
  }

  Future<Map<String, dynamic>> updateStudent(Student student) async {
    try {
      _setLoading(true);
      final result = await _studentRepository.updateStudent(student);
      return result;
    } finally {
      _setLoading(false);
    }
  }
}
