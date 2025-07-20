import 'package:flutter/material.dart';
import 'package:application/src/core/injector.dart';
import 'package:application/src/provider/student_list_controller.dart';
import 'package:application/src/widgets/student_card.dart';
import 'package:application/src/actions/student_actions.dart';

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
                    onChanged: controller.filterStudents,
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
                    child: controller.filteredStudents.isEmpty
                        ? const Center(child: Text('Nenhum aluno cadastrado.'))
                        : ListView.builder(
                            padding: const EdgeInsets.only(bottom: 80),
                            itemCount: controller.filteredStudents.length,
                            itemBuilder: (context, index) {
                              final student = controller.filteredStudents[index];
                              return StudentCard(
                                student: student,
                                onEdit: () => handleEditStudent(
                                  context: context,
                                  student: student,
                                  controller: controller,
                                ),
                                onDelete: () => handleDeleteStudent(
                                  context: context,
                                  index: index,
                                  controller: controller,
                                ),
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
        onPressed: () =>
            handleAddStudent(context: context, controller: controller),
        icon: const Icon(Icons.add),
        label: const Text('Adicionar aluno'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );
  }
}
