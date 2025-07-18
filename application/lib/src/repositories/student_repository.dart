import 'package:application/src/models/student.dart';

abstract interface class StudentRepository {

  Future<List<Student>> students();
  
  Future addStudent(Student student);
}

