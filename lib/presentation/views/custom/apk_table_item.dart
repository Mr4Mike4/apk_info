import 'package:apk_info/domain/model/file_info.dart';
import 'package:fluent_ui/fluent_ui.dart';

class ApkTableItem extends StatelessWidget {
  const ApkTableItem({
    super.key,
    required this.fileInfo,
  });

  final FileInfo fileInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      constraints: const BoxConstraints(
        minHeight: 32,
      ),
      child: Row(
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: Text(
              fileInfo.fieldName,
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(
            width: 32,
            child: Center(
              child: Text(':'),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Text(fileInfo.value ?? ''),
          ),
        ],
      ),
    );
  }
}
