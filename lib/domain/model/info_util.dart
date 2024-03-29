import 'dart:io';

import 'package:apk_info/domain/model/file_info.dart';
import 'package:apk_info/internal/localiz.dart';
import 'package:parser_apk_info/model/apk_info.dart';


extension _ListExt on List<FileInfo> {
  void setRow(final String fieldName, final String? value) {
    add(FileInfo(
      fieldName: fieldName,
      value: value,
    ));
  }
}

class InfoUtil {
  static List<FileInfo> fromApkInfo(
    final AppLocalizations S,
    final ApkInfo? apkInfo,
  ) {
    final fileInfo=<FileInfo>[];
    if(apkInfo != null) {
      fileInfo.setRow(S.apk_application_label, apkInfo.applicationLabel);
      fileInfo.setRow(S.apk_application_id, apkInfo.applicationId);
      fileInfo.setRow(S.apk_version_code, apkInfo.versionCode);
      fileInfo.setRow(S.apk_version_name, apkInfo.versionName);
      fileInfo.setRow(S.apk_platform_build_version_name, apkInfo.platformBuildVersionName);
      fileInfo.setRow(S.apk_platform_build_version_code, apkInfo.platformBuildVersionCode);
      fileInfo.setRow(S.apk_compile_sdk_version, apkInfo.compileSdkVersion);
      fileInfo.setRow(S.apk_compile_sdk_version_codename,apkInfo.compileSdkVersionCodename);
      fileInfo.setRow(S.apk_sdk_version, apkInfo.minSdkVersion);
      fileInfo.setRow(S.apk_target_sdk_version, apkInfo.targetSdkVersion);
      fileInfo.setRow(S.apk_native_codes, apkInfo.nativeCodes?.join(', '));
      fileInfo.setRow(S.apk_file_size, getFileSize(apkInfo.file));
    }
    return fileInfo;
  }

  static String? getFileSize(File? file) {

    if (file == null) {
      return null;
    }
    if (!file.existsSync()) {
      return null;
    }

    int bytes = file.lengthSync();

    if (bytes < 1024) {
      return '$bytes B'; // Байты
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(2)} KB'; // Килобайты
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB'; // Мегабайты
    } else {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB'; // Гигабайты
    }
  }
}
