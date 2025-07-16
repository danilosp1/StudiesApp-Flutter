import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:studies_app_flutter/l10n/app_localizations.dart';
import '../../auth/user_auth_repository.dart';
import '../viewmodels/discipline_viewmodel.dart';
import '../widgets/footer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final username = context.watch<UserAuthRepository>().currentUsername ?? 'Usuário';
    final currentDateFormatted = DateFormat('dd/MM', 'pt_BR').format(DateTime.now());

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Text(
                l10n.olaInicio(username),
                style: const TextStyle(fontSize: 28),
              ),
              const SizedBox(height: 7),
              const Divider(thickness: 1),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(l10n.aulasDoDia, style: const TextStyle(fontSize: 33)),
                  Text(currentDateFormatted, style: const TextStyle(fontSize: 25)),
                ],
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Consumer<DisciplineViewModel>(
                  builder: (context, viewModel, child) {
                    if (viewModel.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final todaySubjects = viewModel.getTodaySubjects();

                    if (todaySubjects.isEmpty) {
                      return Center(child: Text(l10n.semAulasHoje, style: const TextStyle(fontSize: 18)));
                    }

                    return ListView.separated(
                      itemCount: todaySubjects.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 25),
                      itemBuilder: (context, index) {
                        return _SubjectCard(subject: todaySubjects[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Footer(currentRouteName: 'home'),
    );
  }
}

class _SubjectCard extends StatelessWidget {
  final SubjectUI subject;

  const _SubjectCard({required this.subject});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(subject.time, style: const TextStyle(fontSize: 25)),
        const Divider(
          color: Colors.black,
          thickness: 1,
          indent: 60,
          endIndent: 60,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.school_outlined, size: 36),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subject.name, style: const TextStyle(fontSize: 22)),
                Text(
                  subject.location,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}