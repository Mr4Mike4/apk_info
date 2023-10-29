import 'dart:async';

import 'package:apk_info/data/info_isolate/info_isolate.dart';
import 'package:apk_info/domain/model/file_info.dart';
import 'package:apk_info/domain/model/info_util.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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
    // final destPath = await _pref.getDestPath();
    // final copyToFolder = await _pref.getCopyToFolder();
    // final pattern = await _pref.getPattern();
    // emit.call(ApkInfoState.load(
    //   destPath: destPath,
    //   copyToFolder: copyToFolder,
    //   pattern: pattern,
    // ));
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
    emit.call(const ApkInfoState.showProgress());
    List<FileInfo>? listFileInfo;
    if (path != null) {
      logger.d('_OpenFilesApkInfoEvent >> $path');
      final apkInfo = await _infoIsolate.getApkInfo(path);
      listFileInfo = InfoUtil.fromApkInfo(_S, apkInfo);
    } else {
      logger.d('_OpenFilesApkInfoEvent >> no select');
    }
    emit.call(ApkInfoState.loadApkInfo(
      filePath: path,
      listInfo: listFileInfo,
    ));
  }
}
