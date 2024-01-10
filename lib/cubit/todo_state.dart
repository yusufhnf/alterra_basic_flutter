part of 'todo_cubit.dart';

@freezed
class TodoState with _$TodoState {
  const factory TodoState.initial() = _Initial;
  const factory TodoState.empty() = _Empty;
  const factory TodoState.loaded({required List<String> data}) = _Loaded;
}
