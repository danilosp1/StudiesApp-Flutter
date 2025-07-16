import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt')
  ];

  /// No description provided for @senhaLabel.
  ///
  /// In pt, this message translates to:
  /// **'Senha'**
  String get senhaLabel;

  /// No description provided for @cadastreSeButton.
  ///
  /// In pt, this message translates to:
  /// **'Cadastre-se'**
  String get cadastreSeButton;

  /// No description provided for @criarContaTitle.
  ///
  /// In pt, this message translates to:
  /// **'Criar Conta'**
  String get criarContaTitle;

  /// No description provided for @confirmarSenhaLabel.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar Senha'**
  String get confirmarSenhaLabel;

  /// No description provided for @cadastrarButton.
  ///
  /// In pt, this message translates to:
  /// **'Cadastrar'**
  String get cadastrarButton;

  /// No description provided for @jaTenhoContaButton.
  ///
  /// In pt, this message translates to:
  /// **'Já tenho uma conta'**
  String get jaTenhoContaButton;

  /// No description provided for @nomeUsuarioLabel.
  ///
  /// In pt, this message translates to:
  /// **'Nome de Usuário'**
  String get nomeUsuarioLabel;

  /// No description provided for @camposObrigatoriosToast.
  ///
  /// In pt, this message translates to:
  /// **'Este campo é obrigatório.'**
  String get camposObrigatoriosToast;

  /// No description provided for @loginInvalidoToast.
  ///
  /// In pt, this message translates to:
  /// **'Usuário ou senha inválidos.'**
  String get loginInvalidoToast;

  /// No description provided for @senhasNaoCoincidemToast.
  ///
  /// In pt, this message translates to:
  /// **'As senhas não coincidem.'**
  String get senhasNaoCoincidemToast;

  /// No description provided for @registroSucessoToast.
  ///
  /// In pt, this message translates to:
  /// **'Usuário registrado com sucesso!'**
  String get registroSucessoToast;

  /// No description provided for @registroFalhaToast.
  ///
  /// In pt, this message translates to:
  /// **'Falha no registro. Nome de usuário pode já existir.'**
  String get registroFalhaToast;

  /// No description provided for @appName.
  ///
  /// In pt, this message translates to:
  /// **'Studies'**
  String get appName;

  /// No description provided for @olaInicio.
  ///
  /// In pt, this message translates to:
  /// **'Olá, {userName}!'**
  String olaInicio(String userName);

  /// No description provided for @aulasDoDia.
  ///
  /// In pt, this message translates to:
  /// **'Aulas do dia'**
  String get aulasDoDia;

  /// No description provided for @disciplinasTitulo.
  ///
  /// In pt, this message translates to:
  /// **'Suas Disciplinas'**
  String get disciplinasTitulo;

  /// No description provided for @voltar.
  ///
  /// In pt, this message translates to:
  /// **'Voltar'**
  String get voltar;

  /// No description provided for @materiaisLabel.
  ///
  /// In pt, this message translates to:
  /// **'Materiais'**
  String get materiaisLabel;

  /// No description provided for @semMateriaisCadastrados.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum material cadastrado.'**
  String get semMateriaisCadastrados;

  /// No description provided for @tarefasLabel.
  ///
  /// In pt, this message translates to:
  /// **'Tarefas'**
  String get tarefasLabel;

  /// No description provided for @semTarefasCadastradas.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma tarefa cadastrada para esta disciplina.'**
  String get semTarefasCadastradas;

  /// No description provided for @deletarDisciplinaButton.
  ///
  /// In pt, this message translates to:
  /// **'Deletar Disciplina'**
  String get deletarDisciplinaButton;

  /// No description provided for @adicionarLinkMaterial.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar Link de Material'**
  String get adicionarLinkMaterial;

  /// No description provided for @urlLink.
  ///
  /// In pt, this message translates to:
  /// **'URL do Link'**
  String get urlLink;

  /// No description provided for @descricaoLinkOpcional.
  ///
  /// In pt, this message translates to:
  /// **'Descrição (opcional)'**
  String get descricaoLinkOpcional;

  /// No description provided for @cancelarButton.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get cancelarButton;

  /// No description provided for @adicionar.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar'**
  String get adicionar;

  /// No description provided for @detalhesDisciplina.
  ///
  /// In pt, this message translates to:
  /// **'Detalhes da Disciplina'**
  String get detalhesDisciplina;

  /// No description provided for @disciplinaNaoEncontrada.
  ///
  /// In pt, this message translates to:
  /// **'Disciplina não encontrada.'**
  String get disciplinaNaoEncontrada;

  /// No description provided for @professorLabelDetail.
  ///
  /// In pt, this message translates to:
  /// **'Professor'**
  String get professorLabelDetail;

  /// No description provided for @horariosLabelDetail.
  ///
  /// In pt, this message translates to:
  /// **'Horários'**
  String get horariosLabelDetail;

  /// No description provided for @novaDisciplinaTitle.
  ///
  /// In pt, this message translates to:
  /// **'Nova Disciplina'**
  String get novaDisciplinaTitle;

  /// No description provided for @nomeLabel.
  ///
  /// In pt, this message translates to:
  /// **'Nome'**
  String get nomeLabel;

  /// No description provided for @localLabel.
  ///
  /// In pt, this message translates to:
  /// **'Local'**
  String get localLabel;

  /// No description provided for @professorLabel.
  ///
  /// In pt, this message translates to:
  /// **'Professor'**
  String get professorLabel;

  /// No description provided for @diasDaSemanaLabel.
  ///
  /// In pt, this message translates to:
  /// **'Dias da Semana'**
  String get diasDaSemanaLabel;

  /// No description provided for @horariosLabel.
  ///
  /// In pt, this message translates to:
  /// **'Horários'**
  String get horariosLabel;

  /// No description provided for @semAulasHoje.
  ///
  /// In pt, this message translates to:
  /// **'Sem aulas programadas para hoje.'**
  String get semAulasHoje;

  /// No description provided for @adicionarButton.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar'**
  String get adicionarButton;

  /// No description provided for @tarefasTitle.
  ///
  /// In pt, this message translates to:
  /// **'Tarefas'**
  String get tarefasTitle;

  /// No description provided for @configuracoesMainTitle.
  ///
  /// In pt, this message translates to:
  /// **'Configurações'**
  String get configuracoesMainTitle;

  /// No description provided for @bemVindo.
  ///
  /// In pt, this message translates to:
  /// **'Bem-Vindo(a)!'**
  String get bemVindo;

  /// No description provided for @entrarButton.
  ///
  /// In pt, this message translates to:
  /// **'Entrar'**
  String get entrarButton;

  /// No description provided for @novaTarefaTitle.
  ///
  /// In pt, this message translates to:
  /// **'Nova Tarefa'**
  String get novaTarefaTitle;

  /// No description provided for @disciplinaLabel.
  ///
  /// In pt, this message translates to:
  /// **'Disciplina'**
  String get disciplinaLabel;

  /// No description provided for @selecionarDisciplinaAction.
  ///
  /// In pt, this message translates to:
  /// **'Selecionar Disciplina'**
  String get selecionarDisciplinaAction;

  /// No description provided for @nenhumaDisciplinaCadastrada.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma disciplina cadastrada'**
  String get nenhumaDisciplinaCadastrada;

  /// No description provided for @nenhumaTarefaGeral.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma (tarefa geral)'**
  String get nenhumaTarefaGeral;

  /// No description provided for @descricaoLabel.
  ///
  /// In pt, this message translates to:
  /// **'Descrição'**
  String get descricaoLabel;

  /// No description provided for @prazoEntregaLabel.
  ///
  /// In pt, this message translates to:
  /// **'Prazo de entrega'**
  String get prazoEntregaLabel;

  /// No description provided for @nenhumaTarefaAdicionada.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma tarefa adicionada ainda.'**
  String get nenhumaTarefaAdicionada;

  /// No description provided for @nenhumaDisciplinaAdicionadaAinda.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma disciplina adicionada ainda.'**
  String get nenhumaDisciplinaAdicionadaAinda;

  /// No description provided for @deletar.
  ///
  /// In pt, this message translates to:
  /// **'Deletar'**
  String get deletar;

  /// No description provided for @confirmarDelecaoDisciplina.
  ///
  /// In pt, this message translates to:
  /// **'Você tem certeza que deseja deletar esta disciplina? Esta ação não pode ser desfeita.'**
  String get confirmarDelecaoDisciplina;

  /// No description provided for @detalhesTarefaTitle.
  ///
  /// In pt, this message translates to:
  /// **'Detalhes da Tarefa'**
  String get detalhesTarefaTitle;

  /// No description provided for @prazoNaoDefinido.
  ///
  /// In pt, this message translates to:
  /// **'Prazo não definido'**
  String get prazoNaoDefinido;

  /// No description provided for @deletarTarefa.
  ///
  /// In pt, this message translates to:
  /// **'Deletar Tarefa'**
  String get deletarTarefa;

  /// No description provided for @confirmarDelecaoTarefa.
  ///
  /// In pt, this message translates to:
  /// **'Tem certeza que deseja deletar esta tarefa?'**
  String get confirmarDelecaoTarefa;

  /// No description provided for @status.
  ///
  /// In pt, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @concluida.
  ///
  /// In pt, this message translates to:
  /// **'Concluída'**
  String get concluida;

  /// No description provided for @pendente.
  ///
  /// In pt, this message translates to:
  /// **'Pendente'**
  String get pendente;

  /// No description provided for @marcarComoPendente.
  ///
  /// In pt, this message translates to:
  /// **'Marcar como Pendente'**
  String get marcarComoPendente;

  /// No description provided for @concluirTarefa.
  ///
  /// In pt, this message translates to:
  /// **'Concluir Tarefa'**
  String get concluirTarefa;

  /// No description provided for @nenhumaDescricao.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma descrição informada.'**
  String get nenhumaDescricao;

  /// No description provided for @contato.
  ///
  /// In pt, this message translates to:
  /// **'Contato'**
  String get contato;

  /// No description provided for @sobre.
  ///
  /// In pt, this message translates to:
  /// **'Sobre'**
  String get sobre;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
