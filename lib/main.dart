import 'package:code_talks_demo/db/todo_model.dart';
import 'package:code_talks_demo/resources/todo_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:code_talks_demo/db/database.dart';

import 'l10n/localization.dart';
import 'resources/lib.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CodeTalks',
      theme: ThemeData(
        brightness: Brightness.light,
        backgroundColor: ColorHelper.getValue(BrandColor.dark),
        primaryColor: ColorHelper.getValue(BrandColor.lila),
        errorColor: ColorHelper.getValue(BrandColor.red),
        highlightColor: ColorHelper.getValue(BrandColor.orange),
        hintColor: Colors.black26,
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        CodeTalksDemoLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('de'),
      ],
      home: const MyHomePage(title: 'Code.Talks Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _titleFieldController = TextEditingController();
  final TextEditingController _descriptionFieldController =
      TextEditingController();
  final List<TodoItem> _todoItems = <TodoItem>[];

  @override
  void initState() {
    super.initState();
    _getTodos();
  }

  Future<void> _addTodo() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Localization.of(context)!.add_todo),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleFieldController,
                decoration: InputDecoration(
                    hintText: Localization.of(context)!.type_todo),
              ),
              TextField(
                controller: _descriptionFieldController,
                decoration: InputDecoration(
                    hintText: Localization.of(context)!.type_descripion),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(Localization.of(context)!.cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(Localization.of(context)!.add),
              onPressed: () {
                Navigator.of(context).pop();
                _addTodoItem(_titleFieldController.text,
                    _descriptionFieldController.text);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _editTodo(Todo todo) async {
    _titleFieldController.text = todo.action;
    _descriptionFieldController.text = todo.description;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Localization.of(context)!.add_todo),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleFieldController,
                decoration: InputDecoration(
                    hintText: Localization.of(context)!.type_todo),
              ),
              TextField(
                controller: _descriptionFieldController,
                decoration: InputDecoration(
                    hintText: Localization.of(context)!.type_descripion),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(Localization.of(context)!.cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(Localization.of(context)!.send),
              onPressed: () {
                Navigator.of(context).pop();
                _editTodoItem(todo, _titleFieldController.text,
                    _descriptionFieldController.text);
              },
            ),
          ],
        );
      },
    );
  }

  void _addTodoItem(String title, String description) async {
    Todo todo = Todo(action: title, description: description, checked: false);
    todo = await DBProvider.db.newTodo(todo);
    setState(() {
      _todoItems.add(TodoItem(
        todo: todo,
        onHandleDelete: _handleDelete,
        onTodoChanged: _handleTodoChange,
        onHandleEdit: _handleEdit,
        l10n: Localization.of(context)!
      ));
    });
    _titleFieldController.clear();
    _descriptionFieldController.clear();
  }

  void _editTodoItem(Todo todo, String title, String description) {
    todo.action = _titleFieldController.text;
    todo.description = _descriptionFieldController.text;
    DBProvider.db.updateTodo(todo);
  }

  void _handleDelete(int index) {
    DBProvider.db.deleteTodo(index);
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  void _handleTodoChange(Todo todo, int index) {
    todo.checked = !todo.checked;
    DBProvider.db.updateTodo(todo);
    setState(() {
      _todoItems[index].todo.checked = todo.checked;
    });
  }

  void _handleEdit(int index) {
    setState(() {
      _todoItems[index].todo.action = '';
      _todoItems[index].todo.description = '';
    });
  }

  void _getTodos() async {
    final List<Todo> todos = await DBProvider.db.getTodos();
    print('_getTodos');
    print(todos);
    setState(() {
      _todoItems.clear();
      for (var todo in todos) {
        _todoItems.add(TodoItem(
          todo: todo,
          onHandleDelete: _handleDelete,
          onTodoChanged: _handleTodoChange,
          onHandleEdit: _handleEdit,
          l10n: Localization.of(context)!));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(padding: const EdgeInsets.all(16), children: _todoItems
          //return TodoItem(index: index, todo: _todos[index], onTodoChanged: _handleTodoChange);

          ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        tooltip: Localization.of(context)!.add_todo,
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
