part of 'todo_bloc.dart';

class TodoState extends Equatable {
  final List<TodoEntity> todoList;
  final List<TodoEntity> displayTodoList;
  final TodoEntity? deletedTodo;
  final bool isSearching;
  const TodoState({
    this.todoList = const [],
    this.displayTodoList = const [],
    this.deletedTodo,
    this.isSearching = false,
  });

  TodoState copyWith({
    List<TodoEntity>? todoList,
    List<TodoEntity>? displayTodoList,
    TodoEntity? deletedTodo,
    bool? isSearching,
  }) {
    return TodoState(
      todoList: todoList ?? this.todoList,
      displayTodoList: displayTodoList ?? this.displayTodoList,
      deletedTodo: deletedTodo ?? this.deletedTodo,
      isSearching: isSearching ?? this.isSearching,
    );
  }

  TodoState clearDeletedTodo() => TodoState(
        todoList: todoList,
        displayTodoList: displayTodoList,
        deletedTodo: null,
        isSearching: isSearching,
      );

  @override
  List<Object?> get props => [
        todoList,
        displayTodoList,
        deletedTodo,
        isSearching,
      ];
}
