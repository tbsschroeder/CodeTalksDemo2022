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
        backgroundColor: ColorHelper.getValue(BrandColor.blue),
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
  late Localization l10n;

  @override
  void initState() {
    super.initState();
    _getTodos();
  }

  Future<void> _addTodoDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(l10n.add_todo),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleFieldController,
                decoration: InputDecoration(hintText: l10n.type_todo),
              ),
              TextField(
                controller: _descriptionFieldController,
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
                _addTodoItem(_titleFieldController.text,
                    _descriptionFieldController.text);
              },
            ),
          ],
        );
      },
    );
  }

  void _addTodoItem(String title, String description) async {
    await DBProvider.db
        .newTodo(Todo(action: title, description: description, checked: false));
    _getTodos();
    _titleFieldController.clear();
    _descriptionFieldController.clear();
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

  FutureBuilder _getTodoList(final BuildContext context) =>
      FutureBuilder<List<Todo>>(
        future: DBProvider.db.getTodos(),
        builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('¯\\_(ツ)_/¯',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black54,
                      fontWeight: FontWeight.w700,
                    )));
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
          onPressed: () {},
          icon: const Icon(Icons.edit_note_outlined),
        ),
        title: Text(widget.title),
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
