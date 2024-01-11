part of 'apk_info_bloc.dart';

@Freezed(
  equal: false,
  makeCollectionsUnmodifiable: false,
)
class ApkInfoState with _$ApkInfoState {
  const factory ApkInfoState.init() = _InitialApkInfoState;

  // const factory ApkInfoState.load({
  //   required String? filePath,
  // }) = _LoadApkInfoState;

  const factory ApkInfoState.loadApkInfo({
    required String? filePath,
    List<FileInfo>? listInfo,
    List<String>? listPermissions,
  }) = _LoadApkInfoApkInfoState;

  const factory ApkInfoState.error({
    required String error,
  }) = _ErrorApkInfoState;

  const factory ApkInfoState.fatalError({
    required String error,
  }) = _FatalErrorApkInfoState;

  const factory ApkInfoState.showProgress() = _ShowProgressApkInfoState;

  const factory ApkInfoState.hideProgress() = _HideProgressApkInfoState;

}
