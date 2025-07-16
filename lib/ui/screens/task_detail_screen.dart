import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:studies_app_flutter/l10n/app_localizations.dart';
import '../viewmodels/task_viewmodel.dart';
import '../widgets/footer.dart';

class TaskDetailScreen extends StatefulWidget {
  final String taskId;

  const TaskDetailScreen({super.key, required this.taskId});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final int id = int.tryParse(widget.taskId) ?? -1;
      if (id != -1) {
        context.read<TaskViewModel>().loadTaskDetailsById(id);
      }
    });
  }

  String _formatTaskDeadline(BuildContext context, String? dueDate, String? dueTime) {
    final l10n = AppLocalizations.of(context)!;
    if (dueDate == null && dueTime == null) {
      return l10n.prazoNaoDefinido;
    }
    
    String datePart = dueDate ?? '';
    String timePart = dueTime ?? '';

    if (datePart.isNotEmpty && timePart.isNotEmpty) {
      return '$datePart - $timePart';
    }
    return datePart + timePart;
  }

  Future<void> _confirmDeleteTask(BuildContext context) async {
    final viewModel = context.read<TaskViewModel>();
    final taskToDelete = viewModel.selectedTask;
    if (taskToDelete == null) return;

    final l10n = AppLocalizations.of(context)!;
    final bool? confirmed = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deletarTarefa),
        content: Text(l10n.confirmarDelecaoTarefa),
        actions: [
          TextButton(onPressed: () => context.pop(false), child: Text(l10n.cancelarButton)),
          TextButton(
            onPressed: () => context.pop(true),
            child: Text(l10n.deletar, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await viewModel.deleteTask(taskToDelete);
      context.pop();
    }
  }


  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.detalhesTarefaTitle),
      ),
      body: Consumer<TaskViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading || viewModel.selectedTask == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (viewModel.errorMessage != null) {
            return Center(child: Text("Erro: ${viewModel.errorMessage}"));
          }

          final task = viewModel.selectedTask!;
          final disciplineName = viewModel.selectedTaskDisciplineName;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  task.name,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                if (disciplineName != null)
                  Text(
                    disciplineName,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.grey[700]),
                  )
                else
                  Text(
                    l10n.nenhumaTarefaGeral,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.grey[700], fontStyle: FontStyle.italic),
                  ),
                const Divider(height: 32),
                
                _DetailSection(title: l10n.descricaoLabel, content: task.description ?? l10n.nenhumaDescricao),
                _DetailSection(title: l10n.prazoEntregaLabel, content: _formatTaskDeadline(context, task.dueDate, task.dueTime)),
                _DetailSection(
                  title: l10n.status,
                  content: task.isCompleted ? l10n.concluida : l10n.pendente,
                  contentColor: task.isCompleted ? Colors.green.shade700 : Colors.orange.shade700,
                ),
                const Spacer(),
                
                ElevatedButton(
                  onPressed: () {
                    viewModel.updateTaskCompletion(task, !task.isCompleted);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: task.isCompleted ? Colors.grey : Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(task.isCompleted ? l10n.marcarComoPendente : l10n.concluirTarefa),
                ),
                const SizedBox(height: 12),
                
                ElevatedButton.icon(
                  onPressed: () => _confirmDeleteTask(context),
                  icon: const Icon(Icons.delete_outline),
                  label: Text(l10n.deletarTarefa),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const Footer(currentRouteName: 'tasks'),
    );
  }
}

class _DetailSection extends StatelessWidget {
  final String title;
  final String content;
  final Color? contentColor;

  const _DetailSection({
    required this.title,
    required this.content,
    this.contentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            content,
            style: TextStyle(
              fontSize: 20,
              color: contentColor ?? Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ],
      ),
    );
  }
}