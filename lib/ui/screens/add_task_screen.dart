
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:studies_app_flutter/l10n/app_localizations.dart';

import '../../data/models/discipline_entity.dart';
import '../../data/models/task_entity.dart';
import '../viewmodels/task_viewmodel.dart';
import '../widgets/footer.dart';

class AddTaskScreen extends StatefulWidget {
  final String? disciplineId;

  const AddTaskScreen({super.key, this.disciplineId});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  DisciplineEntity? _selectedDiscipline;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    if (widget.disciplineId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final viewModel = context.read<TaskViewModel>();
        final id = int.tryParse(widget.disciplineId!);
        if (id != null) {
          final discipline = viewModel.disciplines.firstWhere(
            (d) => d.id == id,
            orElse: () => DisciplineEntity(id: -1, name: ''),
          );
          setState(() {
            _selectedDiscipline = discipline.id == -1 ? null : discipline;
          });
          setState(() {
            _selectedDiscipline = discipline;
          });
        }
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final viewModel = context.read<TaskViewModel>();

      final newTask = TaskEntity(
        name: _nameController.text,
        description: _descriptionController.text.isNotEmpty ? _descriptionController.text : null,
        disciplineId: _selectedDiscipline?.id,
        dueDate: _selectedDate != null ? DateFormat('dd/MM/yyyy').format(_selectedDate!) : null,
        dueTime: _selectedTime != null ? '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}' : null,
        isCompleted: false,
      );

      viewModel.addTask(newTask);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final taskViewModel = context.watch<TaskViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.novaTarefaTitle)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: l10n.nomeLabel),
              validator: (value) => (value == null || value.isEmpty) ? l10n.camposObrigatoriosToast : null,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<DisciplineEntity?>(
              value: _selectedDiscipline,
              decoration: InputDecoration(
                labelText: l10n.disciplinaLabel,
                border: const OutlineInputBorder(),
              ),
              hint: Text(l10n.selecionarDisciplinaAction),
              items: [
                DropdownMenuItem<DisciplineEntity?>(
                  value: null,
                  child: Text(l10n.nenhumaTarefaGeral),
                ),
                ...taskViewModel.disciplines.map((discipline) {
                  return DropdownMenuItem<DisciplineEntity?>(
                    value: discipline,
                    child: Text(discipline.name),
                  );
                }),
              ],
              onChanged: (DisciplineEntity? newValue) {
                setState(() {
                  _selectedDiscipline = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: l10n.descricaoLabel,
                alignLabelWithHint: true,
              ),
              maxLines: 4,
              minLines: 2,
            ),
            const SizedBox(height: 24),
            Text(l10n.prazoEntregaLabel, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _DateTimePickerField(
                    label: "Data",
                    value: _selectedDate != null ? DateFormat('dd/MM/yyyy').format(_selectedDate!) : "DD/MM/AAAA",
                    onTap: () => _selectDate(context),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _DateTimePickerField(
                    label: "Horário",
                    value: _selectedTime != null ? _selectedTime!.format(context) : "HH:MM",
                    onTap: () => _selectTime(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _saveTask,
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
              child: Text(l10n.adicionarButton),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Footer(currentRouteName: 'tasks'),
    );
  }
}

class _DateTimePickerField extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const _DateTimePickerField({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(value),
            const Icon(Icons.calendar_today_outlined),
          ],
        ),
      ),
    );
  }
}