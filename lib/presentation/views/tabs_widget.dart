import 'package:apk_info/domain/model/file_info.dart';
import 'package:apk_info/localizations.dart';
import 'package:apk_info/presentation/views/custom/apk_table.dart';
import 'package:apk_info/presentation/views/custom/permission_table.dart';
import 'package:fluent_ui/fluent_ui.dart';

class TabsWidget extends StatefulWidget {
  const TabsWidget({
    super.key,
    this.listInfo,
    this.listPermissions,
  });

  final List<FileInfo>? listInfo;
  final List<String>? listPermissions;

  @override
  State<TabsWidget> createState() => _TabsWidgetState();
}

class _TabsWidgetState extends State<TabsWidget> {
  int currentIndex = 0;
  final List<Tab> tabs = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final S = AppLocal.of(context);
    tabs.add(Tab(
      text: Text(S.tab_main),
      semanticLabel: S.tab_main,
      body: ApkTable(
        listInfo: widget.listInfo,
      ),
    ));
    tabs.add(Tab(
      text: Text(S.tab_permissions),
      semanticLabel: S.tab_permissions,
      body: PermissionTable(
        listPermissions: widget.listPermissions,
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabView(
      tabs: tabs,
      currentIndex: currentIndex,
      onChanged: (index) => setState(() => currentIndex = index),
      tabWidthBehavior: TabWidthBehavior.equal,
      closeButtonVisibility: CloseButtonVisibilityMode.never,
      showScrollButtons: true,
    );
  }
}
