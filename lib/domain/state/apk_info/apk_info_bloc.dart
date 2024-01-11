import 'dart:async';

import 'package:apk_info/data/info_isolate/info_isolate.dart';
import 'package:apk_info/domain/model/file_info.dart';
import 'package:apk_info/domain/model/info_util.dart';
import 'package:apk_info/internal/aapt_path_util.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parser_apk_info/repository/aapt_util.dart';

import '../../../data/repository/preferences_repository.dart';
import '../../../internal/localiz.dart';
import '../../../logger.dart';

part 'apk_info_bloc.freezed.dart';
part 'apk_info_event.dart';
part 'apk_info_state.dart';

class ApkInfoBloc extends Bloc<ApkInfoEvent, ApkInfoState> {
  ApkInfoBloc(this._infoIsolate, this._pref)
      : super(const ApkInfoState.init()) {
    on<_InitApkInfoEvent>(_onInitApkInfoEvent);
    on<_OpenFilesApkInfoEvent>(_onOpenFilesApkInfoEvent);
    on<_OpenFilePathApkInfoEvent>(_onOpenFilePathApkInfoEvent);
    Localiz.l10n.then((l10n) {
      _S = l10n;
    });
    add(const ApkInfoEvent.init());
  }

  final InfoIsolate _infoIsolate;
  final PreferencesRepository _pref;
  late final AppLocalizations _S;

  FutureOr<void> _onInitApkInfoEvent(
      _InitApkInfoEvent event, Emitter<ApkInfoState> emit) async {
    final aaptDirPath = AaptPathUtil.getAaptApp(kDebugMode);
    final aaptPath = await AaptUtil.getAaptApp(aaptDirPath);
    if (aaptPath == null) {
      emit.call(ApkInfoState.fatalError(
        error: _S.error_aapt_not_found,
      ));
      return;
    }
  }

  Future<void> _openFile(Emitter<ApkInfoState> emit, String? path) async {
    emit.call(const ApkInfoState.showProgress());
    List<FileInfo>? listFileInfo;
    List<String>? listPermissions;
    if (path != null) {
      logger.d('_OpenFilesApkInfoEvent >> $path');
      final apkInfo = await _infoIsolate.getApkInfo(path);
      listFileInfo = InfoUtil.fromApkInfo(_S, apkInfo);
      listPermissions = apkInfo?.usesPermissions;
    } else {
      logger.d('_OpenFilesApkInfoEvent >> no select');
    }
    emit.call(ApkInfoState.loadApkInfo(
      filePath: path,
      listInfo: listFileInfo,
      listPermissions: listPermissions,
    ));
  }

  FutureOr<void> _onOpenFilesApkInfoEvent(
      _OpenFilesApkInfoEvent event, Emitter<ApkInfoState> emit) async {
    logger.d('_OpenFilesApkInfoEvent');
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['apk'],
      allowMultiple: false,
      lockParentWindow: true,
    );
    final path = result?.paths.firstOrNull;
    await _openFile(emit, path);
  }

  FutureOr<void> _onOpenFilePathApkInfoEvent(
      _OpenFilePathApkInfoEvent event, Emitter<ApkInfoState> emit)async {
    logger.d('_OpenFilePathApkInfoEvent');
    final path = event.filePath;
    if(path?.endsWith(AaptUtil.apkExt)??false){
      await _openFile(emit, path);
    }
  }
}
