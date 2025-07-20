import 'package:application/src/widgets/custom_email_form_field.dart';
import 'package:application/src/widgets/date_picker_field.dart';
import 'package:flutter/material.dart';
import 'package:application/src/core/injector.dart';
import 'package:application/src/models/student.dart';
import 'package:application/src/provider/register_controller.dart';
import 'package:application/src/utils/utils.dart';
import 'package:application/src/widgets/custom_text_form_field.dart';
import 'package:application/src/actions/register_submit.dart';

class RegisterPage extends StatefulWidget {
  final Student student;

  const RegisterPage({super.key, required this.student});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _birthdateController = TextEditingController();
  final _cpfController = TextEditingController();
  final _raController = TextEditingController();
  final _emailController = TextEditingController();

  late final RegisterController registerController;
  bool _isReadOnly = false;
  bool _showError = false;
  bool _birthdateInvalid = false;

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
  void dispose() {
    _nameController.dispose();
    _birthdateController.dispose();
    _cpfController.dispose();
    _raController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.student.name.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(isEdit ? 'Editar aluno' : 'Adicionar aluno'),
      ),
      body: ListenableBuilder(
        listenable: registerController,
        builder: (context, _) {
          if (registerController.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Dados gerais",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  if (_showError && !_birthdateInvalid)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: Text(
                        'Você precisa preencher os campos obrigatórios!',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  CustomTextFormField(
                    controller: _nameController,
                    labelText: 'Nome do aluno*',
                    showError: _showError && _nameController.text.isEmpty,
                  ),
                  const SizedBox(height: 16),
                  DatePickerField(
                    controller: _birthdateController,
                    labelText: 'Data de nascimento',
                    onChanged: (value) => setState(() {}),
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    controller: _cpfController,
                    labelText: 'CPF*',
                    readOnly: _isReadOnly,
                    inputFormatters: [cpfFormatter],
                    showError: _showError && _cpfController.text.isEmpty,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    controller: _raController,
                    labelText: 'Registro acadêmico*',
                    readOnly: _isReadOnly,
                    keyboardType: TextInputType.number,
                    showError: _showError && _raController.text.isEmpty,
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    "Dados de acesso",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  CustomEmailFormField(
                    controller: _emailController,
                    labelText: 'E-mail*',
                    keyboardType: TextInputType.emailAddress,
                    showError: _showError && _emailController.text.isEmpty,
                  ),
                  const SizedBox(height: 100),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final isValid = _formKey.currentState!.validate();
                        final birthdateText = _birthdateController.text.trim();
                        final hasBirthdate = birthdateText.isNotEmpty;
                        setState(() {
                          _showError = !isValid;
                          _birthdateInvalid =
                              hasBirthdate && !isValidDate(birthdateText);
                        });
                        if (isValid && !_birthdateInvalid) {
                          studentSubmit(
                            context: context,
                            formKey: _formKey,
                            nameController: _nameController,
                            birthdateController: _birthdateController,
                            cpfController: _cpfController,
                            raController: _raController,
                            emailController: _emailController,
                            student: widget.student,
                            controller: registerController,
                            onError: (hasError) {
                              setState(() {
                                _showError = hasError;
                              });
                            },
                          );
                        }
                      },
                      child: Text(isEdit ? 'Salvar edições' : 'Adicionar'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
