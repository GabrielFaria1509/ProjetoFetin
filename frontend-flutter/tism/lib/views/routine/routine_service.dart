import 'routine_models.dart';

class RoutineService {
  static List<RoutineActivity> filterByCategory(List<RoutineActivity> activities, String? category) {
    if (category == null || category.isEmpty) return activities;
    return activities.where((a) => a.category == category).toList();
  }
  
  static List<RoutineActivity> filterByDifficulty(List<RoutineActivity> activities, String? difficulty) {
    if (difficulty == null || difficulty.isEmpty) return activities;
    return activities.where((a) => a.difficulty == difficulty).toList();
  }
  
  static List<RoutineActivity> generateRoutine(ChildProfile profile) {
    final activities = <RoutineActivity>[];
    
    // Horários adaptados por idade
    final wakeTime = profile.age <= 3 ? '07:30' : profile.age <= 6 ? '07:00' : '06:30';
    final bedTime = profile.age <= 3 ? '19:00' : profile.age <= 6 ? '20:00' : '21:00';
    
    // Rotina matinal personalizada
    activities.addAll(_getMorningRoutine(profile, wakeTime));
    
    // Atividades educativas baseadas na idade
    activities.addAll(_getEducationalActivities(profile));
    
    // Atividades de interesse personalizadas
    activities.addAll(_getInterestBasedActivities(profile));
    
    // Pausas sensoriais baseadas no nível de suporte
    activities.addAll(_getSensoryBreaks(profile));
    
    // Rotina noturna
    activities.addAll(_getEveningRoutine(profile, bedTime));
    
    // Ordena por horário
    activities.sort((a, b) => a.time.compareTo(b.time));
    
    return activities;
  }
  
  static List<RoutineActivity> _getMorningRoutine(ChildProfile profile, String wakeTime) {
    final activities = <RoutineActivity>[];
    
    activities.add(RoutineActivity(
      id: 'wake',
      title: 'Acordar',
      icon: '🌅',
      time: wakeTime,
      description: profile.sensoryPreferences.contains('auditivo') 
          ? 'Despertar com música suave e familiar'
          : 'Despertar com luz natural gradual',
      category: 'manhã',
      difficulty: profile.supportLevel == 'severo' ? 'alta' : 'baixa',
    ));
    
    final brushTime = _addMinutes(wakeTime, 15);
    activities.add(RoutineActivity(
      id: 'brush',
      title: 'Higiene matinal',
      icon: '🦷',
      time: brushTime,
      description: profile.supportLevel == 'severo'
          ? 'Escova extra macia, pasta sem flúor, 1 minuto'
          : 'Escovar dentes por 2 minutos, lavar rosto',
      category: 'manhã',
      difficulty: profile.supportLevel == 'severo' ? 'alta' : 'média',
    ));
    
    final breakfastTime = _addMinutes(wakeTime, 30);
    activities.add(RoutineActivity(
      id: 'breakfast',
      title: 'Café da manhã',
      icon: '🥣',
      time: breakfastTime,
      description: profile.sensoryPreferences.contains('tátil')
          ? 'Texturas suaves, temperatura morna'
          : 'Refeição balanceada na mesa',
      category: 'manhã',
      difficulty: 'baixa',
    ));
    
    return activities;
  }
  
  static List<RoutineActivity> _getEducationalActivities(ChildProfile profile) {
    final activities = <RoutineActivity>[];
    
    if (profile.age >= 3) {
      final studyTime = profile.age <= 5 ? '09:00' : '08:30';
      final duration = profile.supportLevel == 'severo' ? '15 min' : '30-45 min';
      
      activities.add(RoutineActivity(
        id: 'study',
        title: profile.age <= 5 ? 'Brincadeira educativa' : 'Atividade escolar',
        icon: '📚',
        time: studyTime,
        description: 'Duração: $duration. ${_getEducationDescription(profile)}',
        category: 'educação',
        difficulty: profile.supportLevel == 'leve' ? 'baixa' : 'média',
      ));
      
      activities.add(RoutineActivity(
        id: 'snack',
        title: 'Lanche',
        icon: '🍎',
        time: '10:30',
        description: 'Fruta ou lanche saudável preferido',
        category: 'alimentação',
        difficulty: 'baixa',
      ));
    }
    
    return activities;
  }
  
  static List<RoutineActivity> _getInterestBasedActivities(ChildProfile profile) {
    final activities = <RoutineActivity>[];
    var timeSlot = 14;
    
    for (final interest in profile.interests) {
      final activity = _createInterestActivity(interest, timeSlot, profile);
      if (activity != null) {
        activities.add(activity);
        timeSlot++;
      }
    }
    
    return activities;
  }
  
  static RoutineActivity? _createInterestActivity(String interest, int hour, ChildProfile profile) {
    final timeStr = '${hour.toString().padLeft(2, '0')}:00';
    
    switch (interest) {
      case 'música':
        return RoutineActivity(
          id: 'music_$hour',
          title: 'Música',
          icon: '🎵',
          time: timeStr,
          description: profile.sensoryPreferences.contains('auditivo')
              ? 'Instrumentos, cantar, dançar'
              : 'Ouvir música calma, ritmo suave',
          category: 'lazer',
          difficulty: 'baixa',
        );
      case 'desenho':
        return RoutineActivity(
          id: 'art_$hour',
          title: 'Arte e desenho',
          icon: '🎨',
          time: timeStr,
          description: profile.sensoryPreferences.contains('visual')
              ? 'Cores vibrantes, formas geométricas'
              : 'Desenho livre, materiais variados',
          category: 'lazer',
          difficulty: 'baixa',
        );
      case 'números':
        return RoutineActivity(
          id: 'math_$hour',
          title: 'Jogos com números',
          icon: '🔢',
          time: timeStr,
          description: profile.age <= 5
              ? 'Contar objetos, formas, cores'
              : 'Operações simples, padrões',
          category: 'educação',
          difficulty: profile.supportLevel == 'leve' ? 'baixa' : 'média',
        );
      case 'movimento':
        return RoutineActivity(
          id: 'exercise_$hour',
          title: 'Atividade física',
          icon: '🏃',
          time: timeStr,
          description: profile.supportLevel == 'severo'
              ? 'Movimentos suaves, alongamento'
              : 'Correr, pular, brincar ao ar livre',
          category: 'bem-estar',
          difficulty: profile.supportLevel == 'severo' ? 'média' : 'baixa',
        );
      case 'leitura':
        return RoutineActivity(
          id: 'reading_$hour',
          title: 'Leitura',
          icon: '📖',
          time: timeStr,
          description: profile.age <= 5
              ? 'Histórias com figuras, livros táteis'
              : 'Leitura independente ou assistida',
          category: 'educação',
          difficulty: 'média',
        );
      default:
        return null;
    }
  }
  
  static List<RoutineActivity> _getSensoryBreaks(ChildProfile profile) {
    final activities = <RoutineActivity>[];
    
    if (profile.supportLevel == 'severo') {
      activities.addAll([
        RoutineActivity(
          id: 'sensory1',
          title: 'Pausa sensorial',
          icon: '🧘',
          time: '11:00',
          description: 'Autorregulação, respiração, ambiente calmo',
          category: 'bem-estar',
          difficulty: 'alta',
        ),
        RoutineActivity(
          id: 'sensory2',
          title: 'Relaxamento',
          icon: '🌸',
          time: '16:30',
          description: 'Massagem suave, música relaxante',
          category: 'bem-estar',
          difficulty: 'média',
        ),
      ]);
    } else if (profile.supportLevel == 'moderado') {
      activities.add(RoutineActivity(
        id: 'break',
        title: 'Pausa',
        icon: '☕',
        time: '15:30',
        description: 'Momento livre, atividade preferida',
        category: 'bem-estar',
        difficulty: 'baixa',
      ));
    }
    
    return activities;
  }
  
  static List<RoutineActivity> _getEveningRoutine(ChildProfile profile, String bedTime) {
    final activities = <RoutineActivity>[];
    
    final dinnerTime = _subtractMinutes(bedTime, 120);
    final bathTime = _subtractMinutes(bedTime, 60);
    
    activities.addAll([
      RoutineActivity(
        id: 'dinner',
        title: 'Jantar',
        icon: '🍽️',
        time: dinnerTime,
        description: 'Refeição em família, ambiente calmo',
        category: 'noite',
        difficulty: 'baixa',
      ),
      RoutineActivity(
        id: 'bath',
        title: 'Banho',
        icon: '🛁',
        time: bathTime,
        description: _getBathDescription(profile),
        category: 'noite',
        difficulty: profile.sensoryPreferences.contains('tátil') ? 'alta' : 'média',
      ),
      RoutineActivity(
        id: 'sleep',
        title: 'Preparar para dormir',
        icon: '😴',
        time: bedTime,
        description: _getSleepDescription(profile),
        category: 'noite',
        difficulty: profile.supportLevel == 'severo' ? 'alta' : 'média',
      ),
    ]);
    
    return activities;
  }
  
  static String _getEducationDescription(ChildProfile profile) {
    if (profile.interests.contains('números')) return 'Foco em matemática e lógica';
    if (profile.interests.contains('leitura')) return 'Atividades de linguagem';
    if (profile.interests.contains('música')) return 'Aprendizado através da música';
    return 'Atividades multissensoriais';
  }
  
  static String _getBathDescription(ChildProfile profile) {
    if (profile.sensoryPreferences.contains('tátil')) {
      return 'Água morna (36°C), esponja extra macia, sabonete neutro';
    }
    return 'Banho rápido, temperatura agradável';
  }
  
  static String _getSleepDescription(ChildProfile profile) {
    final elements = <String>[];
    
    if (profile.sensoryPreferences.contains('auditivo')) {
      elements.add('música suave ou ruído branco');
    }
    if (profile.sensoryPreferences.contains('visual')) {
      elements.add('luz noturna suave');
    }
    if (profile.sensoryPreferences.contains('tátil')) {
      elements.add('cobertor pesado ou pelúcia');
    }
    
    return elements.isEmpty 
        ? 'Ambiente escuro e silencioso'
        : elements.join(', ');
  }
  
  static String _addMinutes(String time, int minutes) {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]) + minutes;
    
    final newHour = (hour + minute ~/ 60) % 24;
    final newMinute = minute % 60;
    
    return '${newHour.toString().padLeft(2, '0')}:${newMinute.toString().padLeft(2, '0')}';
  }
  
  static String _subtractMinutes(String time, int minutes) {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    
    final totalMinutes = hour * 60 + minute - minutes;
    final newHour = (totalMinutes ~/ 60) % 24;
    final newMinute = totalMinutes % 60;
    
    return '${newHour.toString().padLeft(2, '0')}:${newMinute.toString().padLeft(2, '0')}';
  }

  static Map<String, List<RoutineActivity>> groupByCategory(List<RoutineActivity> activities) {
    final grouped = <String, List<RoutineActivity>>{};
    for (final activity in activities) {
      grouped.putIfAbsent(activity.category, () => []).add(activity);
    }
    return grouped;
  }
}