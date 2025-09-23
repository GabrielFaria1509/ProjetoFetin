import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_zh.dart';

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
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('ru'),
    Locale('tr'),
    Locale('zh')
  ];

  /// Application name
  ///
  /// In pt, this message translates to:
  /// **'TISM'**
  String get app_name;

  /// Application subtitle
  ///
  /// In pt, this message translates to:
  /// **'Tudo o que você precisa saber sobre o TEA em um clique'**
  String get app_subtitle;

  /// No description provided for @app_title.
  ///
  /// In pt, this message translates to:
  /// **'TISM - Guia TEA'**
  String get app_title;

  /// No description provided for @login.
  ///
  /// In pt, this message translates to:
  /// **'Entrar'**
  String get login;

  /// No description provided for @register.
  ///
  /// In pt, this message translates to:
  /// **'Cadastrar'**
  String get register;

  /// No description provided for @email.
  ///
  /// In pt, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In pt, this message translates to:
  /// **'Senha'**
  String get password;

  /// No description provided for @confirm_password.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar senha'**
  String get confirm_password;

  /// No description provided for @name.
  ///
  /// In pt, this message translates to:
  /// **'Nome'**
  String get name;

  /// No description provided for @username.
  ///
  /// In pt, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @forgot_password.
  ///
  /// In pt, this message translates to:
  /// **'Esqueci minha senha'**
  String get forgot_password;

  /// No description provided for @login_success.
  ///
  /// In pt, this message translates to:
  /// **'Login realizado com sucesso'**
  String get login_success;

  /// No description provided for @register_success.
  ///
  /// In pt, this message translates to:
  /// **'Conta criada com sucesso'**
  String get register_success;

  /// No description provided for @logout.
  ///
  /// In pt, this message translates to:
  /// **'Sair'**
  String get logout;

  /// No description provided for @logout_confirm.
  ///
  /// In pt, this message translates to:
  /// **'Tem certeza que deseja sair da sua conta?'**
  String get logout_confirm;

  /// No description provided for @participant.
  ///
  /// In pt, this message translates to:
  /// **'Participante'**
  String get participant;

  /// No description provided for @participant_desc.
  ///
  /// In pt, this message translates to:
  /// **'Usuário comum do TISM'**
  String get participant_desc;

  /// No description provided for @responsible.
  ///
  /// In pt, this message translates to:
  /// **'Responsável'**
  String get responsible;

  /// No description provided for @responsible_desc.
  ///
  /// In pt, this message translates to:
  /// **'Familiar ou cuidador'**
  String get responsible_desc;

  /// No description provided for @professional.
  ///
  /// In pt, this message translates to:
  /// **'Profissional'**
  String get professional;

  /// No description provided for @professional_desc.
  ///
  /// In pt, this message translates to:
  /// **'Terapeuta, médico, educador'**
  String get professional_desc;

  /// No description provided for @user_type.
  ///
  /// In pt, this message translates to:
  /// **'Tipo de usuário'**
  String get user_type;

  /// No description provided for @select_user_type.
  ///
  /// In pt, this message translates to:
  /// **'Selecione seu tipo'**
  String get select_user_type;

  /// No description provided for @profile.
  ///
  /// In pt, this message translates to:
  /// **'Perfil'**
  String get profile;

  /// No description provided for @edit_profile.
  ///
  /// In pt, this message translates to:
  /// **'Editar Perfil'**
  String get edit_profile;

  /// No description provided for @edit_name.
  ///
  /// In pt, this message translates to:
  /// **'Editar Nome'**
  String get edit_name;

  /// No description provided for @edit_username.
  ///
  /// In pt, this message translates to:
  /// **'Editar Username'**
  String get edit_username;

  /// No description provided for @full_name.
  ///
  /// In pt, this message translates to:
  /// **'Nome completo'**
  String get full_name;

  /// No description provided for @account_type.
  ///
  /// In pt, this message translates to:
  /// **'Tipo de conta'**
  String get account_type;

  /// No description provided for @theme.
  ///
  /// In pt, this message translates to:
  /// **'Tema'**
  String get theme;

  /// No description provided for @light_theme.
  ///
  /// In pt, this message translates to:
  /// **'Claro'**
  String get light_theme;

  /// No description provided for @dark_theme.
  ///
  /// In pt, this message translates to:
  /// **'Escuro'**
  String get dark_theme;

  /// No description provided for @system_theme.
  ///
  /// In pt, this message translates to:
  /// **'Sistema'**
  String get system_theme;

  /// No description provided for @system_theme_desc.
  ///
  /// In pt, this message translates to:
  /// **'Segue o tema do dispositivo'**
  String get system_theme_desc;

  /// No description provided for @home.
  ///
  /// In pt, this message translates to:
  /// **'Início'**
  String get home;

  /// No description provided for @forum.
  ///
  /// In pt, this message translates to:
  /// **'Fórum'**
  String get forum;

  /// No description provided for @knowledge.
  ///
  /// In pt, this message translates to:
  /// **'Conhecimento'**
  String get knowledge;

  /// No description provided for @routine.
  ///
  /// In pt, this message translates to:
  /// **'Rotina'**
  String get routine;

  /// No description provided for @dashboard.
  ///
  /// In pt, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @feed.
  ///
  /// In pt, this message translates to:
  /// **'Feed'**
  String get feed;

  /// No description provided for @search.
  ///
  /// In pt, this message translates to:
  /// **'Buscar'**
  String get search;

  /// Greeting message with user name
  ///
  /// In pt, this message translates to:
  /// **'Olá, {name}! 👋'**
  String hello_user(String name);

  /// No description provided for @explore_content.
  ///
  /// In pt, this message translates to:
  /// **'Explore conteúdos educativos sobre o TEA'**
  String get explore_content;

  /// No description provided for @educational_feed.
  ///
  /// In pt, this message translates to:
  /// **'Feed Educativo'**
  String get educational_feed;

  /// No description provided for @custom_routine.
  ///
  /// In pt, this message translates to:
  /// **'Rotina Personalizada'**
  String get custom_routine;

  /// No description provided for @observation_diary.
  ///
  /// In pt, this message translates to:
  /// **'Diário de Observações'**
  String get observation_diary;

  /// No description provided for @tina_chatbot.
  ///
  /// In pt, this message translates to:
  /// **'Tina (Chatbot)'**
  String get tina_chatbot;

  /// No description provided for @tea_forum.
  ///
  /// In pt, this message translates to:
  /// **'Fórum TEA'**
  String get tea_forum;

  /// No description provided for @articles.
  ///
  /// In pt, this message translates to:
  /// **'Artigos'**
  String get articles;

  /// No description provided for @digital_library.
  ///
  /// In pt, this message translates to:
  /// **'Biblioteca Digital'**
  String get digital_library;

  /// No description provided for @new_post.
  ///
  /// In pt, this message translates to:
  /// **'Novo Post'**
  String get new_post;

  /// No description provided for @publish.
  ///
  /// In pt, this message translates to:
  /// **'Publicar'**
  String get publish;

  /// No description provided for @share_experience.
  ///
  /// In pt, this message translates to:
  /// **'Compartilhe sua experiência, dúvida ou dica sobre TEA...'**
  String get share_experience;

  /// No description provided for @write_something.
  ///
  /// In pt, this message translates to:
  /// **'Escreva algo antes de publicar'**
  String get write_something;

  /// No description provided for @confirm_publication.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar Publicação'**
  String get confirm_publication;

  /// No description provided for @want_to_publish.
  ///
  /// In pt, this message translates to:
  /// **'Deseja publicar este post no fórum?'**
  String get want_to_publish;

  /// No description provided for @post_published.
  ///
  /// In pt, this message translates to:
  /// **'Post publicado com sucesso!'**
  String get post_published;

  /// No description provided for @error_publishing.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao publicar post'**
  String get error_publishing;

  /// No description provided for @tina_assistant.
  ///
  /// In pt, this message translates to:
  /// **'Tina - Assistente TEA'**
  String get tina_assistant;

  /// No description provided for @thinking.
  ///
  /// In pt, this message translates to:
  /// **'Pensando...'**
  String get thinking;

  /// No description provided for @type_message.
  ///
  /// In pt, this message translates to:
  /// **'Digite sua mensagem...'**
  String get type_message;

  /// No description provided for @about_tina.
  ///
  /// In pt, this message translates to:
  /// **'💙 Sobre a Tina'**
  String get about_tina;

  /// No description provided for @tina_intro.
  ///
  /// In pt, this message translates to:
  /// **'🤖 **Olá! Eu sou a Tina!**\\n\\nSou uma assistente virtual especializada em autismo e neurodiversidade, desenvolvida especialmente para o TISM por uma equipe multidisciplinar de especialistas.'**
  String get tina_intro;

  /// No description provided for @tina_specialization.
  ///
  /// In pt, this message translates to:
  /// **'🎯 **Minha especialização:**\\n• 🧠 Desenvolvimento e comportamento\\n• 🏫 Estratégias educacionais inclusivas\\n• 💬 Técnicas de comunicação e interação social\\n• 🌍 Adaptações ambientais e sensoriais\\n• 🛠️ Recursos práticos para o dia a dia'**
  String get tina_specialization;

  /// No description provided for @tina_scientific.
  ///
  /// In pt, this message translates to:
  /// **'🔬 **Base científica:** Fui treinada com conhecimento validado por neurologistas, psicólogos, terapeutas ocupacionais, fonoaudiólogos e educadores especiais.'**
  String get tina_scientific;

  /// No description provided for @tina_important.
  ///
  /// In pt, this message translates to:
  /// **'⚠️ **Importante:** Não realizo diagnósticos nem substituo profissionais de saúde. Meu papel é complementar, oferecendo suporte informativo e prático.'**
  String get tina_important;

  /// No description provided for @tina_support.
  ///
  /// In pt, this message translates to:
  /// **'💙 **Estou aqui para apoiar você com informações confiáveis e empatia!**'**
  String get tina_support;

  /// No description provided for @understood_tina.
  ///
  /// In pt, this message translates to:
  /// **'Entendi, Tina! Vamos conversar! 😊'**
  String get understood_tina;

  /// No description provided for @tina_welcome.
  ///
  /// In pt, this message translates to:
  /// **'Olá! Sou Tina, uma assistente virtual especializada em autismo e neurodiversidade do TISM!\\n\\nEstou aqui para oferecer suporte personalizado e informações baseadas em evidências científicas sobre:\\n\\n• Desenvolvimento e comportamento\\n• Estratégias educacionais inclusivas\\n• Técnicas de comunicação e interação social\\n• Adaptações ambientais e sensoriais\\n• Recursos e ferramentas práticas para o dia a dia\\n\\nMinha base de conhecimento foi desenvolvida por uma equipe multidisciplinar de especialistas, incluindo neurologistas, psicólogos, terapeutas ocupacionais, fonoaudiólogos e educadores especiais.\\n\\nÉ importante ressaltar que não realizo diagnósticos ou substituo profissionais de saúde - meu papel é complementar, oferecendo informações confiáveis e suporte prático para famílias, cuidadores e pessoas neurodivergentes.\\n\\nComo posso ajudar você hoje?'**
  String get tina_welcome;

  /// No description provided for @diary_observations.
  ///
  /// In pt, this message translates to:
  /// **'Diário de Observações'**
  String get diary_observations;

  /// No description provided for @no_observations.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma observação ainda'**
  String get no_observations;

  /// No description provided for @tap_plus_start.
  ///
  /// In pt, this message translates to:
  /// **'Toque no + para começar'**
  String get tap_plus_start;

  /// No description provided for @report_copied.
  ///
  /// In pt, this message translates to:
  /// **'Relatório copiado! Cole em email ou WhatsApp'**
  String get report_copied;

  /// No description provided for @progress.
  ///
  /// In pt, this message translates to:
  /// **'Progresso'**
  String get progress;

  /// No description provided for @behavior.
  ///
  /// In pt, this message translates to:
  /// **'Comportamento'**
  String get behavior;

  /// No description provided for @crisis.
  ///
  /// In pt, this message translates to:
  /// **'Crise'**
  String get crisis;

  /// No description provided for @difficulty.
  ///
  /// In pt, this message translates to:
  /// **'Dificuldade'**
  String get difficulty;

  /// No description provided for @triggers.
  ///
  /// In pt, this message translates to:
  /// **'Gatilhos'**
  String get triggers;

  /// Routine title with child name
  ///
  /// In pt, this message translates to:
  /// **'Rotina de {name}'**
  String routine_of(String name);

  /// Support level text
  ///
  /// In pt, this message translates to:
  /// **'Suporte {level}'**
  String support_level(String level);

  /// No description provided for @filter_category.
  ///
  /// In pt, this message translates to:
  /// **'Filtrar por categoria:'**
  String get filter_category;

  /// No description provided for @completed.
  ///
  /// In pt, this message translates to:
  /// **'Concluídas'**
  String get completed;

  /// Progress counter
  ///
  /// In pt, this message translates to:
  /// **'Progresso: {completed}/{total}'**
  String progress_count(int completed, int total);

  /// No description provided for @no_activities.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma atividade encontrada'**
  String get no_activities;

  /// No description provided for @clear_filters.
  ///
  /// In pt, this message translates to:
  /// **'Limpar filtros'**
  String get clear_filters;

  /// No description provided for @add_activity.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar Atividade'**
  String get add_activity;

  /// No description provided for @edit_activity.
  ///
  /// In pt, this message translates to:
  /// **'Editar Atividade'**
  String get edit_activity;

  /// No description provided for @morning.
  ///
  /// In pt, this message translates to:
  /// **'Manhã'**
  String get morning;

  /// No description provided for @education.
  ///
  /// In pt, this message translates to:
  /// **'Educação'**
  String get education;

  /// No description provided for @food.
  ///
  /// In pt, this message translates to:
  /// **'Alimentação'**
  String get food;

  /// No description provided for @leisure.
  ///
  /// In pt, this message translates to:
  /// **'Lazer'**
  String get leisure;

  /// No description provided for @wellness.
  ///
  /// In pt, this message translates to:
  /// **'Bem-estar'**
  String get wellness;

  /// No description provided for @night.
  ///
  /// In pt, this message translates to:
  /// **'Noite'**
  String get night;

  /// No description provided for @all.
  ///
  /// In pt, this message translates to:
  /// **'Todas'**
  String get all;

  /// No description provided for @welcome.
  ///
  /// In pt, this message translates to:
  /// **'Olá, seja bem vindo(a)!'**
  String get welcome;

  /// No description provided for @profile_setup_desc.
  ///
  /// In pt, this message translates to:
  /// **'Para criar uma rotina personalizada, primeiro vamos configurar o perfil da criança.\\n\\nIsso nos ajuda a sugerir atividades adequadas para a idade e nível de suporte.'**
  String get profile_setup_desc;

  /// No description provided for @create_profile.
  ///
  /// In pt, this message translates to:
  /// **'Criar Perfil'**
  String get create_profile;

  /// No description provided for @edit_profile_menu.
  ///
  /// In pt, this message translates to:
  /// **'Editar Perfil'**
  String get edit_profile_menu;

  /// No description provided for @switch_child.
  ///
  /// In pt, this message translates to:
  /// **'Trocar Criança'**
  String get switch_child;

  /// No description provided for @new_child.
  ///
  /// In pt, this message translates to:
  /// **'Nova Criança'**
  String get new_child;

  /// No description provided for @select_child.
  ///
  /// In pt, this message translates to:
  /// **'Selecionar Criança'**
  String get select_child;

  /// No description provided for @verify_email.
  ///
  /// In pt, this message translates to:
  /// **'Verificar Email'**
  String get verify_email;

  /// No description provided for @verification_sent.
  ///
  /// In pt, this message translates to:
  /// **'Email de verificação enviado!'**
  String get verification_sent;

  /// No description provided for @check_email.
  ///
  /// In pt, this message translates to:
  /// **'Verifique sua caixa de entrada'**
  String get check_email;

  /// No description provided for @verification_desc.
  ///
  /// In pt, this message translates to:
  /// **'Enviamos um link de verificação para seu email. Clique no link para ativar sua conta.'**
  String get verification_desc;

  /// No description provided for @already_verified.
  ///
  /// In pt, this message translates to:
  /// **'Já verifiquei - Entrar'**
  String get already_verified;

  /// No description provided for @resend_verification.
  ///
  /// In pt, this message translates to:
  /// **'Reenviar email de verificação'**
  String get resend_verification;

  /// No description provided for @verifying.
  ///
  /// In pt, this message translates to:
  /// **'Verificando...'**
  String get verifying;

  /// No description provided for @delete_account.
  ///
  /// In pt, this message translates to:
  /// **'Deletar Conta'**
  String get delete_account;

  /// No description provided for @delete_warning.
  ///
  /// In pt, this message translates to:
  /// **'Esta ação é IRREVERSÍVEL!\\n\\nTodos os seus dados serão perdidos permanentemente.'**
  String get delete_warning;

  /// No description provided for @delete_confirmation.
  ///
  /// In pt, this message translates to:
  /// **'Para confirmar, digite exatamente:'**
  String get delete_confirmation;

  /// No description provided for @delete_phrase.
  ///
  /// In pt, this message translates to:
  /// **'DELETAR minha conta'**
  String get delete_phrase;

  /// No description provided for @delete_input_hint.
  ///
  /// In pt, this message translates to:
  /// **'Digite a frase acima'**
  String get delete_input_hint;

  /// No description provided for @delete_incorrect.
  ///
  /// In pt, this message translates to:
  /// **'Frase incorreta. Verifique maiúsculas e minúsculas.'**
  String get delete_incorrect;

  /// No description provided for @confirm_password_delete.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar senha'**
  String get confirm_password_delete;

  /// No description provided for @enter_password.
  ///
  /// In pt, this message translates to:
  /// **'Digite sua senha'**
  String get enter_password;

  /// No description provided for @save.
  ///
  /// In pt, this message translates to:
  /// **'Salvar'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar'**
  String get confirm;

  /// No description provided for @delete.
  ///
  /// In pt, this message translates to:
  /// **'Deletar'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In pt, this message translates to:
  /// **'Editar'**
  String get edit;

  /// No description provided for @add.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar'**
  String get add;

  /// No description provided for @remove.
  ///
  /// In pt, this message translates to:
  /// **'Remover'**
  String get remove;

  /// No description provided for @update.
  ///
  /// In pt, this message translates to:
  /// **'Atualizar'**
  String get update;

  /// No description provided for @close.
  ///
  /// In pt, this message translates to:
  /// **'Fechar'**
  String get close;

  /// No description provided for @ok.
  ///
  /// In pt, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @yes.
  ///
  /// In pt, this message translates to:
  /// **'Sim'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In pt, this message translates to:
  /// **'Não'**
  String get no;

  /// No description provided for @share.
  ///
  /// In pt, this message translates to:
  /// **'Compartilhar'**
  String get share;

  /// No description provided for @success.
  ///
  /// In pt, this message translates to:
  /// **'Sucesso'**
  String get success;

  /// No description provided for @error.
  ///
  /// In pt, this message translates to:
  /// **'Erro'**
  String get error;

  /// No description provided for @loading.
  ///
  /// In pt, this message translates to:
  /// **'Carregando...'**
  String get loading;

  /// No description provided for @connection_error.
  ///
  /// In pt, this message translates to:
  /// **'Erro de conexão'**
  String get connection_error;

  /// No description provided for @try_again.
  ///
  /// In pt, this message translates to:
  /// **'Tente novamente'**
  String get try_again;

  /// No description provided for @updated_successfully.
  ///
  /// In pt, this message translates to:
  /// **'Atualizado com sucesso!'**
  String get updated_successfully;

  /// No description provided for @deleted_successfully.
  ///
  /// In pt, this message translates to:
  /// **'Deletado com sucesso'**
  String get deleted_successfully;

  /// No description provided for @saved_successfully.
  ///
  /// In pt, this message translates to:
  /// **'Salvo com sucesso!'**
  String get saved_successfully;

  /// No description provided for @welcome_message.
  ///
  /// In pt, this message translates to:
  /// **'Olá, seja bem vindo(a)!'**
  String get welcome_message;

  /// No description provided for @no_account.
  ///
  /// In pt, this message translates to:
  /// **'Ainda não tem conta? Cadastre-se'**
  String get no_account;

  /// No description provided for @fill_all_fields.
  ///
  /// In pt, this message translates to:
  /// **'Preencha todos os campos'**
  String get fill_all_fields;

  /// No description provided for @login_error.
  ///
  /// In pt, this message translates to:
  /// **'Erro no login'**
  String get login_error;

  /// Connection error with details
  ///
  /// In pt, this message translates to:
  /// **'Erro de conexão: {error}'**
  String connection_error_detail(String error);

  /// No description provided for @field_required.
  ///
  /// In pt, this message translates to:
  /// **'Este campo é obrigatório'**
  String get field_required;

  /// No description provided for @invalid_email.
  ///
  /// In pt, this message translates to:
  /// **'Email inválido'**
  String get invalid_email;

  /// No description provided for @password_too_short.
  ///
  /// In pt, this message translates to:
  /// **'Senha deve ter pelo menos 8 caracteres'**
  String get password_too_short;

  /// No description provided for @passwords_dont_match.
  ///
  /// In pt, this message translates to:
  /// **'Senhas não coincidem'**
  String get passwords_dont_match;

  /// No description provided for @username_invalid.
  ///
  /// In pt, this message translates to:
  /// **'Username deve conter apenas letras minúsculas, números e _'**
  String get username_invalid;

  /// No description provided for @name_cooldown.
  ///
  /// In pt, this message translates to:
  /// **'Nome pode ser alterado apenas 1 vez por dia'**
  String get name_cooldown;

  /// No description provided for @username_cooldown.
  ///
  /// In pt, this message translates to:
  /// **'Username pode ser alterado apenas 1 vez a cada 3 dias'**
  String get username_cooldown;

  /// No description provided for @user_type_cooldown.
  ///
  /// In pt, this message translates to:
  /// **'Tipo de usuário pode ser alterado apenas 1 vez por dia'**
  String get user_type_cooldown;

  /// No description provided for @wake_up.
  ///
  /// In pt, this message translates to:
  /// **'Acordar'**
  String get wake_up;

  /// No description provided for @wake_up_desc.
  ///
  /// In pt, this message translates to:
  /// **'Despertar com música suave'**
  String get wake_up_desc;

  /// No description provided for @brush_teeth.
  ///
  /// In pt, this message translates to:
  /// **'Escovar dentes'**
  String get brush_teeth;

  /// No description provided for @brush_teeth_desc.
  ///
  /// In pt, this message translates to:
  /// **'Usar escova macia por 2 minutos'**
  String get brush_teeth_desc;

  /// No description provided for @breakfast.
  ///
  /// In pt, this message translates to:
  /// **'Café da manhã'**
  String get breakfast;

  /// No description provided for @breakfast_desc.
  ///
  /// In pt, this message translates to:
  /// **'Comer sentado na mesa'**
  String get breakfast_desc;

  /// No description provided for @educational_activity.
  ///
  /// In pt, this message translates to:
  /// **'Atividade educativa'**
  String get educational_activity;

  /// No description provided for @educational_activity_desc.
  ///
  /// In pt, this message translates to:
  /// **'Jogos educativos ou escola'**
  String get educational_activity_desc;

  /// No description provided for @snack.
  ///
  /// In pt, this message translates to:
  /// **'Lanche'**
  String get snack;

  /// No description provided for @snack_desc.
  ///
  /// In pt, this message translates to:
  /// **'Fruta ou lanche saudável'**
  String get snack_desc;

  /// No description provided for @music.
  ///
  /// In pt, this message translates to:
  /// **'Música'**
  String get music;

  /// No description provided for @music_desc.
  ///
  /// In pt, this message translates to:
  /// **'Ouvir ou tocar música'**
  String get music_desc;

  /// No description provided for @draw.
  ///
  /// In pt, this message translates to:
  /// **'Desenhar'**
  String get draw;

  /// No description provided for @draw_desc.
  ///
  /// In pt, this message translates to:
  /// **'Atividade de desenho livre'**
  String get draw_desc;

  /// No description provided for @numbers.
  ///
  /// In pt, this message translates to:
  /// **'Números'**
  String get numbers;

  /// No description provided for @numbers_desc.
  ///
  /// In pt, this message translates to:
  /// **'Jogos com números'**
  String get numbers_desc;

  /// No description provided for @sensory_break.
  ///
  /// In pt, this message translates to:
  /// **'Pausa sensorial'**
  String get sensory_break;

  /// No description provided for @sensory_break_desc.
  ///
  /// In pt, this message translates to:
  /// **'Momento de calma e autorregulação'**
  String get sensory_break_desc;

  /// No description provided for @dinner.
  ///
  /// In pt, this message translates to:
  /// **'Jantar'**
  String get dinner;

  /// No description provided for @dinner_desc.
  ///
  /// In pt, this message translates to:
  /// **'Refeição em família'**
  String get dinner_desc;

  /// No description provided for @bath.
  ///
  /// In pt, this message translates to:
  /// **'Banho'**
  String get bath;

  /// No description provided for @bath_desc.
  ///
  /// In pt, this message translates to:
  /// **'Água morna, esponja macia'**
  String get bath_desc;

  /// No description provided for @sleep.
  ///
  /// In pt, this message translates to:
  /// **'Dormir'**
  String get sleep;

  /// No description provided for @sleep_desc.
  ///
  /// In pt, this message translates to:
  /// **'Música suave para dormir'**
  String get sleep_desc;

  /// No description provided for @welcome_forum.
  ///
  /// In pt, this message translates to:
  /// **'Bem-vindo ao Fórum TEA! 💙'**
  String get welcome_forum;

  /// No description provided for @first_post_message.
  ///
  /// In pt, this message translates to:
  /// **'Seja o primeiro a compartilhar uma experiência\\nou fazer uma pergunta para a comunidade'**
  String get first_post_message;

  /// No description provided for @create_first_post.
  ///
  /// In pt, this message translates to:
  /// **'Criar primeiro post'**
  String get create_first_post;

  /// No description provided for @delete_post.
  ///
  /// In pt, this message translates to:
  /// **'Deletar Post'**
  String get delete_post;

  /// No description provided for @delete_post_confirm.
  ///
  /// In pt, this message translates to:
  /// **'Tem certeza que deseja deletar este post? Esta ação não pode ser desfeita.'**
  String get delete_post_confirm;

  /// No description provided for @post_deleted_success.
  ///
  /// In pt, this message translates to:
  /// **'Post deletado com sucesso'**
  String get post_deleted_success;

  /// Error deleting post
  ///
  /// In pt, this message translates to:
  /// **'Erro ao deletar post: {error}'**
  String error_deleting_post(String error);

  /// No description provided for @report_post.
  ///
  /// In pt, this message translates to:
  /// **'Denunciar'**
  String get report_post;

  /// No description provided for @report_post_title.
  ///
  /// In pt, this message translates to:
  /// **'Denunciar Post'**
  String get report_post_title;

  /// No description provided for @report_post_confirm.
  ///
  /// In pt, this message translates to:
  /// **'Tem certeza que deseja denunciar este post?'**
  String get report_post_confirm;

  /// No description provided for @post_reported.
  ///
  /// In pt, this message translates to:
  /// **'Post denunciado com sucesso'**
  String get post_reported;

  /// No description provided for @now.
  ///
  /// In pt, this message translates to:
  /// **'Agora'**
  String get now;

  /// No description provided for @search_posts.
  ///
  /// In pt, this message translates to:
  /// **'Buscar posts, pessoas ou tópicos...'**
  String get search_posts;

  /// No description provided for @no_results_found.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum resultado encontrado'**
  String get no_results_found;

  /// No description provided for @try_different_keywords.
  ///
  /// In pt, this message translates to:
  /// **'Tente usar palavras-chave diferentes\\nou explore as categorias abaixo'**
  String get try_different_keywords;

  /// No description provided for @type_to_search.
  ///
  /// In pt, this message translates to:
  /// **'Digite para buscar...'**
  String get type_to_search;

  /// No description provided for @find_posts_profiles.
  ///
  /// In pt, this message translates to:
  /// **'Encontre posts, perfis e hashtags\\nna comunidade TEA'**
  String get find_posts_profiles;

  /// No description provided for @popular_categories.
  ///
  /// In pt, this message translates to:
  /// **'Categorias Populares'**
  String get popular_categories;

  /// No description provided for @recent_searches.
  ///
  /// In pt, this message translates to:
  /// **'Buscas Recentes'**
  String get recent_searches;

  /// No description provided for @searches_appear_here.
  ///
  /// In pt, this message translates to:
  /// **'Suas buscas aparecerão aqui'**
  String get searches_appear_here;

  /// No description provided for @general.
  ///
  /// In pt, this message translates to:
  /// **'Geral'**
  String get general;

  /// No description provided for @tips.
  ///
  /// In pt, this message translates to:
  /// **'Dicas'**
  String get tips;

  /// No description provided for @experiences.
  ///
  /// In pt, this message translates to:
  /// **'Experiências'**
  String get experiences;

  /// No description provided for @questions.
  ///
  /// In pt, this message translates to:
  /// **'Dúvidas'**
  String get questions;

  /// No description provided for @resources.
  ///
  /// In pt, this message translates to:
  /// **'Recursos'**
  String get resources;

  /// No description provided for @how_identify_autism.
  ///
  /// In pt, this message translates to:
  /// **'Como identificar autismo?'**
  String get how_identify_autism;

  /// No description provided for @child_not_speaking.
  ///
  /// In pt, this message translates to:
  /// **'Meu filho não fala, é autismo?'**
  String get child_not_speaking;

  /// No description provided for @what_therapies_work.
  ///
  /// In pt, this message translates to:
  /// **'Que terapias funcionam?'**
  String get what_therapies_work;

  /// No description provided for @help_at_school.
  ///
  /// In pt, this message translates to:
  /// **'Como ajudar na escola?'**
  String get help_at_school;

  /// No description provided for @autism_rights.
  ///
  /// In pt, this message translates to:
  /// **'Direitos do autista'**
  String get autism_rights;

  /// No description provided for @child_tantrums.
  ///
  /// In pt, this message translates to:
  /// **'Criança com birras'**
  String get child_tantrums;

  /// No description provided for @new_observation.
  ///
  /// In pt, this message translates to:
  /// **'Nova Observação'**
  String get new_observation;

  /// No description provided for @edit_observation.
  ///
  /// In pt, this message translates to:
  /// **'Editar Observação'**
  String get edit_observation;

  /// No description provided for @observation_type.
  ///
  /// In pt, this message translates to:
  /// **'Tipo:'**
  String get observation_type;

  /// No description provided for @title.
  ///
  /// In pt, this message translates to:
  /// **'Título'**
  String get title;

  /// No description provided for @detailed_description.
  ///
  /// In pt, this message translates to:
  /// **'Descrição detalhada'**
  String get detailed_description;

  /// Intensity level
  ///
  /// In pt, this message translates to:
  /// **'Intensidade: {level}'**
  String intensity(int level);

  /// No description provided for @observer.
  ///
  /// In pt, this message translates to:
  /// **'Observador:'**
  String get observer;

  /// No description provided for @possible_triggers.
  ///
  /// In pt, this message translates to:
  /// **'Possíveis gatilhos:'**
  String get possible_triggers;

  /// No description provided for @delete_observation.
  ///
  /// In pt, this message translates to:
  /// **'Excluir Observação'**
  String get delete_observation;

  /// No description provided for @delete_observation_confirm.
  ///
  /// In pt, this message translates to:
  /// **'Tem certeza que deseja excluir esta observação?'**
  String get delete_observation_confirm;

  /// No description provided for @observation_title_empty.
  ///
  /// In pt, this message translates to:
  /// **'O título da observação não pode estar vazio'**
  String get observation_title_empty;

  /// No description provided for @not_defined.
  ///
  /// In pt, this message translates to:
  /// **'Não definido'**
  String get not_defined;

  /// No description provided for @confirm_change.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar alteração'**
  String get confirm_change;

  /// Confirm name change
  ///
  /// In pt, this message translates to:
  /// **'Alterar nome para \"{name}\"?'**
  String change_name_to(String name);

  /// Confirm username change
  ///
  /// In pt, this message translates to:
  /// **'Alterar username de @{oldName} para @{newName}?'**
  String change_username_to(String oldName, String newName);

  /// No description provided for @error_updating_name.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao atualizar nome'**
  String get error_updating_name;

  /// No description provided for @error_updating_username.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao atualizar username'**
  String get error_updating_username;

  /// No description provided for @error_updating_type.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao atualizar tipo'**
  String get error_updating_type;

  /// No description provided for @username_help.
  ///
  /// In pt, this message translates to:
  /// **'Apenas letras minúsculas, números e _'**
  String get username_help;

  /// No description provided for @username_cooldown_info.
  ///
  /// In pt, this message translates to:
  /// **'Username pode ser alterado apenas 1 vez a cada 3 dias'**
  String get username_cooldown_info;

  /// No description provided for @confirm_password_title.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar senha'**
  String get confirm_password_title;

  /// No description provided for @error_deleting_account.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao deletar conta'**
  String get error_deleting_account;

  /// No description provided for @type_updated.
  ///
  /// In pt, this message translates to:
  /// **'Tipo atualizado!'**
  String get type_updated;

  /// No description provided for @name_updated.
  ///
  /// In pt, this message translates to:
  /// **'Nome atualizado!'**
  String get name_updated;

  /// No description provided for @username_updated.
  ///
  /// In pt, this message translates to:
  /// **'Username atualizado!'**
  String get username_updated;

  /// No description provided for @account_deleted.
  ///
  /// In pt, this message translates to:
  /// **'Conta deletada com sucesso'**
  String get account_deleted;

  /// No description provided for @incorrect_password.
  ///
  /// In pt, this message translates to:
  /// **'Senha incorreta'**
  String get incorrect_password;

  /// No description provided for @user_not_found.
  ///
  /// In pt, this message translates to:
  /// **'Usuário não encontrado'**
  String get user_not_found;

  /// No description provided for @email_not_verified.
  ///
  /// In pt, this message translates to:
  /// **'Email ainda não verificado'**
  String get email_not_verified;

  /// No description provided for @verification_email_sent.
  ///
  /// In pt, this message translates to:
  /// **'Email de verificação reenviado!'**
  String get verification_email_sent;

  /// No description provided for @checking_verification.
  ///
  /// In pt, this message translates to:
  /// **'Verificando...'**
  String get checking_verification;

  /// No description provided for @already_have_account.
  ///
  /// In pt, this message translates to:
  /// **'Já tem conta? Faça login'**
  String get already_have_account;

  /// No description provided for @create_account.
  ///
  /// In pt, this message translates to:
  /// **'Criar conta'**
  String get create_account;

  /// No description provided for @account_created.
  ///
  /// In pt, this message translates to:
  /// **'Conta criada! Verifique seu email para ativar'**
  String get account_created;

  /// No description provided for @example123.
  ///
  /// In pt, this message translates to:
  /// **'exemplo123'**
  String get example123;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'ar',
        'de',
        'en',
        'es',
        'fr',
        'hi',
        'it',
        'ja',
        'ko',
        'pt',
        'ru',
        'tr',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'tr':
      return AppLocalizationsTr();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
