import 'package:code_talks_demo/db/todo_model.dart' show Todo;
import 'package:code_talks_demo/resources/todo_item.dart';
import 'package:flutter/material.dart';
import 'package:code_talks_demo/db/database.dart';

import 'l10n/localization.dart';
import 'resources/lib.dart';

const String empty = '-empty-';

class MyTodoPage extends StatefulWidget {
  const MyTodoPage({Key? key}) : super(key: key);

  @override
  State<MyTodoPage> createState() => _MyTodoPageState();
}

class _MyTodoPageState extends State<MyTodoPage> {
  final TextEditingController _titleFieldCtr = TextEditingController();
  final TextEditingController _descriptionFieldCtr = TextEditingController();
  final List<TodoItem> _todoItems = <TodoItem>[];
  late Localization l10n;

  @override
  void initState() {
    super.initState();
    _getTodos();
  }

  Future<void> _addTodoDialog() async {
    //showModalBottomSheet
    //shape: const RoundedRectangleBorder(borderRadius:
    //BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(l10n.add_todo),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleFieldCtr,
                decoration: InputDecoration(hintText: l10n.type_todo),
              ),
              TextField(
                controller: _descriptionFieldCtr,
                decoration: InputDecoration(hintText: l10n.type_descripion),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(l10n.cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(l10n.add),
              onPressed: () {
                Navigator.of(context).pop();
                _addTodoItem(_titleFieldCtr.text, _descriptionFieldCtr.text);
              },
            ),
          ],
        );
      },
    );
  }

  void _addTodoItem(String title, String description) async {
    if (title.isEmpty) {
      title = empty;
    }
    if (description.isEmpty) {
      description = empty;
    }

    await DBProvider.db
        .newTodo(Todo(action: title, description: description, checked: false));
    _getTodos();
    _titleFieldCtr.clear();
    _descriptionFieldCtr.clear();
    showToast(l10n.todo_added);
  }

  void _handleDelete(TodoItem item, int index) {
    DBProvider.db.deleteTodo(item.todo.id);
    setState(() => _todoItems.removeAt(index));
    _getTodos();
    showToast(l10n.todo_deleted);
  }

  void _handleTodoChange(TodoItem item, int index) {
    item.todo.checked = !item.todo.checked;
    DBProvider.db.updateTodo(item.todo);
    setState(() => _todoItems[index].todo.checked = item.todo.checked);
    showToast(item.todo.checked ? l10n.todo_checked : l10n.todo_unchecked);
  }

  void _getTodos() async {
    final List<Todo> todos = await DBProvider.db.getTodos();
    setState(() {
      _todoItems.clear();
      todos.asMap().forEach((index, todo) => _todoItems.add(TodoItem(
          todo: todo,
          index: index,
          onHandleDelete: _handleDelete,
          onTodoChanged: _handleTodoChange,
          l10n: l10n,
          key: UniqueKey())));
    });
  }

  Center _getEmptyCenterText(BuildContext context) {
    return Center(
        child: Text('¯\\_(ツ)_/¯',
            style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.tealAccent
                  : Colors.black54,
              fontWeight: FontWeight.w700,
            )));
  }

  FutureBuilder _getTodoList(final BuildContext context) =>
      FutureBuilder<List<Todo>>(
        future: DBProvider.db.getTodos(),
        builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return _getEmptyCenterText(context);
          }
          return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                Todo todo = snapshot.data![index];
                return TodoItem(
                    todo: todo,
                    index: index,
                    onHandleDelete: _handleDelete,
                    onTodoChanged: _handleTodoChange,
                    l10n: l10n,
                    key: UniqueKey());
              });
        },
      );

  @override
  Widget build(BuildContext context) {
    l10n = Localization.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            showToast(getMadeWithLove());
          },
          icon: const Icon(Icons.edit_note_outlined),
        ),
        title: const Text('Code.Talks Demo'),
        backgroundColor: Colors.blueAccent,
      ),
      body: _getTodoList(context),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodoDialog,
        tooltip: l10n.add_todo,
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
