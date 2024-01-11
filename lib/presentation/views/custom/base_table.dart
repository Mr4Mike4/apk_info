import 'package:fluent_ui/fluent_ui.dart';

class BaseTable extends StatelessWidget {
  const BaseTable({super.key, this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      clipBehavior: Clip.hardEdge,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            color: theme.resources.controlStrokeColorDefault,
            width: 1.0,
            style: BorderStyle.solid,
          ),
          color: theme.resources.controlFillColorDefault,
        ),
        child: child,
      ),
    );
  }
}
