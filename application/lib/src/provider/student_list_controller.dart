import 'package:flutter/material.dart';
import 'package:application/src/repositories/student_repository.dart';
import 'package:application/src/models/student.dart';

class StudentListController extends ChangeNotifier {
  final StudentRepository _studentRepository;

  StudentListController(this._studentRepository);

  List<Student> _students = [];
  List<Student> get students => _students;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchStudents() async {
    _isLoading = true;
    notifyListeners();

    try {
      final freshStudents = await _studentRepository.students();

      _students = freshStudents;
    } catch (e) {
      debugPrint('Erro ao buscar dados da API: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void addStudent(Student student) {
    _students.add(student);
    notifyListeners();
  }

  Future<Map<String, dynamic>> deleteStudent(int index) async {
    final result = await _studentRepository.deleteStudent(_students[index].id!);
    _students.removeAt(index);
    notifyListeners();
    return result;
  }
}
