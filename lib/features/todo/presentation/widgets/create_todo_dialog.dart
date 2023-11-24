import 'package:flutter/material.dart';
import 'package:prova_luis_honorato/features/todo/domain/entities/todo_entity.dart';
import 'package:prova_luis_honorato/features/todo/presentation/bloc/todo_bloc.dart';

class CreateTodoDialog extends StatefulWidget {
  final TodoBloc todoBloc;
  final bool isEditing;
  final TodoEntity? editableTodo;
  const CreateTodoDialog({
    super.key,
    required this.todoBloc,
    this.isEditing = false,
    this.editableTodo,
  }) : assert((!isEditing && editableTodo == null) ||
            (isEditing && editableTodo != null));

  @override
  State<CreateTodoDialog> createState() => _CreateTodoDialogState();
}

class _CreateTodoDialogState extends State<CreateTodoDialog> {
  late final TextEditingController titleControler;

  @override
  void initState() {
    super.initState();
    titleControler = TextEditingController();
    if (widget.isEditing) {
      titleControler.text = widget.editableTodo!.title;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.isEditing ? 'Editar Todo' : 'Criar ToDo'),
      content: TextFormField(
        controller: titleControler,
        decoration: const InputDecoration(
          label: Text('Digite o título do ToDo'),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        OutlinedButton(
          onPressed: () {
            widget.isEditing
                ? widget.todoBloc.add(UpdateTodoEvent(
                    todoEntity: TodoEntity(
                    id: widget.editableTodo!.id,
                    title: titleControler.text,
                    isCompleted: widget.editableTodo!.isCompleted,
                  )))
                : widget.todoBloc.add(
                    CreateTodoEvent(
                      todoTitle: titleControler.text,
                    ),
                  );
            Navigator.of(context).pop();
          },
          child: Text(widget.isEditing ? 'Salvar' : 'Criar'),
        ),
      ],
    );
  }
}
