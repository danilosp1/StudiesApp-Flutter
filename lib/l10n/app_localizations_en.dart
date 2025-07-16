// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get senhaLabel => 'Password';

  @override
  String get cadastreSeButton => 'Sign Up';

  @override
  String get criarContaTitle => 'Create Account';

  @override
  String get confirmarSenhaLabel => 'Confirm Password';

  @override
  String get cadastrarButton => 'Register';

  @override
  String get jaTenhoContaButton => 'Already have an account';

  @override
  String get nomeUsuarioLabel => 'Username';

  @override
  String get camposObrigatoriosToast => 'This field is required.';

  @override
  String get loginInvalidoToast => 'Invalid username or password.';

  @override
  String get senhasNaoCoincidemToast => 'Passwords do not match.';

  @override
  String get registroSucessoToast => 'User registered successfully!';

  @override
  String get registroFalhaToast =>
      'Registration failed. Username may already exist.';

  @override
  String get appName => 'Studies';

  @override
  String olaInicio(String userName) {
    return 'Hello, $userName!';
  }

  @override
  String get aulasDoDia => 'Today\'s Classes';

  @override
  String get footerHome => 'Home';

  @override
  String get footerTasks => 'Tasks';

  @override
  String get footerDisciplines => 'Subjects';

  @override
  String get footerSettings => 'Settings';

  @override
  String get disciplinasTitulo => 'My Subjects';

  @override
  String get voltar => 'Back';

  @override
  String get materiaisLabel => 'Materials';

  @override
  String get semMateriaisCadastrados => 'No materials registered.';

  @override
  String get tarefasLabel => 'Tasks';

  @override
  String get semTarefasCadastradas =>
      'No tasks registered for this discipline.';

  @override
  String get deletarDisciplinaButton => 'Delete Discipline';

  @override
  String get adicionarLinkMaterial => 'Add Material Link';

  @override
  String get urlLink => 'Link URL';

  @override
  String get descricaoLinkOpcional => 'Description (optional)';

  @override
  String get cancelarButton => 'Cancel';

  @override
  String get adicionar => 'Add';

  @override
  String get detalhesDisciplina => 'Discipline Details';

  @override
  String get disciplinaNaoEncontrada => 'Discipline not found.';

  @override
  String get professorLabelDetail => 'Professor';

  @override
  String get horariosLabelDetail => 'Schedules';

  @override
  String get novaDisciplinaTitle => 'New Discipline';

  @override
  String get nomeLabel => 'Name';

  @override
  String get localLabel => 'Location';

  @override
  String get professorLabel => 'Professor';

  @override
  String get diasDaSemanaLabel => 'Days of the Week';

  @override
  String get horariosLabel => 'Schedules';

  @override
  String get semAulasHoje => 'No classes scheduled for today.';

  @override
  String get adicionarButton => 'Add';

  @override
  String get tarefasTitle => 'Tasks';

  @override
  String get configuracoesMainTitle => 'Settings';

  @override
  String get bemVindo => 'Welcome!';

  @override
  String get entrarButton => 'Enter';

  @override
  String get novaTarefaTitle => 'New Task';

  @override
  String get disciplinaLabel => 'Discipline';

  @override
  String get selecionarDisciplinaAction => 'Select Discipline';

  @override
  String get nenhumaDisciplinaCadastrada => 'No discipline registered';

  @override
  String get nenhumaTarefaGeral => 'None (general task)';

  @override
  String get descricaoLabel => 'Description';

  @override
  String get prazoEntregaLabel => 'Deadline';

  @override
  String get nenhumaTarefaAdicionada => 'No tasks added yet.';

  @override
  String get nenhumaDisciplinaAdicionadaAinda => 'No disciplines added yet.';

  @override
  String get deletar => 'Delete';

  @override
  String get confirmarDelecaoDisciplina =>
      'Are you sure you want to delete this discipline? This action cannot be undone.';

  @override
  String get detalhesTarefaTitle => 'Task Details';

  @override
  String get prazoNaoDefinido => 'No deadline set';

  @override
  String get deletarTarefa => 'Delete Task';

  @override
  String get confirmarDelecaoTarefa =>
      'Are you sure you want to delete this task?';

  @override
  String get status => 'Status';

  @override
  String get concluida => 'Completed';

  @override
  String get pendente => 'Pending';

  @override
  String get marcarComoPendente => 'Mark as Pending';

  @override
  String get concluirTarefa => 'Complete Task';

  @override
  String get nenhumaDescricao => 'No description provided.';

  @override
  String get contato => 'Contact';

  @override
  String get sobre => 'About';
}
