// ignore_for_file: non_constant_identifier_names

class Student {
  final String name;
  final String email;
  final String birthdate;
  final String cpf;
  final String academic_record;
  final String? id;

  Student({
    required this.name,
    required this.email,
    required this.birthdate,
    required this.cpf,
    required this.academic_record,
    this.id,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      birthdate: json['birthdate'] ?? '',
      cpf: json['cpf'] ?? '',
      academic_record: json['academic_record'] ?? '',
      id: json['id'],
    );
  }

  factory Student.empty() {
    return Student(
      name: '',
      email: '',
      birthdate: '',
      academic_record: '',
      cpf: '',
    );
  }

  Student copyWith({
    String? id,
    String? name,
    String? birthdate,
    String? cpf,
    String? academic_record,
    String? email,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      birthdate: birthdate ?? this.birthdate,
      cpf: cpf ?? this.cpf,
      academic_record: academic_record ?? this.academic_record,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      'name': name,
      'email': email,
      'birthdate': birthdate,
      'academic_record': academic_record,
      'cpf': cpf.replaceAll('.', '').replaceAll('-', ''),
    };

    if (id != null) {
      data['id'] = id!;
    }

    return data;
  }
}
