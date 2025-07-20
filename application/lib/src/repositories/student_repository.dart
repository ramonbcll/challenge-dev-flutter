import 'package:application/src/models/student.dart';

abstract interface class StudentRepository {

  Future<List<Student>> students();
  
  Future<Map<String,dynamic>> addStudent(Student student);

  Future<Map<String,dynamic>> deleteStudent(String id);

  Future<Map<String,dynamic>> updateStudent(Student student);
}
