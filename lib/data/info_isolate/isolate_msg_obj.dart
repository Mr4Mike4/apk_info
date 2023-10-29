import 'dart:isolate';

import '../model/settings_obj.dart';

sealed class IsolateMsgObj {
  IsolateMsgObj({required this.sendReturnPort});

  final SendPort sendReturnPort;
}

class LoadApkInfo extends IsolateMsgObj {

  LoadApkInfo({
    required super.sendReturnPort,
    required this.path,
  });
  final String path;
}

class SettingsFilesInfo extends IsolateMsgObj {

  SettingsFilesInfo({
    required super.sendReturnPort,
    required this.settings,
  });
  final SettingsObj settings;
}

