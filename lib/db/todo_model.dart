import 'dart:convert';

Todo todoFromJson(String str) {
  final jsonData = json.decode(str);
  return Todo.fromMap(jsonData);
}

String todoToJson(Todo data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Todo {
  int id;
  String action;
  String description;
  bool checked;

  Todo({
    this.id = 0,
    required this.action,
    required this.description,
    required this.checked,
  });

  setId(int id){
    this.id = id;
  }

  factory Todo.fromMap(Map<String, dynamic> json) => Todo(
    id: json['id'],
    action: json['action'],
    description: json['description'],
    checked: json['checked'] == 0 ? false : true,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'action': action,
    'description': description,
    'checked': checked,
  };
}
