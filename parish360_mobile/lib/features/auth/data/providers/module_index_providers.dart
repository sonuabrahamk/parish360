import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'module_index_providers.g.dart';

@riverpod
class ModuleIndex extends _$ModuleIndex {
  @override
  int build() {
    return 0;
  }

  void setIndex(int index) {
    state = index;
  }
}