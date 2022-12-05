import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repos/repo.dart';

final todoRepositoryProvider = ChangeNotifierProvider((_) => TodoRepository());

final todoListProvider = Provider((ref) {
  final todoRepository = ref.watch(todoRepositoryProvider);
  return todoRepository.returnAllTodo();
});

final repoProvider = Provider((ref) {
  final todoRepository = ref.watch(todoRepositoryProvider);
  return todoRepository;
});
