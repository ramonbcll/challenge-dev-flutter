import 'package:application/src/core/http_client.dart';
import 'package:application/src/models/student.dart';
import 'package:application/src/repositories/student_repository.dart';

class StudentRepositoryImp implements StudentRepository {
  final HttpClientCommon client;

  const StudentRepositoryImp(this.client);

  @override
  Future<List<Student>> students() async {
    try {
      final response = await client.get(HttpClientRequest(url: '/student'));
      return (response.data as List)
          .map((student) => Student.fromJson(student))
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Map<String,dynamic>> addStudent(Student student) async {
    final studentData = student.toJson();
    try {
      final response = await client.post(
        HttpClientRequest(url: '/student', body: studentData),
      );
      return response.data;
    } catch (e) {
      return {
        'success': false,
        'message': 'Erro ao adicionar estudante: $e',
      };
    }
  }
  
  @override
  Future<Map<String,dynamic>> deleteStudent(String id) async {
    int numberId = int.parse(id);
    try {
      final response = await client.delete(
        HttpClientRequest(url: '/student/$numberId'),
      );
      return response.data;
    } catch (e) {
      return {
        'success': false,
        'message': 'Erro ao deletar estudante: $e',
      };
    }
  }
}
