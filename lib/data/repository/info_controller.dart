import 'dart:async';
import 'dart:io';

import 'package:parser_apk_info/parser_apk_info.dart';

class InfoController {
  final Logger _logger;
  final ParserApkInfo _parserApkInfo;

  InfoController(this._logger) : _parserApkInfo = ParserApkInfo(_logger);

  // final List<ApkInfo> _listApkInfo = [];
  //
  // List<ApkInfo> get listApkInfo => List.unmodifiable(_listApkInfo);

  Future<bool> aaptInit(String? aaptPath) {
    return _parserApkInfo.aaptInit(aaptPath);
  }

  Future<ApkInfo?> loadApkInfo(String path) async {
    _logger.d('loadApkInfo path >> $path');
    final file = File(path);
    return _parserApkInfo.parseFile(file);
  }
}
