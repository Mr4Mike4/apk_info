import 'package:apk_info/data/info_isolate/info_isolate.dart';
import 'package:apk_info/data/model/settings_obj.dart';
import 'package:apk_info/data/repository/preferences_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:kiwi/kiwi.dart';
import 'package:logger/logger.dart' as l;

class AppAssembly {
  static Future<void> init() async {
    if (kDebugMode) {
      l.Logger.level = l.Level.trace;
    } else {
      l.Logger.level = l.Level.off;
    }
    PreferencesRepository.init();

    final container = KiwiContainer();
    container
      ..registerSingleton((di) => PreferencesRepository())
      ..registerSingleton((di) => InfoIsolate());

    final infoIsolate = container.resolve<InfoIsolate>();
    final pref = container.resolve<PreferencesRepository>();
    final aaptPath = await pref.getAaptPath();
    if (aaptPath != null) {
      await infoIsolate.init(SettingsObj(
        aaptPath: aaptPath,
      ));
    }
  }
}
