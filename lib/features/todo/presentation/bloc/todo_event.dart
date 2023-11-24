part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class CreateTodoEvent extends TodoEvent {
  final String todoTitle;

  const CreateTodoEvent({required this.todoTitle});
}

class DeleteTodoEvent extends TodoEvent {
  final TodoEntity todoEntity;

  const DeleteTodoEvent({required this.todoEntity});
}

class UpdateTodoEvent extends TodoEvent {
  final TodoEntity todoEntity;

  const UpdateTodoEvent({required this.todoEntity});
}

class SearchTodoEvent extends TodoEvent {
  final String searchQuery;

  const SearchTodoEvent({required this.searchQuery});
}

class UndoDeleteTodoEvent extends TodoEvent {}

class SetIsSearchingEvent extends TodoEvent {
  final bool isSearching;

  const SetIsSearchingEvent(this.isSearching);
}
