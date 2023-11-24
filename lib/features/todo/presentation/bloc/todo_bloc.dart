import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prova_luis_honorato/features/todo/domain/entities/todo_entity.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState()) {
    on<CreateTodoEvent>((event, emit) {
      final newTodoList = [...state.todoList];
      newTodoList.add(
        TodoEntity(
          id: state.todoList.length + 1,
          title: event.todoTitle,
          isCompleted: false,
        ),
      );
      emit(
        state.copyWith(
          todoList: newTodoList,
          displayTodoList: newTodoList,
        ),
      );
    });

    on<UpdateTodoEvent>((event, emit) {
      final newTodoList = [...state.todoList];

      final todoIndex = newTodoList.indexWhere(
        (element) => element.id == event.todoEntity.id,
      );

      newTodoList.removeAt(todoIndex);
      newTodoList.insert(todoIndex, event.todoEntity);

      emit(state.copyWith(
        todoList: newTodoList,
        displayTodoList: newTodoList,
      ));
    });

    on<DeleteTodoEvent>((event, emit) {
      emit(state.copyWith(deletedTodo: event.todoEntity));
      final newTodoList = [...state.todoList];

      final todoIndex = newTodoList.indexWhere(
        (element) => element.id == event.todoEntity.id,
      );
      newTodoList.removeAt(todoIndex);

      emit(state.copyWith(
        todoList: newTodoList,
        displayTodoList: newTodoList,
      ));
    });

    on<UndoDeleteTodoEvent>((event, emit) {
      final newTodoList = [...state.todoList];

      final todoIndex = newTodoList.indexWhere(
        (element) => element.id == state.deletedTodo!.id - 1,
      );
      newTodoList.insert(todoIndex + 1, state.deletedTodo!);

      emit(state.copyWith(
        todoList: newTodoList,
        displayTodoList: newTodoList,
      ));
      emit(state.clearDeletedTodo());
    });

    on<SetIsSearchingEvent>((event, emit) {
      if (event.isSearching != state.isSearching) {
        emit(state.copyWith(
          isSearching: event.isSearching,
        ));
      }
    });

    on<SearchTodoEvent>((event, emit) {
      if (event.searchQuery == '[true]') {
        emit(state.copyWith(
          displayTodoList:
              state.todoList.where((todo) => todo.isCompleted).toList(),
        ));
      } else if (event.searchQuery == '[false]') {
        emit(state.copyWith(
          displayTodoList:
              state.todoList.where((todo) => !todo.isCompleted).toList(),
        ));
      } else {
        emit(state.copyWith(
          displayTodoList: state.todoList
              .where((todo) => todo.title.contains(event.searchQuery))
              .toList(),
        ));
      }
    });
  }
}
