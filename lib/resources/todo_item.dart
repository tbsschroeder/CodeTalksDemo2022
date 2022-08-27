import 'package:code_talks_demo/db/todo_model.dart';
import 'package:flutter/material.dart';
import 'lib.dart';

class TodoItem extends StatelessWidget {
  TodoItem({
    required this.todo,
    required this.onTodoChanged,
    required this.onHandleDelete,
    required this.onHandleEdit,
    required this.l10n,
  }) : super(key: ObjectKey(todo));

  final Todo todo;
  // ignore: prefer_typing_uninitialized_variables
  final onTodoChanged;
  // ignore: prefer_typing_uninitialized_variables
  final onHandleDelete;
  // ignore: prefer_typing_uninitialized_variables
  final onHandleEdit;
  // ignore: prefer_typing_uninitialized_variables
  final l10n;

  TextStyle? _getTextStyle() {
    if (!todo.checked) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  CircleAvatar? getAvatar() {
    Color color = ColorHelper.getByInt(todo.id + 2);
    return CircleAvatar(
        foregroundColor: Color.fromRGBO(color.red, color.green, color.blue, todo.checked ? 0.5 : 1.0),
        backgroundColor: todo.checked ? Colors.black54 : ColorHelper.getValue(BrandColor.dark),
        child: Text(todo.action.length > 0 ? todo.action[0] : '?'));
  }

  @override
  Widget build(BuildContext context) {
    Color color = ColorHelper.getByInt(todo.id + 2);
    return Card(
      color: Color.fromRGBO(color.red, color.green, color.blue, todo.checked ? 0.2 : 0.8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: getAvatar(),
            title: Text(todo.action.length > 0 ? todo.action : '-empty-', style: _getTextStyle()),
            subtitle: Text(todo.description.length > 0 ? todo.description : '-empty-', style: _getTextStyle()),
          ),
          // Use this for a row an the card layout
          /*
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: Text(l10n.delete),
                onPressed: () {onHandleDelete();},
              ),
              const SizedBox(width: 8),
              TextButton(
                child: Text(l10n.edit),
                onPressed: () {onHandleEdit();},
              ),
              const SizedBox(width: 8),
              TextButton(
                child: Text(todo.checked ? l10n.undone : l10n.done),
                onPressed: () {onTodoChanged();},
              ),
              const SizedBox(width: 8),
            ],
          ),
          */
        ],
      ),
    );
  }
}
