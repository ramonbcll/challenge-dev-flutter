enum StudentLogAction { added, edited, deleted }

class StudentLog {
  final String name;
  final StudentLogAction action;
  final DateTime timestamp;

  StudentLog({
    required this.name,
    required this.action,
    required this.timestamp,
  });
}
