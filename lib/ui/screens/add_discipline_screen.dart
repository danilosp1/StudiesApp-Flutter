import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:studies_app_flutter/l10n/app_localizations.dart';
import '../../data/models/discipline_entity.dart';
import '../../data/models/subject_schedule_entity.dart';
import '../viewmodels/discipline_viewmodel.dart';
import '../widgets/footer.dart';

class DaySchedule {
  final String dayShort;
  final String dayFull;
  bool isSelected;
  TimeOfDay startTime;
  TimeOfDay endTime;

  DaySchedule({
    required this.dayShort,
    required this.dayFull,
    this.isSelected = false,
    required this.startTime,
    required this.endTime,
  });
}

class AddDisciplineScreen extends StatefulWidget {
  const AddDisciplineScreen({super.key});

  @override
  State<AddDisciplineScreen> createState() => _AddDisciplineScreenState();
}

class _AddDisciplineScreenState extends State<AddDisciplineScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _professorController = TextEditingController();

  late final List<DaySchedule> _daySchedules;

  @override
  void initState() {
    super.initState();
    _daySchedules = _getInitialDaySchedules();
  }
  
  List<DaySchedule> _getInitialDaySchedules() {
      return [
        DaySchedule(dayShort: "Seg", dayFull: "Segunda-feira", startTime: const TimeOfDay(hour: 8, minute: 0), endTime: const TimeOfDay(hour: 12, minute: 0)),
        DaySchedule(dayShort: "Ter", dayFull: "Terça-feira", startTime: const TimeOfDay(hour: 8, minute: 0), endTime: const TimeOfDay(hour: 12, minute: 0)),
        DaySchedule(dayShort: "Qua", dayFull: "Quarta-feira", startTime: const TimeOfDay(hour: 8, minute: 0), endTime: const TimeOfDay(hour: 12, minute: 0)),
        DaySchedule(dayShort: "Qui", dayFull: "Quinta-feira", startTime: const TimeOfDay(hour: 8, minute: 0), endTime: const TimeOfDay(hour: 12, minute: 0)),
        DaySchedule(dayShort: "Sex", dayFull: "Sexta-feira", startTime: const TimeOfDay(hour: 8, minute: 0), endTime: const TimeOfDay(hour: 12, minute: 0)),
    ];
  }


  Future<void> _selectTime(BuildContext context, DaySchedule schedule, bool isStartTime) async {
    final initialTime = isStartTime ? schedule.startTime : schedule.endTime;
    final newTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (newTime != null) {
      setState(() {
        if (isStartTime) {
          schedule.startTime = newTime;
        } else {
          schedule.endTime = newTime;
        }
      });
    }
  }

  void _saveDiscipline() {
    if (_formKey.currentState!.validate()) {
      final viewModel = context.read<DisciplineViewModel>();

      final schedulesToSave = _daySchedules
          .where((day) => day.isSelected)
          .map((day) => SubjectScheduleEntity(
                disciplineId: 0,
                dayOfWeek: day.dayFull,
                startTime: day.startTime.format(context),
                endTime: day.endTime.format(context),
              ))
          .toList();

      viewModel.addDiscipline(
        DisciplineEntity(
          name: _nameController.text,
          location: _locationController.text,
          professor: _professorController.text,
        ),
        schedulesToSave,
      );

      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.novaDisciplinaTitle)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: l10n.nomeLabel),
              validator: (value) => (value == null || value.isEmpty) ? "Campo obrigatório" : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(labelText: l10n.localLabel),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _professorController,
              decoration: InputDecoration(labelText: l10n.professorLabel),
            ),
            const SizedBox(height: 24),
            Text(l10n.diasDaSemanaLabel, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _daySchedules.map((day) {
                return Column(
                  children: [
                    Text(day.dayShort),
                    Checkbox(
                      value: day.isSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          day.isSelected = value ?? false;
                        });
                      },
                    ),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Text(l10n.horariosLabel, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            ..._daySchedules.where((day) => day.isSelected).map((day) {
              return _ScheduleSelector(
                day: day,
                onSelectTime: (isStart) => _selectTime(context, day, isStart),
              );
            }),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _saveDiscipline,
              child: Text(l10n.adicionarButton),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Footer(currentRouteName: 'disciplines'),
    );
  }
}

class _ScheduleSelector extends StatelessWidget {
  final DaySchedule day;
  final Function(bool isStart) onSelectTime;

  const _ScheduleSelector({required this.day, required this.onSelectTime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(day.dayFull, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _TimePickerField(
                label: "Início",
                time: day.startTime.format(context),
                onTap: () => onSelectTime(true),
              ),
              _TimePickerField(
                label: "Fim",
                time: day.endTime.format(context),
                onTap: () => onSelectTime(false),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimePickerField extends StatelessWidget {
  final String label;
  final String time;
  final VoidCallback onTap;

  const _TimePickerField({
    required this.label,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelSmall),
        const SizedBox(height: 4),
        OutlinedButton(
          onPressed: onTap,
          child: SizedBox(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(time),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ],
    );
  }
}