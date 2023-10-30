import 'package:fluent_ui/fluent_ui.dart';

class AppArgs extends InheritedWidget {
  const AppArgs({
    super.key,
    required super.child,
    required this.filePath,
  });

  final String? filePath;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static AppArgs of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppArgs>()!;
  }
}
