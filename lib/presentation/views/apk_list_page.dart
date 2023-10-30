import 'package:apk_info/internal/app_args.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

import '../../domain/state/apk_info/apk_info_bloc.dart';
import '../../localizations.dart';
import 'custom/apk_table.dart';
import 'custom/input_text_field.dart';

class ApkListPage extends StatefulWidget {
  const ApkListPage({
    super.key,
  });

  @override
  State<ApkListPage> createState() => _ApkListPageState();
}

class _ApkListPageState extends State<ApkListPage> {
  late ApkInfoBloc _bloc;

  final _filePathController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final di = KiwiContainer();
    _bloc = ApkInfoBloc(
      di.resolve(),
      di.resolve(),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final appArgs = AppArgs.of(context);
      final filePath = appArgs.filePath;
      if (filePath != null) {
        _bloc.add(ApkInfoEvent.openFilePath(
          filePath: filePath,
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    // final theme = FluentTheme.of(context);
    final S = AppLocal.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: InputTextField(
                    labelText: S.file_path,
                    controller: _filePathController,
                    scrollController: _scrollController,
                    readOnly: true,
                  ),
                ),
                Button(
                  child: Text(S.btn_select),
                  onPressed: () {
                    _bloc.add(const ApkInfoEvent.openFiles());
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<ApkInfoBloc, ApkInfoState>(
              bloc: _bloc,
              buildWhen: (previous, current) {
                return current.maybeMap(
                  loadApkInfo: (st) {
                    _filePathController.text = st.filePath ?? '';
                    WidgetsBinding.instance.addPostFrameCallback((_) async {
                      _scrollController
                          .jumpTo(_scrollController.position.maxScrollExtent);
                    });
                    return true;
                  },
                  orElse: () => true,
                );
              },
              builder: (context, state) {
                return state.maybeMap(
                  loadApkInfo: (st) => ApkTable(
                    key: const Key('apk_table'),
                    listInfo: st.listInfo,
                  ),
                  showProgress: (_) => const Center(child: ProgressRing()),
                  orElse: () => const ApkTable(
                    key: Key('apk_table'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
