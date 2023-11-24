import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prova_luis_honorato/features/theme/theme_colors.dart';
import 'package:prova_luis_honorato/features/todo/domain/entities/todo_entity.dart';
import 'package:prova_luis_honorato/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:prova_luis_honorato/features/todo/presentation/widgets/create_todo_dialog.dart';
import 'package:prova_luis_honorato/features/utils/generic_error_page.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late final TextEditingController searchController;
  late final FocusNode searchFocusNode;
  late final TodoBloc todoBloc;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchFocusNode = FocusNode();
    todoBloc = TodoBloc();
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<TodoBloc>.value(
      value: todoBloc,
      child: BlocBuilder<TodoBloc, TodoState>(
        bloc: todoBloc,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Todo'),
              centerTitle: false,
              actions: [
                Stack(
                  children: [
                    Visibility(
                      visible: !state.isSearching,
                      child: IconButton(
                        onPressed: () {
                          todoBloc.add(
                            const SetIsSearchingEvent(true),
                          );
                          if (searchFocusNode.canRequestFocus) {
                            searchFocusNode.requestFocus();
                          }
                        },
                        icon: const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Icon(
                            Icons.search,
                            color: ThemeColors.primary,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: state.isSearching,
                      child: Container(
                        width: MediaQuery.sizeOf(context).width / 1.8,
                        padding: const EdgeInsets.all(8),
                        child: TextFormField(
                          controller: searchController,
                          onChanged: (value) => todoBloc.add(
                            SearchTodoEvent(searchQuery: value.toLowerCase()),
                          ),
                          decoration: InputDecoration(
                            label: const Text('Buscar'),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: 10,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                todoBloc.add(
                                  const SetIsSearchingEvent(false),
                                );
                              },
                              icon: const Icon(
                                Icons.search_off,
                                color: ThemeColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => _showDialog(
                    context,
                    CreateTodoDialog(todoBloc: todoBloc),
                  ),
                  icon: const Icon(
                    Icons.add,
                    color: ThemeColors.primary,
                  ),
                )
              ],
            ),
            body: Builder(
              builder: (context) {
                if (state.todoList.isEmpty) {
                  return const GenericErrorPage(
                      errorMessage: 'Nada por aqui...');
                }
                return ListView.builder(
                  itemCount: state.displayTodoList.length,
                  itemBuilder: (context, index) {
                    final todo = state.displayTodoList[index];
                    return Dismissible(
                      key: Key(todo.id.toString()),
                      confirmDismiss: (direction) => _onDismiss(
                        direction,
                        todo,
                      ),
                      background: Container(
                        color: ThemeColors.grayBlue,
                        padding: const EdgeInsets.only(left: 15),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(Icons.edit_outlined),
                        ),
                      ),
                      secondaryBackground: Container(
                        color: ThemeColors.redDanger,
                        padding: const EdgeInsets.only(right: 15),
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.delete),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CheckboxListTile(
                          title: Text(
                            todo.title,
                          ),
                          onChanged: (value) {
                            todoBloc.add(
                              UpdateTodoEvent(
                                todoEntity: todo.copyWith(
                                  isCompleted: !todo.isCompleted,
                                ),
                              ),
                            );
                          },
                          value: todo.isCompleted,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _showDialog(
    BuildContext context,
    Widget dialog,
  ) {
    showDialog(
      context: context,
      builder: (_) => dialog,
    );
  }

  Future<bool> _onDismiss(
    DismissDirection direction,
    TodoEntity todo,
  ) {
    if (direction == DismissDirection.startToEnd) {
      _showDialog(
          context,
          CreateTodoDialog(
            todoBloc: todoBloc,
            editableTodo: todo,
            isEditing: true,
          ));
      return Future(() => false);
    }
    todoBloc.add(DeleteTodoEvent(todoEntity: todo));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Todo Deletado'),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () => todoBloc.add(UndoDeleteTodoEvent()),
        ),
      ),
    );
    return Future(() => true);
  }
}
