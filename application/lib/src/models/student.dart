// ignore_for_file: non_constant_identifier_names

class Student {
  final String name;
  final String email;
  final String birthDate;
  final String cpf;
  final String academic_record;
  final String? id;

  Student({
    required this.name,
    required this.email,
    required this.birthDate,
    required this.cpf,
    required this.academic_record,
    this.id,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      birthDate: json['birthDate'] ?? '',
      cpf: json['cpf'] ?? '',
      academic_record: json['academic_record'] ?? '',
      id: json['id'],
    );
  }

  factory Student.empty() {
    return Student(
      name: '',
      email: '',
      birthDate: '',
      academic_record: '',
      cpf: '',
    );
  }
}
