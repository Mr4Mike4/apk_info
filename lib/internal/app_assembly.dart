import 'package:apk_info/data/info_isolate/info_isolate.dart';
import 'package:apk_info/data/model/settings_obj.dart';
import 'package:apk_info/data/repository/preferences_repository.dart';
import 'package:apk_info/internal/aapt_path_util.dart';
import 'package:flutter/foundation.dart';
import 'package:kiwi/kiwi.dart';
import 'package:logger/logger.dart' as l;
import 'package:parser_apk_info/repository/aapt_util.dart';

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
    final aaptDirPath = AaptPathUtil.getAaptApp(kDebugMode);
    final aaptPath = await AaptUtil.getAaptApp(aaptDirPath);
    if (aaptPath != null) {
      await infoIsolate.init(SettingsObj(
        aaptPath: aaptPath,
      ));
    }
  }
}
