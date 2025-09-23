// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_name => 'TISM';

  @override
  String get app_subtitle =>
      'Everything you need to know about ASD in one click';

  @override
  String get app_title => 'TISM - ASD Guide';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirm_password => 'Confirm password';

  @override
  String get name => 'Name';

  @override
  String get username => 'Username';

  @override
  String get forgot_password => 'Forgot my password';

  @override
  String get login_success => 'Login successful';

  @override
  String get register_success => 'Account created successfully';

  @override
  String get logout => 'Logout';

  @override
  String get logout_confirm => 'Are you sure you want to logout?';

  @override
  String get participant => 'Participant';

  @override
  String get participant_desc => 'Regular TISM user';

  @override
  String get responsible => 'Caregiver';

  @override
  String get responsible_desc => 'Family member or caregiver';

  @override
  String get professional => 'Professional';

  @override
  String get professional_desc => 'Therapist, doctor, educator';

  @override
  String get user_type => 'User type';

  @override
  String get select_user_type => 'Select your type';

  @override
  String get profile => 'Profile';

  @override
  String get edit_profile => 'Edit Profile';

  @override
  String get edit_name => 'Edit Name';

  @override
  String get edit_username => 'Edit Username';

  @override
  String get full_name => 'Full name';

  @override
  String get account_type => 'Account type';

  @override
  String get theme => 'Theme';

  @override
  String get light_theme => 'Light';

  @override
  String get dark_theme => 'Dark';

  @override
  String get system_theme => 'System';

  @override
  String get system_theme_desc => 'Follow device theme';

  @override
  String get home => 'Home';

  @override
  String get forum => 'Forum';

  @override
  String get knowledge => 'Knowledge';

  @override
  String get routine => 'Routine';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get feed => 'Feed';

  @override
  String get search => 'Search';

  @override
  String get hello => 'Olá';

  @override
  String hello_user(String name) {
    return 'Hello, %s! 👋';
  }

  @override
  String get explore_content => 'Explore educational content about ASD';

  @override
  String get educational_feed => 'Educational Feed';

  @override
  String get personalized_routine => 'Rotina Personalizada';

  @override
  String get custom_routine => 'Custom Routine';

  @override
  String get observation_diary => 'Observation Diary';

  @override
  String get tina_chatbot => 'Tina (Chatbot)';

  @override
  String get tea_forum => 'ASD Forum';

  @override
  String get articles => 'Articles';

  @override
  String get digital_library => 'Digital Library';

  @override
  String get new_post => 'New Post';

  @override
  String get publish => 'Publish';

  @override
  String get share_experience =>
      'Share your experience, question or tip about ASD...';

  @override
  String get write_something => 'Write something before publishing';

  @override
  String get confirm_publication => 'Confirm Publication';

  @override
  String get want_to_publish =>
      'Do you want to publish this post on the forum?';

  @override
  String get post_published => 'Post published successfully!';

  @override
  String get error_publishing => 'Error publishing post';

  @override
  String get tina_assistant => 'Tina - ASD Assistant';

  @override
  String get thinking => 'Thinking...';

  @override
  String get type_message => 'Type your message...';

  @override
  String get about_tina => '💙 About Tina';

  @override
  String get tina_intro =>
      '🤖 **Hello! I\'m Tina!**\\n\\nI\'m a virtual assistant specialized in autism and neurodiversity, developed especially for TISM by a multidisciplinary team of experts.';

  @override
  String get tina_specialization =>
      '🎯 **My specialization:**\\n• 🧠 Development and behavior\\n• 🏫 Inclusive educational strategies\\n• 💬 Communication and social interaction techniques\\n• 🌍 Environmental and sensory adaptations\\n• 🛠️ Practical resources for daily life';

  @override
  String get tina_scientific =>
      '🔬 **Scientific basis:** I was trained with knowledge validated by neurologists, psychologists, occupational therapists, speech therapists and special educators.';

  @override
  String get tina_important =>
      '⚠️ **Important:** I don\'t make diagnoses or replace healthcare professionals. My role is complementary, offering informative and practical support.';

  @override
  String get tina_support =>
      '💙 **I\'m here to support you with reliable information and empathy!**';

  @override
  String get understood_tina => 'Got it, Tina! Let\'s chat! 😊';

  @override
  String get tina_welcome =>
      'Hello! I\'m Tina, a virtual assistant specialized in autism and neurodiversity from TISM!\\n\\nI\'m here to offer personalized support and information based on scientific evidence about:\\n\\n• Development and behavior\\n• Inclusive educational strategies\\n• Communication and social interaction techniques\\n• Environmental and sensory adaptations\\n• Practical resources and tools for daily life\\n\\nMy knowledge base was developed by a multidisciplinary team of experts, including neurologists, psychologists, occupational therapists, speech therapists and special educators.\\n\\nIt\'s important to note that I don\'t make diagnoses or replace healthcare professionals - my role is complementary, offering reliable information and practical support for families, caregivers and neurodivergent people.\\n\\nHow can I help you today?';

  @override
  String get diary_observations => 'Observation Diary';

  @override
  String get no_observations => 'No observations yet';

  @override
  String get tap_plus_start => 'Tap + to start';

  @override
  String get report_copied => 'Report copied! Paste in email or WhatsApp';

  @override
  String get progress => 'Progress';

  @override
  String get behavior => 'Behavior';

  @override
  String get crisis => 'Crisis';

  @override
  String get difficulty => 'Difficulty';

  @override
  String get triggers => 'Triggers';

  @override
  String routine_of(String name) {
    return '%s\'s Routine';
  }

  @override
  String support_level(String level) {
    return '%s Support';
  }

  @override
  String get filter_category => 'Filter by category:';

  @override
  String get completed => 'Completed';

  @override
  String progress_count(int completed, int total) {
    return 'Progress: %d/%d';
  }

  @override
  String get no_activities => 'No activities found';

  @override
  String get clear_filters => 'Clear filters';

  @override
  String get add_activity => 'Add Activity';

  @override
  String get edit_activity => 'Edit Activity';

  @override
  String get morning => 'Morning';

  @override
  String get education => 'Education';

  @override
  String get food => 'Food';

  @override
  String get leisure => 'Leisure';

  @override
  String get wellness => 'Wellness';

  @override
  String get night => 'Night';

  @override
  String get all => 'All';

  @override
  String get welcome => 'Hello, welcome!';

  @override
  String get profile_setup_desc =>
      'To create a personalized routine, let\'s first set up the child\'s profile.\\n\\nThis helps us suggest age-appropriate activities and support level.';

  @override
  String get create_profile => 'Create Profile';

  @override
  String get edit_profile_menu => 'Edit Profile';

  @override
  String get switch_child => 'Switch Child';

  @override
  String get new_child => 'New Child';

  @override
  String get select_child => 'Select Child';

  @override
  String get verify_email => 'Verify Email';

  @override
  String get verification_sent => 'Verification email sent!';

  @override
  String get check_email => 'Check your inbox';

  @override
  String get verification_desc =>
      'We sent a verification link to your email. Click the link to activate your account.';

  @override
  String get already_verified => 'Already verified - Login';

  @override
  String get resend_verification => 'Resend verification email';

  @override
  String get verifying => 'Verifying...';

  @override
  String get delete_account => 'Delete Account';

  @override
  String get delete_warning =>
      'This action is IRREVERSIBLE!\\n\\nAll your data will be permanently lost.';

  @override
  String get delete_confirmation => 'To confirm, type exactly:';

  @override
  String get delete_phrase => 'DELETE my account';

  @override
  String get delete_input_hint => 'Type the phrase above';

  @override
  String get delete_incorrect =>
      'Incorrect phrase. Check uppercase and lowercase.';

  @override
  String get confirm_password_delete => 'Confirm password';

  @override
  String get enter_password => 'Enter your password';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get add => 'Add';

  @override
  String get remove => 'Remove';

  @override
  String get update => 'Update';

  @override
  String get close => 'Close';

  @override
  String get ok => 'OK';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get share => 'Share';

  @override
  String get success => 'Success';

  @override
  String get error => 'Error';

  @override
  String get loading => 'Loading...';

  @override
  String get connection_error => 'Connection error';

  @override
  String get try_again => 'Try again';

  @override
  String get updated_successfully => 'Updated successfully!';

  @override
  String get deleted_successfully => 'Deleted successfully';

  @override
  String get saved_successfully => 'Saved successfully!';

  @override
  String get welcome_message => 'Hello, welcome!';

  @override
  String get no_account => 'Don\'t have an account? Sign up';

  @override
  String get fill_all_fields => 'Fill all fields';

  @override
  String get login_error => 'Login error';

  @override
  String connection_error_detail(String error) {
    return 'Connection error: %s';
  }

  @override
  String get field_required => 'This field is required';

  @override
  String get invalid_email => 'Invalid email';

  @override
  String get password_too_short => 'Password must be at least 8 characters';

  @override
  String get passwords_dont_match => 'Passwords don\'t match';

  @override
  String get username_invalid =>
      'Username must contain only lowercase letters, numbers and _';

  @override
  String get name_cooldown => 'Name can only be changed once per day';

  @override
  String get username_cooldown =>
      'Username can only be changed once every 3 days';

  @override
  String get user_type_cooldown => 'User type can only be changed once per day';

  @override
  String get wake_up => 'Wake up';

  @override
  String get wake_up_desc => 'Wake up with soft music';

  @override
  String get brush_teeth => 'Brush teeth';

  @override
  String get brush_teeth_desc => 'Use soft brush for 2 minutes';

  @override
  String get breakfast => 'Breakfast';

  @override
  String get breakfast_desc => 'Eat sitting at the table';

  @override
  String get educational_activity => 'Educational activity';

  @override
  String get educational_activity_desc => 'Educational games or school';

  @override
  String get snack => 'Snack';

  @override
  String get snack_desc => 'Fruit or healthy snack';

  @override
  String get music => 'Music';

  @override
  String get music_desc => 'Listen to or play music';

  @override
  String get draw => 'Draw';

  @override
  String get draw_desc => 'Free drawing activity';

  @override
  String get numbers => 'Numbers';

  @override
  String get numbers_desc => 'Number games';

  @override
  String get sensory_break => 'Sensory break';

  @override
  String get sensory_break_desc => 'Moment of calm and self-regulation';

  @override
  String get dinner => 'Dinner';

  @override
  String get dinner_desc => 'Family meal';

  @override
  String get bath => 'Bath';

  @override
  String get bath_desc => 'Warm water, soft sponge';

  @override
  String get sleep => 'Sleep';

  @override
  String get sleep_desc => 'Soft music to sleep';

  @override
  String get welcome_forum => 'Welcome to ASD Forum! 💙';

  @override
  String get first_post_message =>
      'Be the first to share an experience\\nor ask a question to the community';

  @override
  String get create_first_post => 'Create first post';

  @override
  String get delete_post => 'Delete Post';

  @override
  String get delete_post_confirm =>
      'Are you sure you want to delete this post? This action cannot be undone.';

  @override
  String get post_deleted_success => 'Post deleted successfully';

  @override
  String error_deleting_post(String error) {
    return 'Error deleting post: %s';
  }

  @override
  String get report_post => 'Report';

  @override
  String get report_post_title => 'Report Post';

  @override
  String get report_post_confirm =>
      'Are you sure you want to report this post?';

  @override
  String get post_reported => 'Post reported successfully';

  @override
  String get now => 'Now';

  @override
  String get search_posts => 'Search posts, people or topics...';

  @override
  String get no_results_found => 'No results found';

  @override
  String get try_different_keywords =>
      'Try using different keywords\\nor explore the categories below';

  @override
  String get type_to_search => 'Type to search...';

  @override
  String get find_posts_profiles =>
      'Find posts, profiles and hashtags\\nin the ASD community';

  @override
  String get popular_categories => 'Popular Categories';

  @override
  String get recent_searches => 'Recent Searches';

  @override
  String get searches_appear_here => 'Your searches will appear here';

  @override
  String get general => 'General';

  @override
  String get tips => 'Tips';

  @override
  String get experiences => 'Experiences';

  @override
  String get questions => 'Questions';

  @override
  String get resources => 'Resources';

  @override
  String get how_identify_autism => 'How to identify autism?';

  @override
  String get child_not_speaking => 'My child doesn\'t speak, is it autism?';

  @override
  String get what_therapies_work => 'What therapies work?';

  @override
  String get help_at_school => 'How to help at school?';

  @override
  String get autism_rights => 'Autism rights';

  @override
  String get child_tantrums => 'Child with tantrums';

  @override
  String get new_observation => 'New Observation';

  @override
  String get edit_observation => 'Edit Observation';

  @override
  String get observation_type => 'Type:';

  @override
  String get title => 'Title';

  @override
  String get detailed_description => 'Detailed description';

  @override
  String intensity(int level) {
    return 'Intensity: %d';
  }

  @override
  String get observer => 'Observer:';

  @override
  String get possible_triggers => 'Possible triggers:';

  @override
  String get delete_observation => 'Delete Observation';

  @override
  String get delete_observation_confirm =>
      'Are you sure you want to delete this observation?';

  @override
  String get observation_title_empty => 'The observation title cannot be empty';

  @override
  String get not_defined => 'Not defined';

  @override
  String get confirm_change => 'Confirm change';

  @override
  String change_name_to(String name) {
    return 'Change name to \"%s\"?';
  }

  @override
  String change_username_to(String oldName, String newName) {
    return 'Change username from @%s to @%s?';
  }

  @override
  String get error_updating_name => 'Error updating name';

  @override
  String get error_updating_username => 'Error updating username';

  @override
  String get error_updating_type => 'Error updating type';

  @override
  String get username_help => 'Only lowercase letters, numbers and _';

  @override
  String get username_cooldown_info =>
      'Username can only be changed once every 3 days';

  @override
  String get confirm_password_title => 'Confirm password';

  @override
  String get error_deleting_account => 'Error deleting account';

  @override
  String get type_updated => 'Type updated!';

  @override
  String get name_updated => 'Name updated!';

  @override
  String get username_updated => 'Username updated!';

  @override
  String get account_deleted => 'Account deleted successfully';

  @override
  String get incorrect_password => 'Incorrect password';

  @override
  String get user_not_found => 'User not found';

  @override
  String get email_not_verified => 'Email not verified yet';

  @override
  String get verification_email_sent => 'Verification email resent!';

  @override
  String get checking_verification => 'Checking...';

  @override
  String get already_have_account => 'Already have an account? Login';

  @override
  String get create_account => 'Create account';

  @override
  String get account_created => 'Account created! Check your email to activate';

  @override
  String get example123 => 'example123';
}
