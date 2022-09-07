import 'package:code_talks_demo/db/todo_model.dart';
import 'package:code_talks_demo/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'lib.dart';

class TodoItem extends StatelessWidget {
  TodoItem({
    required this.todo,
    required this.index,
    required this.onTodoChanged,
    required this.onHandleDelete,
    required this.l10n,
    required this.key,
  }) : super(key: ObjectKey(todo));

  final Todo todo;

  // ignore: prefer_typing_uninitialized_variables
  final int index;

  // ignore: prefer_typing_uninitialized_variables
  final onTodoChanged;

  // ignore: prefer_typing_uninitialized_variables
  final onHandleDelete;

  // ignore: prefer_typing_uninitialized_variables
  final l10n;

  // ignore: prefer_typing_uninitialized_variables
  final key;

  TextStyle? _getTextStyle() {
    if (!todo.checked) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  CircleAvatar? getAvatar() {
    Color color = ColorHelper.getByInt(index);
    return CircleAvatar(
        foregroundColor: Color.fromRGBO(
            color.red, color.green, color.blue, todo.checked ? 0.5 : 1.0),
        backgroundColor:
            todo.checked ? Colors.black54 : const Color(0xFF051428),
        child:
            Text(todo.action == EMPTY ? '?' : todo.action[0].toUpperCase()));
  }

  SlidableAction _getDeleteSlidable() {
    return SlidableAction(
      onPressed: (_) {
        onHandleDelete(this, index);
      },
      backgroundColor: const Color(0xFFFE4A49),
      foregroundColor: Colors.white,
      icon: Icons.delete,
      label: l10n.delete,
    );
  }

  SlidableAction _getDoneSlidable() {
    return SlidableAction(
      onPressed: (_) {
        onTodoChanged(this, index);
      },
      backgroundColor: const Color(0xFF7BC043),
      foregroundColor: Colors.white,
      icon: todo.checked ? Icons.note_add_outlined : Icons.check,
      label: todo.checked ? l10n.undone : l10n.done,
    );
  }

  ListTile _getListTile() {
    return ListTile(
      onTap: () {
        onTodoChanged(this, index);
      },
      leading: getAvatar(),
      title: Text(todo.action,
          style: _getTextStyle()),
      subtitle: Text(todo.description,
          style: _getTextStyle()),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color color = ColorHelper.getByInt(index);
    return Card(
      color: Color.fromRGBO(
          color.red, color.green, color.blue, todo.checked ? 0.2 : 0.8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Slidable(
            key: UniqueKey(),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [_getDeleteSlidable()],
            ),
            endActionPane: ActionPane(
              motion: ScrollMotion(),
              children: [
                _getDoneSlidable(),
              ],
            ),
            child: _getListTile(),
          ),
        ],
      ),
    );
  }
}
