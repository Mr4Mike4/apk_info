part of 'apk_info_bloc.dart';

@Freezed(
  map: FreezedMapOptions.none,
  when: FreezedWhenOptions.none,
)
class ApkInfoEvent with _$ApkInfoEvent {
  const factory ApkInfoEvent.init() = _InitApkInfoEvent;

  const factory ApkInfoEvent.openFiles() = _OpenFilesApkInfoEvent;

}
