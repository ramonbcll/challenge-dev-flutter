import 'package:application/src/models/student.dart';
import 'package:application/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:application/src/core/injector.dart';
import 'package:application/src/provider/student_list_controller.dart';
import 'package:application/src/widgets/student_card.dart';

class StudentsListPage extends StatefulWidget {
  const StudentsListPage({super.key});

  @override
  State<StudentsListPage> createState() => _StudentsListPageState();
}

class _StudentsListPageState extends State<StudentsListPage> {
  late final StudentListController controller;

  @override
  void initState() {
    super.initState();
    controller = CustomInjector.instance.get<StudentListController>();
    controller.fetchStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alunos')),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListenableBuilder(
          listenable: controller,
          builder: (context, _) {
            if (controller.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Buscar...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: controller.students.isEmpty
                        ? const Center(child: Text('Nenhum aluno cadastrado.'))
                        : ListView.builder(
                            padding: const EdgeInsets.only(bottom: 80),
                            itemCount: controller.students.length,
                            itemBuilder: (context, index) {
                              final student = controller.students[index];
                              return StudentCard(
                                student: student,
                                onEdit: () async {
                                  try {
                                    final response = await Navigator.pushNamed(
                                      context,
                                      '/register_page',
                                      arguments: {
                                        'student': student,
                                        'titleAction': 'Editar aluno',
                                        'buttonAction': 'Salvar',
                                      },
                                    );

                                    if (!mounted) return;

                                    if (response is Map && response['success'] == true) {
                                      final updatedStudent = response['student'] as Student;
                                      controller.updateStudent(updatedStudent);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Aluno atualizado com sucesso!'),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Erro ao editar aluno: $e'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                },
                                onDelete: () {
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Excluir aluno'),
                                        content: const Text(
                                          'Tem certeza que deseja excluir este aluno?'
                                          ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Cancelar'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              try {
                                                showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder: (_) => const Center(child: CircularProgressIndicator()),
                                                );

                                                final result = await controller.deleteStudent(index);

                                                if (!mounted) return;

                                                Navigator.of(context).pop();

                                                if (result['id'] != null) {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(
                                                      content: Text('Aluno excluído com sucesso!'),
                                                      backgroundColor: Colors.green,
                                                    ),
                                                  );
                                                } else {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(
                                                      content: Text('Erro ao excluir aluno.'),
                                                      backgroundColor: Colors.red,
                                                    ),
                                                  );
                                                }

                                                Navigator.of(context).pop();
                                              } catch (e) {
                                                if (!mounted) return;
                                                Navigator.of(context).pop();
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Text('Erro ao excluir aluno: $e'),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              }
                                            },
                                            child: const Text('Excluir'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          FocusScope.of(context).unfocus();
          try {
            final response = await Navigator.pushNamed(
              context,
              '/register_page',
              arguments: {
                'student': Student.empty(),
                'titleAction': 'Adicionar aluno',
                'buttonAction': 'Adicionar',
              },
            );

            if (!mounted) return;

            if (response is Map && response['success'] == true) {
              final newStudent = response['student'] as Student;
              controller.addStudent(newStudent);

              showCustomDialog(
                context: context,
                title: 'Aviso',
                description: 'O aluno foi adicionado com sucesso!',
                primaryButtonText: 'Ok',
              );
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Erro ao adicionar aluno: $e'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('Adicionar aluno'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
          BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Ajuda'),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notificações',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }
}
