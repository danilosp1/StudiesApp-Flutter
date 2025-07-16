import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:studies_app_flutter/l10n/app_localizations.dart';
import '../viewmodels/discipline_viewmodel.dart';
import '../widgets/footer.dart';
import '../../data/models/discipline_entity.dart';

class DisciplinesScreen extends StatelessWidget {
  const DisciplinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.disciplinasTitulo),
        automaticallyImplyLeading: false,
      ),
      body: Consumer<DisciplineViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final disciplines = viewModel.disciplines;

          if (disciplines.isEmpty) {
            return Center(
              child: Text(
                l10n.nenhumaDisciplinaAdicionadaAinda,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: disciplines.length,
            itemBuilder: (context, index) {
              return _DisciplineCard(discipline: disciplines[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/add_discipline'),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const Footer(currentRouteName: 'disciplines'),
    );
  }
}

class _DisciplineCard extends StatelessWidget {
  final DisciplineEntity discipline;

  const _DisciplineCard({required this.discipline});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: InkWell(
        onTap: () {
          context.go('/disciplines/${discipline.id}');
        },
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Icon(Icons.school_outlined, size: 40, color: Colors.grey),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      discipline.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (discipline.professor != null && discipline.professor!.isNotEmpty)
                      Text(
                        'Prof: ${discipline.professor}',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    if (discipline.location != null && discipline.location!.isNotEmpty)
                      Text(
                        'Local: ${discipline.location}',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
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