import 'package:application/src/models/student_log.dart';
import 'package:flutter/material.dart';

class StudentLogController extends ChangeNotifier {
  final List<StudentLog> _logs = [];

  List<StudentLog> get logs => List.unmodifiable(_logs);

  void addLog(StudentLog log) {
    _logs.insert(0, log);
    notifyListeners();
  }

  void clearLogs() {
    _logs.clear();
    notifyListeners();
  }
}
