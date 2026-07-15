import 'package:flutter/material.dart';
import 'package:what_2_eat/l10n/app_localizations.dart';

extension AppLocalizationHelper on BuildContext {
  AppLocalizations get tr => AppLocalizations.of(this);
}
