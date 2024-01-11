import 'package:apk_info/presentation/views/custom/base_table.dart';
import 'package:apk_info/presentation/views/custom/permission_table_item.dart';
import 'package:fluent_ui/fluent_ui.dart';

class PermissionTable extends StatefulWidget {
  const PermissionTable({
    super.key,
    this.listPermissions,
  });

  final List<String>? listPermissions;

  @override
  State<PermissionTable> createState() => _PermissionTableState();
}

class _PermissionTableState extends State<PermissionTable> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final FluentThemeData theme = FluentTheme.of(context);
    // final S = AppLocal.of(context);
    return BaseTable(
      child: SelectionArea(
        child: ListView.builder(
          itemCount: widget.listPermissions?.length ?? 0,
          controller: _scrollController,
          itemBuilder: (context, index) {
            final item = widget.listPermissions![index];
            return PermissionTableItem(
              permission: item,
            );
          },
        ),
      ),
    );
  }
}
