import 'dart:async';
import 'dart:isolate';

import 'package:apk_info/data/repository/info_controller.dart';
import 'package:parser_apk_info/model/apk_info.dart';

import '../model/settings_obj.dart';
import 'app_logger.dart';
import 'isolate_msg_obj.dart';

FutureOr<void> _createIsolate(_IsolateInit info) async {
  final receivePort = ReceivePort();

  final infoController = InfoController(AppLogger());

  info.sendPort.send(IsolateReturn(
    sendPort: receivePort.sendPort,
  ));

  // final aaptPath = await pref.getAaptPath();
  await infoController.aaptInit(info.settings.aaptPath);

  receivePort.listen(
    (data) {
      final msg = data as IsolateMsgObj;
      switch (msg) {
        case LoadApkInfo():
          infoController.loadApkInfo(msg.path).then((apkInfo) {
            msg.sendReturnPort.send(apkInfo);
          });
          break;
        case SettingsFilesInfo():
          infoController
              .aaptInit(msg.settings.aaptPath)
              .then((res) => msg.sendReturnPort.send(res));
          break;
      }
    },
    cancelOnError: false,
  );
}

class _IsolateInit {
  const _IsolateInit({
    required this.sendPort,
    required this.settings,
  });

  final SettingsObj settings;
  final SendPort sendPort;
}

class IsolateReturn {
  const IsolateReturn({
    required this.sendPort,
  });

  final SendPort sendPort;
}

class InfoIsolate {
  Isolate? _infoIsolate;
  SendPort? _sendPort;

  bool get hasIsolate => _infoIsolate != null;

  Future<void> init(SettingsObj settings) async {
    if (hasIsolate) return;
    final receivePort = ReceivePort();
    _infoIsolate = await Isolate.spawn<_IsolateInit>(
      _createIsolate,
      _IsolateInit(
        sendPort: receivePort.sendPort,
        settings: settings,
      ),
      debugName: 'InfoIsolate',
    );
    final isolateSyncReturn = await receivePort.first as IsolateReturn;
    _sendPort = isolateSyncReturn.sendPort;
  }

  FutureOr<void> kill() {
    if (hasIsolate) {
      // _receivePort?.close();
      _infoIsolate?.kill(priority: Isolate.immediate);
      _infoIsolate = null;
      // _receivePort = null;
    }
  }

  Future<ApkInfo?> getApkInfo(String path) async {
    final port = ReceivePort();
    _sendPort?.send(LoadApkInfo(
      sendReturnPort: port.sendPort,
      path: path,
    ));
    final obj = await port.first;
    if (obj is ApkInfo?) {
      return obj;
    } else {
      return null;
    }
  }

  Future<void> updateSettings(SettingsObj settings) async {
    final port = ReceivePort();
    _sendPort?.send(SettingsFilesInfo(
      sendReturnPort: port.sendPort,
      settings: settings,
    ));
    await port.first;
  }
}
