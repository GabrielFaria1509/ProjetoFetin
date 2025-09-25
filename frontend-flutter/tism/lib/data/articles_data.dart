import 'package:tism/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ArticlesData {
  static List<Map<String, String>> getArticles(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    
    return [
      {
        'title': localizations.article_early_signs_title,
        'body': localizations.article_early_signs_body,
        'author': localizations.article_early_signs_author,
        'published_at': '2024-12-19',
      },
      {
        'title': localizations.article_aba_therapy_title,
        'body': localizations.article_aba_therapy_body,
        'author': localizations.article_aba_therapy_author,
        'published_at': '2024-12-18',
      },
      {
        'title': localizations.article_routines_title,
        'body': localizations.article_routines_body,
        'author': localizations.article_routines_author,
        'published_at': '2024-12-17',
      },
      {
        'title': localizations.article_school_inclusion_title,
        'body': localizations.article_school_inclusion_body,
        'author': localizations.article_school_inclusion_author,
        'published_at': '2024-12-16',
      },
    ];
  }
}