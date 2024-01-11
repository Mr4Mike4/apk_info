import 'package:fluent_ui/fluent_ui.dart';

class PermissionTableItem extends StatelessWidget {
  const PermissionTableItem({
    super.key,
    required this.permission,
  });

  final String? permission;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      constraints: const BoxConstraints(
        minHeight: 32,
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        permission??'',
      ),
    );
  }
}
