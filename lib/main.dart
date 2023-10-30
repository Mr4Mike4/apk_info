import 'package:apk_info/internal/app_args.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Page;
import 'package:flutter/foundation.dart';
import 'package:system_theme/system_theme.dart';
import 'package:window_manager/window_manager.dart';

import 'internal/app_assembly.dart';
import 'internal/application.dart';

bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

Future<void> main(List<String> arguments) async {
  WidgetsFlutterBinding.ensureInitialized();

  // if it's not on the web, windows or android, load the accent color
  if (!kIsWeb &&
      [
        TargetPlatform.windows,
        TargetPlatform.android,
      ].contains(defaultTargetPlatform)) {
    SystemTheme.accentColor.load();
  }

  await AppAssembly.init();

  await WindowManager.instance.ensureInitialized();
  const windowOptions = WindowOptions(
    size: Size(500, 600),
    minimumSize: Size(500, 600),
    center: true,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
    windowButtonVisibility: false,
  );

  windowManager.waitUntilReadyToShow(windowOptions).then((_) async {
    await windowManager.show();
    await windowManager.setPreventClose(true);
  });

  runApp(AppArgs(
    filePath: arguments.firstOrNull,
    child: const MyApp(),
  ));

}
