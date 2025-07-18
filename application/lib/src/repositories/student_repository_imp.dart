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
  Future addStudent(Student student) async {
    try {
      final response = await client.post(
        HttpClientRequest(url: '/student', body: student),
      );
      return response.data;
    } catch (e) {
      return [];
    }
  }
}
