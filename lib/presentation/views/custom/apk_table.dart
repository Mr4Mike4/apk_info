import 'package:apk_info/domain/model/file_info.dart';
import 'package:apk_info/presentation/views/custom/base_table.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'apk_table_item.dart';

class ApkTable extends StatefulWidget {
  const ApkTable({
    super.key,
    this.listInfo,
  });

  final List<FileInfo>? listInfo;

  @override
  State<ApkTable> createState() => _ApkTableState();
}

class _ApkTableState extends State<ApkTable> {
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
    return BaseTable(
      child: SelectionArea(
        child: ListView.builder(
          itemCount: widget.listInfo?.length ?? 0,
          controller: _scrollController,
          itemBuilder: (context, index) {
            final item = widget.listInfo![index];
            return ApkTableItem(
              fileInfo: item,
            );
          },
        ),
      ),
    );
  }
}
