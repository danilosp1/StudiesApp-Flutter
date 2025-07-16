import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:studies_app_flutter/l10n/app_localizations.dart';
import '../../data/models/task_entity.dart';
import '../viewmodels/task_viewmodel.dart';
import '../widgets/footer.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.tarefasTitle),
        automaticallyImplyLeading: false,
      ),
      body: Consumer<TaskViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.tasks.isEmpty) {
            return Center(
              child: Text(
                l10n.nenhumaTarefaAdicionada,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: viewModel.tasks.length,
            itemBuilder: (context, index) {
              final task = viewModel.tasks[index];
              return _TaskCard(
                task: task,
                onCheckChanged: (isCompleted) {
                  viewModel.updateTaskCompletion(task, isCompleted ?? false);
                },
                onTap: () {
                  context.push('/tasks/${task.id}');
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add_task'),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const Footer(currentRouteName: 'tasks'),
    );
  }
}

class _TaskCard extends StatelessWidget {
  final TaskEntity task;
  final Function(bool?) onCheckChanged;
  final VoidCallback onTap;

  const _TaskCard({
    required this.task,
    required this.onCheckChanged,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    String deadline = task.dueDate ?? "Sem prazo";
    if (task.dueDate != null && task.dueTime != null) {
      deadline = "${task.dueDate} - ${task.dueTime}";
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          child: Row(
            children: [
              Checkbox(
                value: task.isCompleted,
                onChanged: onCheckChanged,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    if (deadline.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          deadline,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}