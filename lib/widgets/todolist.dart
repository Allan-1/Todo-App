import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/models/todo.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  TodoList({Key? key, required this.todos}) : super(key: key);

  final dynamic currentTime = DateFormat.jm().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final todoBox = Hive.box('todos');
    todoBox.watch();

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.58,
      child: todos.isNotEmpty ?  ListView.builder(itemCount: todoBox.length,
          itemBuilder: (BuildContext ctx, index){

        final todoItems = todoBox.getAt(index) as Todo;

        return Card(
          elevation: 4,
          child: ListTile(
            title: Text(todoItems.item, style: const TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text(todoItems.description),
            leading: const Icon(Icons.adjust_rounded),
            trailing: Text(currentTime),
          ),
        );
          }):
          const Center(
            child: Text('Oops Your Todo is Empty',
              style: TextStyle(fontWeight: FontWeight.bold,
                fontSize: 20
              ),),
          )
    );
  }
}