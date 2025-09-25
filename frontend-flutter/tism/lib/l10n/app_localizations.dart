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

  /// No description provided for @hello.
  ///
  /// In pt, this message translates to:
  /// **'Olá'**
  String get hello;

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

  /// No description provided for @personalized_routine.
  ///
  /// In pt, this message translates to:
  /// **'Rotina Personalizada'**
  String get personalized_routine;

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
  /// **'🤖 **Olá! Eu sou a Tina!**\n\nSou uma assistente virtual especializada em autismo e neurodiversidade, desenvolvida especialmente para o TISM por uma equipe multidisciplinar de especialistas.'**
  String get tina_intro;

  /// No description provided for @tina_specialization.
  ///
  /// In pt, this message translates to:
  /// **'🎯 **Minha especialização:**\n• 🧠 Desenvolvimento e comportamento\n• 🏫 Estratégias educacionais inclusivas\n• 💬 Técnicas de comunicação e interação social\n• 🌍 Adaptações ambientais e sensoriais\n• 🛠️ Recursos práticos para o dia a dia'**
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
  /// **'Olá! Sou Tina, uma assistente virtual especializada em autismo e neurodiversidade do TISM!\n\nEstou aqui para oferecer suporte personalizado e informações baseadas em evidências científicas sobre:\n\n• Desenvolvimento e comportamento\n• Estratégias educacionais inclusivas\n• Técnicas de comunicação e interação social\n• Adaptações ambientais e sensoriais\n• Recursos e ferramentas práticas para o dia a dia\n\nMinha base de conhecimento foi desenvolvida por uma equipe multidisciplinar de especialistas, incluindo neurologistas, psicólogos, terapeutas ocupacionais, fonoaudiólogos e educadores especiais.\n\nÉ importante ressaltar que não realizo diagnósticos ou substituo profissionais de saúde - meu papel é complementar, oferecendo informações confiáveis e suporte prático para famílias, cuidadores e pessoas neurodivergentes.\n\nComo posso ajudar você hoje?'**
  String get tina_welcome;

  /// No description provided for @tina_connection_error.
  ///
  /// In pt, this message translates to:
  /// **'Estou com dificuldades para me conectar no momento. Muitos usuários estão utilizando o sistema. Tente novamente em alguns minutos! 😅'**
  String get tina_connection_error;

  /// No description provided for @tina_general_error.
  ///
  /// In pt, this message translates to:
  /// **'Ops! Algo deu errado por aqui. Tente novamente em alguns instantes! 🤖'**
  String get tina_general_error;

  /// No description provided for @tina_api_key_error.
  ///
  /// In pt, this message translates to:
  /// **'Chave da API inválida. Verifique se a chave do Gemini está correta no arquivo .env'**
  String get tina_api_key_error;

  /// No description provided for @tina_quota_error.
  ///
  /// In pt, this message translates to:
  /// **'Limite de uso da API excedido. Tente novamente mais tarde.'**
  String get tina_quota_error;

  /// No description provided for @tina_network_error.
  ///
  /// In pt, this message translates to:
  /// **'Erro de conexão. Verifique sua internet e tente novamente.'**
  String get tina_network_error;

  /// No description provided for @diary_observations.
  ///
  /// In pt, this message translates to:
  /// **'Observações do Diário'**
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
  /// **'Para criar uma rotina personalizada, primeiro vamos configurar o perfil da criança.\n\nIsso nos ajuda a sugerir atividades adequadas para a idade e nível de suporte.'**
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
  /// **'Clique no link do email para ativar sua conta.\nVocê será redirecionado automaticamente.'**
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
  /// **'Esta ação é IRREVERSÍVEL!\n\nTodos os seus dados serão perdidos permanentemente.'**
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
  /// **'Seja o primeiro a compartilhar uma experiência\nou fazer uma pergunta para a comunidade'**
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
  /// **'Tente usar palavras-chave diferentes\nou explore as categorias abaixo'**
  String get try_different_keywords;

  /// No description provided for @type_to_search.
  ///
  /// In pt, this message translates to:
  /// **'Digite para buscar...'**
  String get type_to_search;

  /// No description provided for @find_posts_profiles.
  ///
  /// In pt, this message translates to:
  /// **'Encontre posts, perfis e hashtags\nna comunidade TEA'**
  String get find_posts_profiles;

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

  /// No description provided for @new_routine.
  ///
  /// In pt, this message translates to:
  /// **'Nova Rotina'**
  String get new_routine;

  /// No description provided for @edit_routine.
  ///
  /// In pt, this message translates to:
  /// **'Editar Rotina'**
  String get edit_routine;

  /// No description provided for @activity_title.
  ///
  /// In pt, this message translates to:
  /// **'Título da atividade'**
  String get activity_title;

  /// No description provided for @activity_description.
  ///
  /// In pt, this message translates to:
  /// **'Descrição da atividade'**
  String get activity_description;

  /// No description provided for @time_format.
  ///
  /// In pt, this message translates to:
  /// **'Horário (00:00 - 23:59)'**
  String get time_format;

  /// No description provided for @category.
  ///
  /// In pt, this message translates to:
  /// **'Categoria'**
  String get category;

  /// No description provided for @icon.
  ///
  /// In pt, this message translates to:
  /// **'Ícone'**
  String get icon;

  /// No description provided for @color.
  ///
  /// In pt, this message translates to:
  /// **'Cor'**
  String get color;

  /// No description provided for @create_routine.
  ///
  /// In pt, this message translates to:
  /// **'Criar Rotina'**
  String get create_routine;

  /// No description provided for @save_changes.
  ///
  /// In pt, this message translates to:
  /// **'Salvar Alterações'**
  String get save_changes;

  /// No description provided for @routine_title_empty.
  ///
  /// In pt, this message translates to:
  /// **'O título da rotina não pode estar vazio'**
  String get routine_title_empty;

  /// No description provided for @invalid_time_format.
  ///
  /// In pt, this message translates to:
  /// **'Horário inválido. Use formato 24h (00:00 - 23:59)'**
  String get invalid_time_format;

  /// No description provided for @delete_routine.
  ///
  /// In pt, this message translates to:
  /// **'Deletar Rotina'**
  String get delete_routine;

  /// No description provided for @delete_routine_confirm.
  ///
  /// In pt, this message translates to:
  /// **'Tem certeza que deseja deletar esta rotina?'**
  String get delete_routine_confirm;

  /// No description provided for @hello_user_name.
  ///
  /// In pt, this message translates to:
  /// **'Olá, {name}! 👋'**
  String hello_user_name(Object name);

  /// No description provided for @statistics.
  ///
  /// In pt, this message translates to:
  /// **'Estatísticas'**
  String get statistics;

  /// No description provided for @general_summary.
  ///
  /// In pt, this message translates to:
  /// **'Resumo Geral'**
  String get general_summary;

  /// No description provided for @total.
  ///
  /// In pt, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @progress_plural.
  ///
  /// In pt, this message translates to:
  /// **'Progressos'**
  String get progress_plural;

  /// No description provided for @crisis_plural.
  ///
  /// In pt, this message translates to:
  /// **'Crises'**
  String get crisis_plural;

  /// No description provided for @type_distribution.
  ///
  /// In pt, this message translates to:
  /// **'Distribuição por Tipo'**
  String get type_distribution;

  /// No description provided for @most_frequent_triggers.
  ///
  /// In pt, this message translates to:
  /// **'Gatilhos Mais Frequentes'**
  String get most_frequent_triggers;

  /// No description provided for @weekly_trend.
  ///
  /// In pt, this message translates to:
  /// **'Tendência Semanal'**
  String get weekly_trend;

  /// Observations count in last 7 days
  ///
  /// In pt, this message translates to:
  /// **'Observações nos últimos 7 dias: {count}'**
  String observations_last_7_days(int count);

  /// No description provided for @child_name.
  ///
  /// In pt, this message translates to:
  /// **'Nome da criança'**
  String get child_name;

  /// No description provided for @age.
  ///
  /// In pt, this message translates to:
  /// **'Idade'**
  String get age;

  /// No description provided for @support_level_label.
  ///
  /// In pt, this message translates to:
  /// **'Nível de suporte'**
  String get support_level_label;

  /// No description provided for @sensory_preferences.
  ///
  /// In pt, this message translates to:
  /// **'Preferências sensoriais'**
  String get sensory_preferences;

  /// No description provided for @interests.
  ///
  /// In pt, this message translates to:
  /// **'Interesses'**
  String get interests;

  /// No description provided for @child_name_empty.
  ///
  /// In pt, this message translates to:
  /// **'O nome da criança não pode estar vazio'**
  String get child_name_empty;

  /// Observations count in last 7 days
  ///
  /// In pt, this message translates to:
  /// **'Observações nos últimos 7 dias: {count}'**
  String observations_last_7_days_count(int count);

  /// No description provided for @configure_profile.
  ///
  /// In pt, this message translates to:
  /// **'Configurar Perfil'**
  String get configure_profile;

  /// No description provided for @edit_username_title.
  ///
  /// In pt, this message translates to:
  /// **'Editar Username'**
  String get edit_username_title;

  /// No description provided for @account_deleted_success.
  ///
  /// In pt, this message translates to:
  /// **'Conta deletada com sucesso'**
  String get account_deleted_success;

  /// No description provided for @theme_light.
  ///
  /// In pt, this message translates to:
  /// **'Claro'**
  String get theme_light;

  /// No description provided for @theme_dark.
  ///
  /// In pt, this message translates to:
  /// **'Escuro'**
  String get theme_dark;

  /// No description provided for @theme_system.
  ///
  /// In pt, this message translates to:
  /// **'Sistema'**
  String get theme_system;

  /// No description provided for @edit_observation_action.
  ///
  /// In pt, this message translates to:
  /// **'Editar observação'**
  String get edit_observation_action;

  /// No description provided for @delete_observation_action.
  ///
  /// In pt, this message translates to:
  /// **'Deletar observação'**
  String get delete_observation_action;

  /// No description provided for @delete_observation_title.
  ///
  /// In pt, this message translates to:
  /// **'Deletar Observação'**
  String get delete_observation_title;

  /// No description provided for @delete_observation_message.
  ///
  /// In pt, this message translates to:
  /// **'Tem certeza que deseja deletar esta observação?'**
  String get delete_observation_message;

  /// No description provided for @trigger_routine_change.
  ///
  /// In pt, this message translates to:
  /// **'Mudança de rotina'**
  String get trigger_routine_change;

  /// No description provided for @trigger_loud_noise.
  ///
  /// In pt, this message translates to:
  /// **'Barulho alto'**
  String get trigger_loud_noise;

  /// No description provided for @trigger_crowd.
  ///
  /// In pt, this message translates to:
  /// **'Multidão'**
  String get trigger_crowd;

  /// No description provided for @trigger_tiredness.
  ///
  /// In pt, this message translates to:
  /// **'Cansaço'**
  String get trigger_tiredness;

  /// No description provided for @trigger_hunger.
  ///
  /// In pt, this message translates to:
  /// **'Fome'**
  String get trigger_hunger;

  /// No description provided for @trigger_frustration.
  ///
  /// In pt, this message translates to:
  /// **'Frustração'**
  String get trigger_frustration;

  /// No description provided for @trigger_transition.
  ///
  /// In pt, this message translates to:
  /// **'Transição'**
  String get trigger_transition;

  /// No description provided for @trigger_new_environment.
  ///
  /// In pt, this message translates to:
  /// **'Ambiente novo'**
  String get trigger_new_environment;

  /// No description provided for @trigger_bright_light.
  ///
  /// In pt, this message translates to:
  /// **'Luz muito forte'**
  String get trigger_bright_light;

  /// No description provided for @trigger_unpleasant_texture.
  ///
  /// In pt, this message translates to:
  /// **'Textura desagradável'**
  String get trigger_unpleasant_texture;

  /// No description provided for @trigger_strong_smell.
  ///
  /// In pt, this message translates to:
  /// **'Cheiro forte'**
  String get trigger_strong_smell;

  /// No description provided for @trigger_temperature.
  ///
  /// In pt, this message translates to:
  /// **'Temperatura'**
  String get trigger_temperature;

  /// No description provided for @trigger_tight_clothes.
  ///
  /// In pt, this message translates to:
  /// **'Roupa apertada'**
  String get trigger_tight_clothes;

  /// No description provided for @trigger_insufficient_sleep.
  ///
  /// In pt, this message translates to:
  /// **'Sono insuficiente'**
  String get trigger_insufficient_sleep;

  /// No description provided for @trigger_physical_pain.
  ///
  /// In pt, this message translates to:
  /// **'Dor física'**
  String get trigger_physical_pain;

  /// No description provided for @trigger_medication.
  ///
  /// In pt, this message translates to:
  /// **'Medicação'**
  String get trigger_medication;

  /// No description provided for @trigger_medical_visit.
  ///
  /// In pt, this message translates to:
  /// **'Visita médica'**
  String get trigger_medical_visit;

  /// No description provided for @trigger_new_school.
  ///
  /// In pt, this message translates to:
  /// **'Escola nova'**
  String get trigger_new_school;

  /// No description provided for @trigger_substitute_teacher.
  ///
  /// In pt, this message translates to:
  /// **'Professor substituto'**
  String get trigger_substitute_teacher;

  /// No description provided for @trigger_test_evaluation.
  ///
  /// In pt, this message translates to:
  /// **'Prova/avaliação'**
  String get trigger_test_evaluation;

  /// No description provided for @trigger_party_event.
  ///
  /// In pt, this message translates to:
  /// **'Festa/evento'**
  String get trigger_party_event;

  /// No description provided for @trigger_travel.
  ///
  /// In pt, this message translates to:
  /// **'Viagem'**
  String get trigger_travel;

  /// No description provided for @trigger_rain_storm.
  ///
  /// In pt, this message translates to:
  /// **'Chuva/temporal'**
  String get trigger_rain_storm;

  /// No description provided for @trigger_parents_separation.
  ///
  /// In pt, this message translates to:
  /// **'Separação dos pais'**
  String get trigger_parents_separation;

  /// No description provided for @trigger_broken_toy.
  ///
  /// In pt, this message translates to:
  /// **'Brinquedo quebrado'**
  String get trigger_broken_toy;

  /// No description provided for @trigger_not_getting_something.
  ///
  /// In pt, this message translates to:
  /// **'Não conseguir algo'**
  String get trigger_not_getting_something;

  /// No description provided for @trigger_activity_interruption.
  ///
  /// In pt, this message translates to:
  /// **'Interrupção atividade'**
  String get trigger_activity_interruption;

  /// No description provided for @trigger_waiting_too_long.
  ///
  /// In pt, this message translates to:
  /// **'Esperar muito tempo'**
  String get trigger_waiting_too_long;

  /// No description provided for @observer_father.
  ///
  /// In pt, this message translates to:
  /// **'pai'**
  String get observer_father;

  /// No description provided for @observer_mother.
  ///
  /// In pt, this message translates to:
  /// **'mãe'**
  String get observer_mother;

  /// No description provided for @observer_grandfather.
  ///
  /// In pt, this message translates to:
  /// **'avô'**
  String get observer_grandfather;

  /// No description provided for @observer_grandmother.
  ///
  /// In pt, this message translates to:
  /// **'avó'**
  String get observer_grandmother;

  /// No description provided for @observer_uncle.
  ///
  /// In pt, this message translates to:
  /// **'tio'**
  String get observer_uncle;

  /// No description provided for @observer_aunt.
  ///
  /// In pt, this message translates to:
  /// **'tia'**
  String get observer_aunt;

  /// No description provided for @observer_brother.
  ///
  /// In pt, this message translates to:
  /// **'irmão'**
  String get observer_brother;

  /// No description provided for @observer_sister.
  ///
  /// In pt, this message translates to:
  /// **'irmã'**
  String get observer_sister;

  /// No description provided for @observer_son.
  ///
  /// In pt, this message translates to:
  /// **'filho'**
  String get observer_son;

  /// No description provided for @observer_daughter.
  ///
  /// In pt, this message translates to:
  /// **'filha'**
  String get observer_daughter;

  /// No description provided for @observer_grandson.
  ///
  /// In pt, this message translates to:
  /// **'neto'**
  String get observer_grandson;

  /// No description provided for @observer_granddaughter.
  ///
  /// In pt, this message translates to:
  /// **'neta'**
  String get observer_granddaughter;

  /// No description provided for @observer_nephew.
  ///
  /// In pt, this message translates to:
  /// **'sobrinho'**
  String get observer_nephew;

  /// No description provided for @observer_niece.
  ///
  /// In pt, this message translates to:
  /// **'sobrinha'**
  String get observer_niece;

  /// No description provided for @observer_male_cousin.
  ///
  /// In pt, this message translates to:
  /// **'primo'**
  String get observer_male_cousin;

  /// No description provided for @observer_female_cousin.
  ///
  /// In pt, this message translates to:
  /// **'prima'**
  String get observer_female_cousin;

  /// No description provided for @observer_male_friend.
  ///
  /// In pt, this message translates to:
  /// **'amigo'**
  String get observer_male_friend;

  /// No description provided for @observer_female_friend.
  ///
  /// In pt, this message translates to:
  /// **'amiga'**
  String get observer_female_friend;

  /// No description provided for @observer_relative.
  ///
  /// In pt, this message translates to:
  /// **'parente'**
  String get observer_relative;

  /// No description provided for @observer_caregiver.
  ///
  /// In pt, this message translates to:
  /// **'cuidador'**
  String get observer_caregiver;

  /// No description provided for @observer_teacher.
  ///
  /// In pt, this message translates to:
  /// **'professor'**
  String get observer_teacher;

  /// No description provided for @observer_therapist.
  ///
  /// In pt, this message translates to:
  /// **'terapeuta'**
  String get observer_therapist;

  /// No description provided for @observer_doctor.
  ///
  /// In pt, this message translates to:
  /// **'médico'**
  String get observer_doctor;

  /// No description provided for @observer_psychologist.
  ///
  /// In pt, this message translates to:
  /// **'psicólogo'**
  String get observer_psychologist;

  /// No description provided for @support_level_mild.
  ///
  /// In pt, this message translates to:
  /// **'leve'**
  String get support_level_mild;

  /// No description provided for @support_level_moderate.
  ///
  /// In pt, this message translates to:
  /// **'moderado'**
  String get support_level_moderate;

  /// No description provided for @support_level_severe.
  ///
  /// In pt, this message translates to:
  /// **'severo'**
  String get support_level_severe;

  /// No description provided for @sensory_visual.
  ///
  /// In pt, this message translates to:
  /// **'Visual'**
  String get sensory_visual;

  /// No description provided for @sensory_auditory.
  ///
  /// In pt, this message translates to:
  /// **'Auditivo'**
  String get sensory_auditory;

  /// No description provided for @sensory_tactile.
  ///
  /// In pt, this message translates to:
  /// **'Tátil'**
  String get sensory_tactile;

  /// No description provided for @sensory_movement.
  ///
  /// In pt, this message translates to:
  /// **'Movimento'**
  String get sensory_movement;

  /// No description provided for @sensory_olfactory.
  ///
  /// In pt, this message translates to:
  /// **'Olfativo'**
  String get sensory_olfactory;

  /// No description provided for @sensory_gustatory.
  ///
  /// In pt, this message translates to:
  /// **'Gustativo'**
  String get sensory_gustatory;

  /// No description provided for @sensory_proprioceptive.
  ///
  /// In pt, this message translates to:
  /// **'Proprioceptivo'**
  String get sensory_proprioceptive;

  /// No description provided for @sensory_vestibular.
  ///
  /// In pt, this message translates to:
  /// **'Vestibular'**
  String get sensory_vestibular;

  /// No description provided for @sensory_deep_pressure.
  ///
  /// In pt, this message translates to:
  /// **'Pressão Profunda'**
  String get sensory_deep_pressure;

  /// No description provided for @sensory_soft_textures.
  ///
  /// In pt, this message translates to:
  /// **'Texturas Suaves'**
  String get sensory_soft_textures;

  /// No description provided for @sensory_rough_textures.
  ///
  /// In pt, this message translates to:
  /// **'Texturas Ásperas'**
  String get sensory_rough_textures;

  /// No description provided for @sensory_low_sounds.
  ///
  /// In pt, this message translates to:
  /// **'Sons Baixos'**
  String get sensory_low_sounds;

  /// No description provided for @sensory_high_sounds.
  ///
  /// In pt, this message translates to:
  /// **'Sons Altos'**
  String get sensory_high_sounds;

  /// No description provided for @sensory_soft_lights.
  ///
  /// In pt, this message translates to:
  /// **'Luzes Suaves'**
  String get sensory_soft_lights;

  /// No description provided for @sensory_bright_lights.
  ///
  /// In pt, this message translates to:
  /// **'Luzes Brilhantes'**
  String get sensory_bright_lights;

  /// No description provided for @sensory_hot_temperatures.
  ///
  /// In pt, this message translates to:
  /// **'Temperaturas Quentes'**
  String get sensory_hot_temperatures;

  /// No description provided for @sensory_cold_temperatures.
  ///
  /// In pt, this message translates to:
  /// **'Temperaturas Frias'**
  String get sensory_cold_temperatures;

  /// No description provided for @interest_music.
  ///
  /// In pt, this message translates to:
  /// **'Música'**
  String get interest_music;

  /// No description provided for @interest_drawing.
  ///
  /// In pt, this message translates to:
  /// **'Desenho'**
  String get interest_drawing;

  /// No description provided for @interest_numbers.
  ///
  /// In pt, this message translates to:
  /// **'Números'**
  String get interest_numbers;

  /// No description provided for @interest_animals.
  ///
  /// In pt, this message translates to:
  /// **'Animais'**
  String get interest_animals;

  /// No description provided for @interest_cars.
  ///
  /// In pt, this message translates to:
  /// **'Carros'**
  String get interest_cars;

  /// No description provided for @interest_books.
  ///
  /// In pt, this message translates to:
  /// **'Livros'**
  String get interest_books;

  /// No description provided for @interest_games.
  ///
  /// In pt, this message translates to:
  /// **'Jogos'**
  String get interest_games;

  /// No description provided for @interest_computer.
  ///
  /// In pt, this message translates to:
  /// **'Computador'**
  String get interest_computer;

  /// No description provided for @interest_tablet.
  ///
  /// In pt, this message translates to:
  /// **'Tablet'**
  String get interest_tablet;

  /// No description provided for @interest_toys.
  ///
  /// In pt, this message translates to:
  /// **'Brinquedos'**
  String get interest_toys;

  /// No description provided for @interest_sports.
  ///
  /// In pt, this message translates to:
  /// **'Esportes'**
  String get interest_sports;

  /// No description provided for @interest_dance.
  ///
  /// In pt, this message translates to:
  /// **'Dança'**
  String get interest_dance;

  /// No description provided for @interest_cooking.
  ///
  /// In pt, this message translates to:
  /// **'Culinária'**
  String get interest_cooking;

  /// No description provided for @interest_gardening.
  ///
  /// In pt, this message translates to:
  /// **'Jardinagem'**
  String get interest_gardening;

  /// No description provided for @interest_science.
  ///
  /// In pt, this message translates to:
  /// **'Ciência'**
  String get interest_science;

  /// No description provided for @interest_math.
  ///
  /// In pt, this message translates to:
  /// **'Matemática'**
  String get interest_math;

  /// No description provided for @interest_art.
  ///
  /// In pt, this message translates to:
  /// **'Arte'**
  String get interest_art;

  /// No description provided for @interest_photography.
  ///
  /// In pt, this message translates to:
  /// **'Fotografia'**
  String get interest_photography;

  /// No description provided for @interest_videos.
  ///
  /// In pt, this message translates to:
  /// **'Vídeos'**
  String get interest_videos;

  /// No description provided for @interest_movies.
  ///
  /// In pt, this message translates to:
  /// **'Filmes'**
  String get interest_movies;

  /// No description provided for @interest_series.
  ///
  /// In pt, this message translates to:
  /// **'Séries'**
  String get interest_series;

  /// No description provided for @interest_puzzles.
  ///
  /// In pt, this message translates to:
  /// **'Quebra-cabeças'**
  String get interest_puzzles;

  /// No description provided for @interest_lego.
  ///
  /// In pt, this message translates to:
  /// **'Lego'**
  String get interest_lego;

  /// No description provided for @interest_dolls.
  ///
  /// In pt, this message translates to:
  /// **'Bonecas'**
  String get interest_dolls;

  /// No description provided for @interest_superheroes.
  ///
  /// In pt, this message translates to:
  /// **'Super-heróis'**
  String get interest_superheroes;

  /// No description provided for @delete_post_action.
  ///
  /// In pt, this message translates to:
  /// **'Deletar'**
  String get delete_post_action;

  /// No description provided for @report_post_action.
  ///
  /// In pt, this message translates to:
  /// **'Denunciar'**
  String get report_post_action;

  /// No description provided for @clear_search.
  ///
  /// In pt, this message translates to:
  /// **'Limpar busca'**
  String get clear_search;

  /// No description provided for @month.
  ///
  /// In pt, this message translates to:
  /// **'mês'**
  String get month;

  /// No description provided for @months.
  ///
  /// In pt, this message translates to:
  /// **'meses'**
  String get months;

  /// No description provided for @year.
  ///
  /// In pt, this message translates to:
  /// **'ano'**
  String get year;

  /// No description provided for @years.
  ///
  /// In pt, this message translates to:
  /// **'anos'**
  String get years;

  /// No description provided for @search_articles.
  ///
  /// In pt, this message translates to:
  /// **'Buscar artigos...'**
  String get search_articles;

  /// No description provided for @all_categories.
  ///
  /// In pt, this message translates to:
  /// **'Todas as categorias'**
  String get all_categories;

  /// No description provided for @no_articles_found.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum artigo encontrado'**
  String get no_articles_found;

  /// No description provided for @no_articles_available.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum artigo disponível'**
  String get no_articles_available;

  /// No description provided for @article_early_signs_title.
  ///
  /// In pt, this message translates to:
  /// **'Sinais Precoces do TEA'**
  String get article_early_signs_title;

  /// No description provided for @article_early_signs_body.
  ///
  /// In pt, this message translates to:
  /// **'Identificar os primeiros sinais do autismo pode fazer toda a diferença no desenvolvimento da criança. Os principais indicadores incluem:\n\n• Dificuldades na comunicação verbal e não-verbal\n• Padrões repetitivos de comportamento\n• Interesses restritos e intensos\n• Dificuldades na interação social\n• Sensibilidade sensorial alterada\n\nÉ importante observar que cada criança é única e pode apresentar diferentes combinações destes sinais. O diagnóstico precoce permite intervenções mais eficazes.'**
  String get article_early_signs_body;

  /// No description provided for @article_early_signs_author.
  ///
  /// In pt, this message translates to:
  /// **'Dr. Maria Silva'**
  String get article_early_signs_author;

  /// No description provided for @article_aba_therapy_title.
  ///
  /// In pt, this message translates to:
  /// **'Terapia ABA: Como Funciona'**
  String get article_aba_therapy_title;

  /// No description provided for @article_aba_therapy_body.
  ///
  /// In pt, this message translates to:
  /// **'A Análise do Comportamento Aplicada (ABA) é uma das terapias mais eficazes para crianças com TEA. Esta abordagem científica baseia-se em princípios do comportamento para ensinar habilidades e reduzir comportamentos problemáticos.\n\nPrincípios fundamentais da ABA:\n• Reforço positivo para comportamentos desejados\n• Quebra de habilidades complexas em passos menores\n• Coleta de dados para monitorar progresso\n• Individualização do programa para cada criança\n\nA terapia ABA pode ajudar no desenvolvimento de habilidades de comunicação, sociais, acadêmicas e de vida diária.'**
  String get article_aba_therapy_body;

  /// No description provided for @article_aba_therapy_author.
  ///
  /// In pt, this message translates to:
  /// **'Psicóloga Ana Costa'**
  String get article_aba_therapy_author;

  /// No description provided for @article_routines_title.
  ///
  /// In pt, this message translates to:
  /// **'Rotinas e Estrutura no TEA'**
  String get article_routines_title;

  /// No description provided for @article_routines_body.
  ///
  /// In pt, this message translates to:
  /// **'Estabelecer rotinas claras ajuda crianças com autismo a se sentirem mais seguras e organizadas. A previsibilidade reduz a ansiedade e facilita a participação em atividades diárias.\n\nEstratégias para criar rotinas eficazes:\n• Use apoios visuais como calendários e cronogramas\n• Mantenha horários consistentes para refeições e sono\n• Prepare a criança para mudanças com antecedência\n• Crie rituais de transição entre atividades\n• Estabeleça locais específicos para diferentes atividades\n\nLembre-se de que flexibilidade também é importante - ajuste as rotinas conforme necessário.'**
  String get article_routines_body;

  /// No description provided for @article_routines_author.
  ///
  /// In pt, this message translates to:
  /// **'Terapeuta João Santos'**
  String get article_routines_author;

  /// No description provided for @article_school_inclusion_title.
  ///
  /// In pt, this message translates to:
  /// **'Inclusão Escolar: Direitos e Práticas'**
  String get article_school_inclusion_title;

  /// No description provided for @article_school_inclusion_body.
  ///
  /// In pt, this message translates to:
  /// **'A inclusão escolar é um direito garantido por lei no Brasil. A Lei Brasileira de Inclusão (LBI) assegura o acesso à educação de qualidade para pessoas com deficiência.\n\nPrincipais direitos:\n• Matrícula em escola regular\n• Atendimento educacional especializado\n• Adaptações curriculares quando necessárias\n• Profissional de apoio escolar\n• Materiais didáticos acessíveis\n\nPara uma inclusão efetiva, é essencial a colaboração entre família, escola e profissionais especializados. O ambiente escolar deve ser acolhedor e preparado para atender às necessidades específicas de cada estudante.'**
  String get article_school_inclusion_body;

  /// No description provided for @article_school_inclusion_author.
  ///
  /// In pt, this message translates to:
  /// **'Pedagoga Carla Lima'**
  String get article_school_inclusion_author;

  /// No description provided for @article_sensory_processing_title.
  ///
  /// In pt, this message translates to:
  /// **'Processamento Sensorial no TEA'**
  String get article_sensory_processing_title;

  /// No description provided for @article_sensory_processing_body.
  ///
  /// In pt, this message translates to:
  /// **'Muitas pessoas com TEA apresentam diferenças no processamento sensorial, podendo ser hipersensíveis ou hiposensíveis a estímulos do ambiente.\n\nTipos de sensibilidades:\n• Tátil: texturas, temperaturas, pressão\n• Auditiva: sons altos, frequências específicas\n• Visual: luzes brilhantes, padrões visuais\n• Olfativa: cheiros fortes ou específicos\n• Gustativa: sabores, texturas alimentares\n• Proprioceptiva: consciência corporal\n• Vestibular: equilíbrio e movimento\n\nEstratégias de apoio incluem ambientes sensoriais controlados, pausas regulares e uso de ferramentas sensoriais como fones de ouvido ou objetos fidget.'**
  String get article_sensory_processing_body;

  /// No description provided for @article_sensory_processing_author.
  ///
  /// In pt, this message translates to:
  /// **'Terapeuta Ocupacional Fernanda Rocha'**
  String get article_sensory_processing_author;

  /// No description provided for @article_family_support_title.
  ///
  /// In pt, this message translates to:
  /// **'Apoio Familiar: Cuidando de Quem Cuida'**
  String get article_family_support_title;

  /// No description provided for @article_family_support_body.
  ///
  /// In pt, this message translates to:
  /// **'Famílias de pessoas com TEA enfrentam desafios únicos e precisam de apoio contínuo. O autocuidado dos cuidadores é fundamental para o bem-estar de toda a família.\n\nEstratégias de apoio:\n• Buscar grupos de apoio locais ou online\n• Manter tempo para atividades pessoais\n• Dividir responsabilidades entre familiares\n• Procurar ajuda profissional quando necessário\n• Celebrar pequenas conquistas\n• Manter comunicação aberta na família\n\nLembre-se: cuidar de si mesmo não é egoísmo, é necessidade. Uma família equilibrada oferece melhor suporte.'**
  String get article_family_support_body;

  /// No description provided for @article_family_support_author.
  ///
  /// In pt, this message translates to:
  /// **'Psicóloga Familiar Beatriz Almeida'**
  String get article_family_support_author;

  /// No description provided for @article_communication_strategies_title.
  ///
  /// In pt, this message translates to:
  /// **'Estratégias de Comunicação Eficaz'**
  String get article_communication_strategies_title;

  /// No description provided for @article_communication_strategies_body.
  ///
  /// In pt, this message translates to:
  /// **'A comunicação com pessoas no espectro autista pode ser facilitada através de estratégias específicas que respeitam suas necessidades e preferências.\n\nDicas importantes:\n• Use linguagem clara e direta\n• Evite metáforas e expressões idiomáticas\n• Dê tempo para processamento da informação\n• Use apoios visuais quando possível\n• Mantenha contato visual respeitoso\n• Seja paciente com repetições\n• Valide sentimentos e experiências\n\nCada pessoa é única - observe e adapte sua comunicação às preferências individuais. A comunicação eficaz constrói confiança e relacionamentos positivos.'**
  String get article_communication_strategies_body;

  /// No description provided for @article_communication_strategies_author.
  ///
  /// In pt, this message translates to:
  /// **'Fonoaudióloga Patrícia Mendes'**
  String get article_communication_strategies_author;
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
