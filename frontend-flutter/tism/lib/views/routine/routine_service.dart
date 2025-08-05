import 'routine_models.dart';

class RoutineService {
  static List<RoutineActivity> generateRoutine(ChildProfile profile) {
    final activities = <RoutineActivity>[];
    
    // Rotina matinal
    activities.addAll([
      RoutineActivity(
        id: '1',
        title: 'Acordar',
        icon: '🌅',
        time: '07:00',
        description: 'Despertar com música suave',
        category: 'manhã',
      ),
      RoutineActivity(
        id: '2',
        title: 'Escovar dentes',
        icon: '🦷',
        time: '07:15',
        description: 'Usar escova macia por 2 minutos',
        category: 'manhã',
      ),
      RoutineActivity(
        id: '3',
        title: 'Café da manhã',
        icon: '🥣',
        time: '07:30',
        description: 'Comer sentado na mesa',
        category: 'manhã',
      ),
    ]);

    // Atividades escolares/educativas
    if (profile.age >= 3) {
      activities.addAll([
        RoutineActivity(
          id: '4',
          title: 'Atividade educativa',
          icon: '📚',
          time: '09:00',
          description: 'Jogos educativos ou escola',
          category: 'educação',
        ),
        RoutineActivity(
          id: '5',
          title: 'Lanche',
          icon: '🍎',
          time: '10:30',
          description: 'Fruta ou lanche saudável',
          category: 'alimentação',
        ),
      ]);
    }

    // Atividades baseadas em interesses
    if (profile.interests.contains('música')) {
      activities.add(RoutineActivity(
        id: '6',
        title: 'Música',
        icon: '🎵',
        time: '14:00',
        description: 'Ouvir ou tocar música',
        category: 'lazer',
      ));
    }
    
    if (profile.interests.contains('desenho')) {
      activities.add(RoutineActivity(
        id: '10',
        title: 'Desenhar',
        icon: '🎨',
        time: '15:00',
        description: 'Atividade de desenho livre',
        category: 'lazer',
      ));
    }
    
    if (profile.interests.contains('números')) {
      activities.add(RoutineActivity(
        id: '11',
        title: 'Números',
        icon: '🔢',
        time: '16:00',
        description: 'Jogos com números',
        category: 'educação',
      ));
    }
    
    // Adaptações por nível de suporte
    if (profile.supportLevel == 'severo') {
      // Adiciona mais pausas sensoriais
      activities.add(RoutineActivity(
        id: '12',
        title: 'Pausa sensorial',
        icon: '🧘',
        time: '11:00',
        description: 'Momento de calma e autorregulação',
        category: 'bem-estar',
      ));
    }

    // Rotina noturna adaptada por idade
    final bedtime = profile.age <= 5 ? '19:30' : '20:30';
    activities.addAll([
      RoutineActivity(
        id: '7',
        title: 'Jantar',
        icon: '🍽️',
        time: '18:00',
        description: 'Refeição em família',
        category: 'noite',
      ),
      RoutineActivity(
        id: '8',
        title: 'Banho',
        icon: '🛁',
        time: '19:00',
        description: profile.sensoryPreferences.contains('tátil') 
            ? 'Água morna, esponja macia' 
            : 'Banho rápido, água morna',
        category: 'noite',
      ),
      RoutineActivity(
        id: '9',
        title: 'Dormir',
        icon: '😴',
        time: bedtime,
        description: profile.sensoryPreferences.contains('auditivo')
            ? 'Música suave para dormir'
            : 'História e ambiente escuro',
        category: 'noite',
      ),
    ]);

    return activities;
  }

  static Map<String, List<RoutineActivity>> groupByCategory(List<RoutineActivity> activities) {
    final grouped = <String, List<RoutineActivity>>{};
    for (final activity in activities) {
      grouped.putIfAbsent(activity.category, () => []).add(activity);
    }
    return grouped;
  }
}