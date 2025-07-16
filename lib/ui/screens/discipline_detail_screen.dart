import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:studies_app_flutter/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/material_link_entity.dart';
import '../../data/models/task_entity.dart';
import '../viewmodels/discipline_viewmodel.dart';
import '../widgets/footer.dart';

class DisciplineDetailScreen extends StatefulWidget {
  final String disciplineId;

  const DisciplineDetailScreen({super.key, required this.disciplineId});

  @override
  State<DisciplineDetailScreen> createState() => _DisciplineDetailScreenState();
}

class _DisciplineDetailScreenState extends State<DisciplineDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final int id = int.tryParse(widget.disciplineId) ?? -1;
      if (id != -1) {
        context.read<DisciplineViewModel>().loadDisciplineDetailsById(id);
      }
    });
  }

  Future<void> _showAddLinkDialog(BuildContext context) async {
    final viewModel = context.read<DisciplineViewModel>();
    final urlController = TextEditingController();
    final descriptionController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Text(l10n.adicionarLinkMaterial),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: urlController,
                decoration: InputDecoration(labelText: l10n.urlLink),
                keyboardType: TextInputType.url,
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: l10n.descricaoLinkOpcional),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: Text(l10n.cancelarButton),
            ),
            ElevatedButton(
              onPressed: () {
                if (urlController.text.isNotEmpty) {
                  viewModel.addMaterialLink(urlController.text, descriptionController.text);
                  context.pop();
                }
              },
              child: Text(l10n.adicionarButton),
            ),
          ],
        );
      },
    );
  }

  Future<void> _confirmDeleteDiscipline(BuildContext context) async {
    final viewModel = context.read<DisciplineViewModel>();
    final l10n = AppLocalizations.of(context)!;

    final bool? confirmed = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(l10n.deletarDisciplinaButton),
              content: Text(l10n.confirmarDelecaoDisciplina),
              actions: [
                TextButton(onPressed: () => context.pop(false), child: Text(l10n.cancelarButton)),
                TextButton(
                  onPressed: () => context.pop(true),
                  child: Text(l10n.deletar, style: TextStyle(color: Colors.red)),
                ),
              ],
            ));

    if (confirmed == true && mounted) {
      await viewModel.deleteSelectedDiscipline();
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.detalhesDisciplina),
      ),
      body: Consumer<DisciplineViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (viewModel.errorMessage != null) {
            return Center(child: Text("Erro: ${viewModel.errorMessage}"));
          }
          if (viewModel.selectedDiscipline == null) {
            return Center(child: Text(l10n.disciplinaNaoEncontrada));
          }

          final discipline = viewModel.selectedDiscipline!;
          final schedules = viewModel.selectedSchedules;
          final tasks = viewModel.selectedTasks;
          final links = viewModel.selectedMaterialLinks;
          final schedulesFormatted = schedules.map((s) => '${s.dayOfWeek}: ${s.startTime} - ${s.endTime}').join('\n');

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _DetailItem(label: l10n.professorLabelDetail, value: discipline.professor),
              _DetailItem(label: l10n.localLabel, value: discipline.location),
              if (schedulesFormatted.isNotEmpty)
                _DetailItem(label: l10n.horariosLabelDetail, value: schedulesFormatted),
              const Divider(height: 32),

              _SectionTitle(
                title: l10n.materiaisLabel,
                onAdd: () => _showAddLinkDialog(context),
              ),
              if (links.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(l10n.semMateriaisCadastrados, textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
                )
              else
                ...links.map((link) => _MaterialLinkItem(link: link)),

              const Divider(height: 32),

              _SectionTitle(
                title: l10n.tarefasLabel,
                onAdd: () => context.go('/add_task?disciplineId=${discipline.id}'),
              ),
              if (tasks.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(l10n.semTarefasCadastradas, textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
                )
              else
                ...tasks.map((task) => _TaskItem(task: task)),
              
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () => _confirmDeleteDiscipline(context),
                icon: const Icon(Icons.delete_forever),
                label: Text(l10n.deletarDisciplinaButton),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red[700], foregroundColor: Colors.white),
              )
            ],
          );
        },
      ),
      bottomNavigationBar: const Footer(currentRouteName: 'disciplines'),
    );
  }
}

class _DetailItem extends StatelessWidget {
  final String label;
  final String? value;
  const _DetailItem({required this.label, this.value});

  @override
  Widget build(BuildContext context) {
    if (value == null || value!.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: [
            TextSpan(text: '$label: ', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            TextSpan(text: value, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback onAdd;

  const _SectionTitle({required this.title, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        IconButton(icon: const Icon(Icons.add_circle_outline, color: Colors.blue), onPressed: onAdd),
      ],
    );
  }
}

class _MaterialLinkItem extends StatelessWidget {
  final MaterialLinkEntity link;
  const _MaterialLinkItem({required this.link});

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString.startsWith('http') ? urlString : 'https://$urlString');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Não foi possível abrir $urlString';
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<DisciplineViewModel>();
    return ListTile(
      leading: const Icon(Icons.link),
      title: Text(link.description ?? link.url, style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
      trailing: IconButton(
        icon: Icon(Icons.close, color: Colors.red[400]),
        onPressed: () => viewModel.deleteMaterialLink(link),
      ),
      onTap: () => _launchURL(link.url),
    );
  }
}

class _TaskItem extends StatelessWidget {
  final TaskEntity task;
  const _TaskItem({required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(task.name, style: TextStyle(decoration: task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none)),
        subtitle: task.dueDate != null ? Text("Prazo: ${task.dueDate}") : null,
        onTap: () => context.go('/tasks/${task.id}'),
        leading: Icon(task.isCompleted ? Icons.check_box : Icons.check_box_outline_blank),
      ),
    );
  }
}