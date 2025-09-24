// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get app_name => 'TISM';

  @override
  String get app_subtitle => '자폐 스펙트럼 장애에 대한 모든 정보를 한 번의 클릭으로';

  @override
  String get app_title => 'TISM - 자폐증 가이드';

  @override
  String get login => '로그인';

  @override
  String get register => '회원가입';

  @override
  String get email => '이메일';

  @override
  String get password => '비밀번호';

  @override
  String get confirm_password => '비밀번호 확인';

  @override
  String get name => '이름';

  @override
  String get username => '사용자명';

  @override
  String get forgot_password => '비밀번호를 잊었습니다';

  @override
  String get login_success => '로그인 성공';

  @override
  String get register_success => '계정이 성공적으로 생성되었습니다';

  @override
  String get logout => '로그아웃';

  @override
  String get logout_confirm => '로그아웃하시겠습니까?';

  @override
  String get participant => '참가자';

  @override
  String get participant_desc => '일반 TISM 사용자';

  @override
  String get responsible => '책임자';

  @override
  String get responsible_desc => '가족 구성원 또는 돌봄이';

  @override
  String get professional => '전문가';

  @override
  String get professional_desc => '치료사, 의사, 교육자';

  @override
  String get user_type => '사용자 유형';

  @override
  String get select_user_type => '유형을 선택하세요';

  @override
  String get profile => '프로필';

  @override
  String get edit_profile => '프로필 편집';

  @override
  String get edit_name => '이름 편집';

  @override
  String get edit_username => '사용자명 편집';

  @override
  String get full_name => '전체 이름';

  @override
  String get account_type => '계정 유형';

  @override
  String get theme => '테마';

  @override
  String get light_theme => '밝음';

  @override
  String get dark_theme => '어둠';

  @override
  String get system_theme => '시스템';

  @override
  String get system_theme_desc => '기기 테마를 따름';

  @override
  String get home => '홈';

  @override
  String get forum => '포럼';

  @override
  String get knowledge => '지식';

  @override
  String get routine => '루틴';

  @override
  String get dashboard => '대시보드';

  @override
  String get feed => '피드';

  @override
  String get search => '검색';

  @override
  String get hello => '안녕하세요';

  @override
  String hello_user(String name) {
    return '안녕하세요, $name님! 👋';
  }

  @override
  String get explore_content => '자폐증에 대한 교육 콘텐츠 탐색';

  @override
  String get educational_feed => '교육 피드';

  @override
  String get personalized_routine => '개인화된 루틴';

  @override
  String get custom_routine => '맞춤 루틴';

  @override
  String get observation_diary => '관찰 일기';

  @override
  String get tina_chatbot => '티나 (챗봇)';

  @override
  String get tea_forum => '자폐증 포럼';

  @override
  String get articles => '기사';

  @override
  String get digital_library => '디지털 도서관';

  @override
  String get new_post => '새 게시물';

  @override
  String get publish => '게시';

  @override
  String get share_experience => '자폐증에 대한 경험, 질문 또는 팁을 공유하세요...';

  @override
  String get write_something => '게시하기 전에 무언가를 작성하세요';

  @override
  String get confirm_publication => '게시 확인';

  @override
  String get want_to_publish => '이 게시물을 포럼에 게시하시겠습니까?';

  @override
  String get post_published => '게시물이 성공적으로 게시되었습니다!';

  @override
  String get error_publishing => '게시 오류';

  @override
  String get tina_assistant => '티나 - 자폐증 도우미';

  @override
  String get thinking => '생각 중...';

  @override
  String get type_message => '메시지를 입력하세요...';

  @override
  String get about_tina => '💙 티나 소개';

  @override
  String get tina_intro =>
      '🤖 **안녕하세요! 저는 티나입니다!**\n\n저는 자폐증과 신경다양성을 전문으로 하는 가상 도우미로, 다학제 전문가 팀이 TISM을 위해 특별히 개발했습니다.';

  @override
  String get tina_specialization =>
      '🎯 **제 전문 분야:**\n• 🧠 발달과 행동\n• 🏫 포용적 교육 전략\n• 💬 의사소통 및 사회적 상호작용 기법\n• 🌍 환경 및 감각 적응\n• 🛠️ 일상생활을 위한 실용적 자원';

  @override
  String get tina_scientific =>
      '🔬 **과학적 근거:** 저는 신경과 의사, 심리학자, 작업치료사, 언어치료사, 특수교육자들이 검증한 지식으로 훈련받았습니다.';

  @override
  String get tina_important =>
      '⚠️ **중요:** 저는 진단을 하지 않으며 의료 전문가를 대체하지 않습니다. 제 역할은 보완적이며, 정보적이고 실용적인 지원을 제공합니다.';

  @override
  String get tina_support => '💙 **신뢰할 수 있는 정보와 공감으로 여러분을 지원하겠습니다!**';

  @override
  String get understood_tina => '알겠습니다, 티나! 대화해요! 😊';

  @override
  String get tina_welcome =>
      '안녕하세요! 저는 TISM의 자폐증과 신경다양성 전문 가상 도우미 티나입니다!\n\n다음에 대한 과학적 증거에 기반한 개인화된 지원과 정보를 제공합니다:\n\n• 발달과 행동\n• 포용적 교육 전략\n• 의사소통 및 사회적 상호작용 기법\n• 환경 및 감각 적응\n• 일상생활을 위한 실용적 자원과 도구\n\n제 지식 기반은 신경과 의사, 심리학자, 작업치료사, 언어치료사, 특수교육자를 포함한 다학제 전문가 팀이 개발했습니다.\n\n저는 진단을 하지 않으며 의료 전문가를 대체하지 않는다는 점이 중요합니다 - 제 역할은 보완적이며, 가족, 돌봄이, 신경다양성을 가진 사람들에게 신뢰할 수 있는 정보와 실용적 지원을 제공합니다.\n\n오늘 어떻게 도와드릴까요?';

  @override
  String get tina_connection_error =>
      '지금 연결에 문제가 있습니다. 많은 사용자가 시스템을 사용하고 있습니다. 몇 분 후에 다시 시도해주세요! 😅';

  @override
  String get tina_general_error => '엇! 문제가 발생했습니다. 잠시 후에 다시 시도해주세요! 🤖';

  @override
  String get tina_api_key_error =>
      'API 키가 유효하지 않습니다. .env 파일에서 Gemini 키가 올바른지 확인해주세요';

  @override
  String get tina_quota_error => 'API 사용 한도를 초과했습니다. 나중에 다시 시도해주세요.';

  @override
  String get tina_network_error => '연결 오류입니다. 인터넷 연결을 확인하고 다시 시도해주세요.';

  @override
  String get diary_observations => '관찰 일기';

  @override
  String get no_observations => '아직 관찰 기록이 없습니다';

  @override
  String get tap_plus_start => '+ 를 눌러 시작하세요';

  @override
  String get report_copied => '보고서가 복사되었습니다! 이메일이나 카카오톡에 붙여넣으세요';

  @override
  String get progress => '진행';

  @override
  String get behavior => '행동';

  @override
  String get crisis => '위기';

  @override
  String get difficulty => '어려움';

  @override
  String get triggers => '유발 요인';

  @override
  String routine_of(String name) {
    return '$name의 루틴';
  }

  @override
  String support_level(String level) {
    return '$level 지원';
  }

  @override
  String get filter_category => '카테고리별 필터:';

  @override
  String get completed => '완료됨';

  @override
  String progress_count(int completed, int total) {
    return '진행률: $completed/$total';
  }

  @override
  String get no_activities => '활동을 찾을 수 없습니다';

  @override
  String get clear_filters => '필터 지우기';

  @override
  String get add_activity => '활동 추가';

  @override
  String get edit_activity => '활동 편집';

  @override
  String get morning => '아침';

  @override
  String get education => '교육';

  @override
  String get food => '식사';

  @override
  String get leisure => '여가';

  @override
  String get wellness => '웰빙';

  @override
  String get night => '밤';

  @override
  String get all => '모두';

  @override
  String get welcome => '안녕하세요, 환영합니다!';

  @override
  String get profile_setup_desc =>
      '개인화된 루틴을 만들기 위해 먼저 아이의 프로필을 설정해보겠습니다.\n\n이는 연령과 지원 수준에 적합한 활동을 제안하는 데 도움이 됩니다.';

  @override
  String get create_profile => '프로필 생성';

  @override
  String get edit_profile_menu => '프로필 편집';

  @override
  String get switch_child => '아이 변경';

  @override
  String get new_child => '새 아이';

  @override
  String get select_child => '아이 선택';

  @override
  String get verify_email => '이메일 인증';

  @override
  String get verification_sent => '인증 이메일이 전송되었습니다!';

  @override
  String get check_email => '받은편지함을 확인하세요';

  @override
  String get verification_desc => '이메일의 링크를 클릭하여 계정을 활성화하세요.\n자동으로 리디렉션됩니다.';

  @override
  String get already_verified => '이미 인증됨 - 로그인';

  @override
  String get resend_verification => '인증 이메일 재전송';

  @override
  String get verifying => '인증 중...';

  @override
  String get delete_account => '계정 삭제';

  @override
  String get delete_warning => '이 작업은 되돌릴 수 없습니다!\n\n모든 데이터가 영구적으로 손실됩니다.';

  @override
  String get delete_confirmation => '확인하려면 정확히 입력하세요:';

  @override
  String get delete_phrase => '내 계정 삭제';

  @override
  String get delete_input_hint => '위의 문구를 입력하세요';

  @override
  String get delete_incorrect => '잘못된 문구입니다. 대소문자를 확인하세요.';

  @override
  String get confirm_password_delete => '비밀번호 확인';

  @override
  String get enter_password => '비밀번호를 입력하세요';

  @override
  String get save => '저장';

  @override
  String get cancel => '취소';

  @override
  String get confirm => '확인';

  @override
  String get delete => '삭제';

  @override
  String get edit => '편집';

  @override
  String get add => '추가';

  @override
  String get remove => '제거';

  @override
  String get update => '업데이트';

  @override
  String get close => '닫기';

  @override
  String get ok => '확인';

  @override
  String get yes => '예';

  @override
  String get no => '아니오';

  @override
  String get share => '공유';

  @override
  String get success => '성공';

  @override
  String get error => '오류';

  @override
  String get loading => '로딩 중...';

  @override
  String get connection_error => '연결 오류';

  @override
  String get try_again => '다시 시도';

  @override
  String get updated_successfully => '성공적으로 업데이트되었습니다!';

  @override
  String get deleted_successfully => '성공적으로 삭제되었습니다';

  @override
  String get saved_successfully => '성공적으로 저장되었습니다!';

  @override
  String get welcome_message => '안녕하세요, 환영합니다!';

  @override
  String get no_account => '아직 계정이 없으신가요? 가입하세요';

  @override
  String get fill_all_fields => '모든 필드를 채우세요';

  @override
  String get login_error => '로그인 오류';

  @override
  String connection_error_detail(String error) {
    return '연결 오류: $error';
  }

  @override
  String get field_required => '이 필드는 필수입니다';

  @override
  String get invalid_email => '유효하지 않은 이메일';

  @override
  String get password_too_short => '비밀번호는 최소 8자 이상이어야 합니다';

  @override
  String get passwords_dont_match => '비밀번호가 일치하지 않습니다';

  @override
  String get username_invalid => '사용자명은 소문자, 숫자, _만 포함해야 합니다';

  @override
  String get name_cooldown => '이름은 하루에 한 번만 변경할 수 있습니다';

  @override
  String get username_cooldown => '사용자명은 3일에 한 번만 변경할 수 있습니다';

  @override
  String get user_type_cooldown => '사용자 유형은 하루에 한 번만 변경할 수 있습니다';

  @override
  String get wake_up => '일어나기';

  @override
  String get wake_up_desc => '부드러운 음악으로 일어나기';

  @override
  String get brush_teeth => '양치하기';

  @override
  String get brush_teeth_desc => '부드러운 칫솔로 2분간 양치';

  @override
  String get breakfast => '아침식사';

  @override
  String get breakfast_desc => '테이블에 앉아서 식사하기';

  @override
  String get educational_activity => '교육 활동';

  @override
  String get educational_activity_desc => '교육 게임이나 학교';

  @override
  String get snack => '간식';

  @override
  String get snack_desc => '과일이나 건강한 간식';

  @override
  String get music => '음악';

  @override
  String get music_desc => '음악 듣기 또는 연주하기';

  @override
  String get draw => '그리기';

  @override
  String get draw_desc => '자유 그리기 활동';

  @override
  String get numbers => '숫자';

  @override
  String get numbers_desc => '숫자 게임';

  @override
  String get sensory_break => '감각 휴식';

  @override
  String get sensory_break_desc => '평온함과 자기조절의 시간';

  @override
  String get dinner => '저녁식사';

  @override
  String get dinner_desc => '가족 식사';

  @override
  String get bath => '목욕';

  @override
  String get bath_desc => '따뜻한 물, 부드러운 스펀지';

  @override
  String get sleep => '잠자기';

  @override
  String get sleep_desc => '잠들기 위한 부드러운 음악';

  @override
  String get welcome_forum => '자폐증 포럼에 오신 것을 환영합니다! 💙';

  @override
  String get first_post_message => '첫 번째로 경험을 공유하거나\n커뮤니티에 질문을 해보세요';

  @override
  String get create_first_post => '첫 게시물 만들기';

  @override
  String get delete_post => '게시물 삭제';

  @override
  String get delete_post_confirm => '이 게시물을 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.';

  @override
  String get post_deleted_success => '게시물이 성공적으로 삭제되었습니다';

  @override
  String error_deleting_post(String error) {
    return '게시물 삭제 오류: $error';
  }

  @override
  String get report_post => '신고';

  @override
  String get report_post_title => '게시물 신고';

  @override
  String get report_post_confirm => '이 게시물을 신고하시겠습니까?';

  @override
  String get post_reported => '게시물이 성공적으로 신고되었습니다';

  @override
  String get now => '지금';

  @override
  String get search_posts => '게시물, 사람 또는 주제 검색...';

  @override
  String get no_results_found => '결과를 찾을 수 없습니다';

  @override
  String get try_different_keywords => '다른 키워드를 사용해보거나\n아래 카테고리를 탐색해보세요';

  @override
  String get type_to_search => '검색하려면 입력하세요...';

  @override
  String get find_posts_profiles => '자폐증 커뮤니티에서\n게시물, 프로필, 해시태그 찾기';

  @override
  String get how_identify_autism => '자폐증을 어떻게 식별하나요?';

  @override
  String get child_not_speaking => '우리 아이가 말을 하지 않는데, 자폐증인가요?';

  @override
  String get what_therapies_work => '어떤 치료법이 효과적인가요?';

  @override
  String get help_at_school => '학교에서 어떻게 도울 수 있나요?';

  @override
  String get autism_rights => '자폐인의 권리';

  @override
  String get child_tantrums => '떼쓰는 아이';

  @override
  String get new_observation => '새 관찰';

  @override
  String get edit_observation => '관찰 편집';

  @override
  String get observation_type => '유형:';

  @override
  String get title => '제목';

  @override
  String get detailed_description => '상세 설명';

  @override
  String intensity(int level) {
    return '강도: $level';
  }

  @override
  String get observer => '관찰자:';

  @override
  String get possible_triggers => '가능한 유발 요인:';

  @override
  String get delete_observation => '관찰 삭제';

  @override
  String get delete_observation_confirm => '이 관찰을 삭제하시겠습니까?';

  @override
  String get observation_title_empty => '관찰 제목은 비워둘 수 없습니다';

  @override
  String get not_defined => '정의되지 않음';

  @override
  String get confirm_change => '변경 확인';

  @override
  String change_name_to(String name) {
    return '이름을 \"$name\"으로 변경하시겠습니까?';
  }

  @override
  String change_username_to(String oldName, String newName) {
    return '사용자명을 @$oldName에서 @$newName으로 변경하시겠습니까?';
  }

  @override
  String get error_updating_name => '이름 업데이트 오류';

  @override
  String get error_updating_username => '사용자명 업데이트 오류';

  @override
  String get error_updating_type => '유형 업데이트 오류';

  @override
  String get username_help => '소문자, 숫자, _만 사용 가능';

  @override
  String get username_cooldown_info => '사용자명은 3일에 한 번만 변경할 수 있습니다';

  @override
  String get confirm_password_title => '비밀번호 확인';

  @override
  String get error_deleting_account => '계정 삭제 오류';

  @override
  String get type_updated => '유형이 업데이트되었습니다!';

  @override
  String get name_updated => '이름이 업데이트되었습니다!';

  @override
  String get username_updated => '사용자명이 업데이트되었습니다!';

  @override
  String get account_deleted => '계정이 성공적으로 삭제되었습니다';

  @override
  String get incorrect_password => '잘못된 비밀번호';

  @override
  String get user_not_found => '사용자를 찾을 수 없습니다';

  @override
  String get email_not_verified => '이메일이 아직 인증되지 않았습니다';

  @override
  String get verification_email_sent => '인증 이메일이 재전송되었습니다!';

  @override
  String get checking_verification => '확인 중...';

  @override
  String get already_have_account => '이미 계정이 있으신가요? 로그인';

  @override
  String get create_account => '계정 생성';

  @override
  String get account_created => '계정이 생성되었습니다! 활성화를 위해 이메일을 확인하세요';

  @override
  String get example123 => '예시123';

  @override
  String get new_routine => '새 루틴';

  @override
  String get edit_routine => '루틴 편집';

  @override
  String get activity_title => '활동 제목';

  @override
  String get activity_description => '활동 설명';

  @override
  String get time_format => '시간 (00:00 - 23:59)';

  @override
  String get category => '카테고리';

  @override
  String get icon => '아이콘';

  @override
  String get color => '색상';

  @override
  String get create_routine => '루틴 생성';

  @override
  String get save_changes => '변경사항 저장';

  @override
  String get routine_title_empty => '루틴 제목은 비워둘 수 없습니다';

  @override
  String get invalid_time_format =>
      '유효하지 않은 시간입니다. 24시간 형식을 사용하세요 (00:00 - 23:59)';

  @override
  String get delete_routine => '루틴 삭제';

  @override
  String get delete_routine_confirm => '이 루틴을 삭제하시겠습니까?';

  @override
  String hello_user_name(Object name) {
    return '안녕하세요, $name님! 👋';
  }

  @override
  String get statistics => '통계';

  @override
  String get general_summary => '일반 요약';

  @override
  String get total => '총계';

  @override
  String get progress_plural => '진행';

  @override
  String get crisis_plural => '위기';

  @override
  String get type_distribution => '유형별 분포';

  @override
  String get most_frequent_triggers => '가장 빈번한 유발 요인';

  @override
  String get weekly_trend => '주간 추세';

  @override
  String observations_last_7_days(int count) {
    return '지난 7일간 관찰: $count';
  }

  @override
  String get child_name => '아이 이름';

  @override
  String get age => '나이';

  @override
  String get support_level_label => '지원 수준';

  @override
  String get sensory_preferences => '감각 선호도';

  @override
  String get interests => '관심사';

  @override
  String get child_name_empty => '아이 이름은 비워둘 수 없습니다';

  @override
  String observations_last_7_days_count(int count) {
    return '지난 7일간 관찰: $count';
  }

  @override
  String get configure_profile => '프로필 구성';

  @override
  String get edit_username_title => '사용자명 편집';

  @override
  String get account_deleted_success => '계정이 성공적으로 삭제되었습니다';

  @override
  String get theme_light => '밝음';

  @override
  String get theme_dark => '어둠';

  @override
  String get theme_system => '시스템';

  @override
  String get edit_observation_action => '관찰 편집';

  @override
  String get delete_observation_action => '관찰 삭제';

  @override
  String get delete_observation_title => '관찰 삭제';

  @override
  String get delete_observation_message => '이 관찰을 삭제하시겠습니까?';

  @override
  String get trigger_routine_change => '루틴 변화';

  @override
  String get trigger_loud_noise => '큰 소음';

  @override
  String get trigger_crowd => '군중';

  @override
  String get trigger_tiredness => '피로';

  @override
  String get trigger_hunger => '배고픔';

  @override
  String get trigger_frustration => '좌절';

  @override
  String get trigger_transition => '전환';

  @override
  String get trigger_new_environment => '새로운 환경';

  @override
  String get trigger_bright_light => '밝은 빛';

  @override
  String get trigger_unpleasant_texture => '불쾌한 질감';

  @override
  String get trigger_strong_smell => '강한 냄새';

  @override
  String get trigger_temperature => '온도';

  @override
  String get trigger_tight_clothes => '꽉 끼는 옷';

  @override
  String get trigger_insufficient_sleep => '수면 부족';

  @override
  String get trigger_physical_pain => '신체적 고통';

  @override
  String get trigger_medication => '약물';

  @override
  String get trigger_medical_visit => '병원 방문';

  @override
  String get trigger_new_school => '새 학교';

  @override
  String get trigger_substitute_teacher => '대체 교사';

  @override
  String get trigger_test_evaluation => '시험/평가';

  @override
  String get trigger_party_event => '파티/행사';

  @override
  String get trigger_travel => '여행';

  @override
  String get trigger_rain_storm => '비/폭풍';

  @override
  String get trigger_parents_separation => '부모 분리';

  @override
  String get trigger_broken_toy => '부서진 장난감';

  @override
  String get trigger_not_getting_something => '무언가를 얻지 못함';

  @override
  String get trigger_activity_interruption => '활동 중단';

  @override
  String get trigger_waiting_too_long => '너무 오래 기다림';

  @override
  String get observer_father => '아버지';

  @override
  String get observer_mother => '어머니';

  @override
  String get observer_grandfather => '할아버지';

  @override
  String get observer_grandmother => '할머니';

  @override
  String get observer_uncle => '삼촌';

  @override
  String get observer_aunt => '이모/고모';

  @override
  String get observer_brother => '형/동생';

  @override
  String get observer_sister => '누나/언니/여동생';

  @override
  String get observer_son => '아들';

  @override
  String get observer_daughter => '딸';

  @override
  String get observer_grandson => '손자';

  @override
  String get observer_granddaughter => '손녀';

  @override
  String get observer_nephew => '조카';

  @override
  String get observer_niece => '조카딸';

  @override
  String get observer_male_cousin => '사촌형제';

  @override
  String get observer_female_cousin => '사촌자매';

  @override
  String get observer_male_friend => '남자 친구';

  @override
  String get observer_female_friend => '여자 친구';

  @override
  String get observer_relative => '친척';

  @override
  String get observer_caregiver => '돌봄이';

  @override
  String get observer_teacher => '선생님';

  @override
  String get observer_therapist => '치료사';

  @override
  String get observer_doctor => '의사';

  @override
  String get observer_psychologist => '심리학자';

  @override
  String get support_level_mild => '경미';

  @override
  String get support_level_moderate => '중등도';

  @override
  String get support_level_severe => '심각';

  @override
  String get sensory_visual => '시각';

  @override
  String get sensory_auditory => '청각';

  @override
  String get sensory_tactile => '촉각';

  @override
  String get sensory_movement => '움직임';

  @override
  String get sensory_olfactory => '후각';

  @override
  String get sensory_gustatory => '미각';

  @override
  String get sensory_proprioceptive => '고유수용성';

  @override
  String get sensory_vestibular => '전정';

  @override
  String get sensory_deep_pressure => '깊은 압력';

  @override
  String get sensory_soft_textures => '부드러운 질감';

  @override
  String get sensory_rough_textures => '거친 질감';

  @override
  String get sensory_low_sounds => '낮은 소리';

  @override
  String get sensory_high_sounds => '높은 소리';

  @override
  String get sensory_soft_lights => '부드러운 조명';

  @override
  String get sensory_bright_lights => '밝은 조명';

  @override
  String get sensory_hot_temperatures => '뜨거운 온도';

  @override
  String get sensory_cold_temperatures => '차가운 온도';

  @override
  String get interest_music => '음악';

  @override
  String get interest_drawing => '그리기';

  @override
  String get interest_numbers => '숫자';

  @override
  String get interest_animals => '동물';

  @override
  String get interest_cars => '자동차';

  @override
  String get interest_books => '책';

  @override
  String get interest_games => '게임';

  @override
  String get interest_computer => '컴퓨터';

  @override
  String get interest_tablet => '태블릿';

  @override
  String get interest_toys => '장난감';

  @override
  String get interest_sports => '스포츠';

  @override
  String get interest_dance => '춤';

  @override
  String get interest_cooking => '요리';

  @override
  String get interest_gardening => '원예';

  @override
  String get interest_science => '과학';

  @override
  String get interest_math => '수학';

  @override
  String get interest_art => '미술';

  @override
  String get interest_photography => '사진';

  @override
  String get interest_videos => '비디오';

  @override
  String get interest_movies => '영화';

  @override
  String get interest_series => '시리즈';

  @override
  String get interest_puzzles => '퍼즐';

  @override
  String get interest_lego => '레고';

  @override
  String get interest_dolls => '인형';

  @override
  String get interest_superheroes => '슈퍼히어로';

  @override
  String get delete_post_action => '삭제';

  @override
  String get report_post_action => '신고';

  @override
  String get clear_search => '검색 지우기';

  @override
  String get month => '개월';

  @override
  String get months => '개월';

  @override
  String get year => '세';

  @override
  String get years => '세';
}
