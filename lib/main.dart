import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studies_app_flutter/l10n/app_localizations.dart';
import 'auth/user_auth_repository.dart';
import 'data/app_database.dart';
import 'data/remote/api_service.dart';
import 'data/repository/app_repository.dart';
import 'router.dart';
import 'ui/theme.dart';
import 'ui/viewmodels/discipline_viewmodel.dart';
import 'ui/viewmodels/locale_viewmodel.dart';
import 'ui/viewmodels/task_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await $FloorAppDatabase.databaseBuilder('studies_app_database.db').build();

  final apiService = ApiService();
  final repository = AppRepository(
    database.disciplineDao,
    database.taskDao,
    database.materialLinkDao,
    apiService,
  );
  final authRepository = UserAuthRepository();

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => authRepository),
        ChangeNotifierProvider(create: (_) => DisciplineViewModel(repository)),
        ChangeNotifierProvider(create: (_) => TaskViewModel(repository))
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      title: 'Studies App',
      theme: appTheme,
      routerConfig: router,

      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
    );
  }
}