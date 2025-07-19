import 'package:flutter/material.dart';
import 'package:application/src/core/injector.dart';
import 'package:application/src/models/student.dart';
import 'package:application/src/provider/register_controller.dart';
import 'package:application/src/utils/utils.dart';

class RegisterPage extends StatefulWidget {
  final Student student;

  const RegisterPage({super.key, required this.student});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _raController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isReadOnly = false;

  late final RegisterController registerController;

  bool _showError = false;

  @override
  void initState() {
    super.initState();
    registerController = CustomInjector.instance.get<RegisterController>();

    if (widget.student.name.isNotEmpty) {
      _isReadOnly = true;
      _nameController.text = widget.student.name;
      _birthdateController.text = widget.student.birthdate;
      _cpfController.text = cpfFormatter.maskText(widget.student.cpf);
      _raController.text = widget.student.academic_record;
      _emailController.text = widget.student.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.student.name.isNotEmpty ? 'Editar aluno' : 'Adicionar aluno',
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Dados gerais",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                if (_showError)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Text(
                      'Você precisa preencher os campos obrigatórios!',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    labelText: 'Nome do aluno*',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    errorStyle: TextStyle(fontSize: 0),
                    suffixIcon: _showError && _nameController.text.isEmpty
                        ? const Icon(Icons.error, color: Colors.red)
                        : null,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _birthdateController,
                  keyboardType: TextInputType.datetime,
                  inputFormatters: [dateFormatter],
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    labelText: 'Data de nascimento',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.date_range),
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        ).then((selectedDate) {
                          if (selectedDate != null) {
                            _birthdateController.text =
                                '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
                          }
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _cpfController,
                  readOnly: _isReadOnly,
                  style: TextStyle(
                    color: _isReadOnly ? Colors.grey.shade500 : Colors.black,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [cpfFormatter],
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    labelText: 'CPF*',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    errorStyle: TextStyle(fontSize: 0),
                    suffixIcon: _showError && _cpfController.text.isEmpty
                        ? const Icon(Icons.error, color: Colors.red)
                        : null,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _raController,
                  readOnly: _isReadOnly,
                  style: TextStyle(
                    color: _isReadOnly ? Colors.grey.shade500 : Colors.black,
                  ),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    labelText: 'Registro acadêmico*',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    errorStyle: TextStyle(fontSize: 0),
                    suffixIcon: _showError && _raController.text.isEmpty
                        ? const Icon(Icons.error, color: Colors.red)
                        : null,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                const Text(
                  "Dados de acesso",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    labelText: 'E-mail*',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    errorStyle: TextStyle(fontSize: 0),
                    suffixIcon: _showError && _emailController.text.isEmpty
                        ? const Icon(Icons.error, color: Colors.red)
                        : null,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 100),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final isValid = _formKey.currentState!.validate();
                      setState(() {
                        _showError = !isValid;
                      });
                      if (isValid) {
                        final student = Student(
                          id: widget.student.id,
                          name: _nameController.text.trim(),
                          birthdate: _birthdateController.text.trim(),
                          cpf: _cpfController.text.trim().replaceAll('.', '').replaceAll('-', ''),
                          academic_record: _raController.text.trim(),
                          email: _emailController.text.trim(),
                        );

                        if (student.id == null) {
                          final result = await registerController.addStudent(
                            student,
                          );

                          if (!mounted) return;

                          if (result['id'] != null) {
                            final studentWithId = student.copyWith(id: result['id']);
                            Navigator.of(context).pop({"success": true, "student": studentWithId});
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Erro ao cadastrar aluno.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                        else {
                          final result = await registerController.updateStudent(
                            student,
                          );

                          if (!mounted) return;

                          if (result['id'] != null) {
                            Navigator.of(context).pop({"success": true, "student": student});
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Erro ao atualizar aluno.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      }
                    },
                    child: Text(
                      widget.student.name.isNotEmpty ? 'Salvar edições' : 'Adicionar',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
