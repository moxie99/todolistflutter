import "package:flutter/material.dart";
import 'package:todolistapp/constants/colors.dart';
import 'package:todolistapp/model/todo.dart';

class TodoItem extends StatelessWidget {
  final ToDo todo;
  final onTodoChanged;
  final onTodoDeleted;

  const TodoItem(
      {Key? key,
      required this.todo,
      required this.onTodoChanged,
      required this.onTodoDeleted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        child: ListTile(
            onTap: () {
              onTodoChanged(todo);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            tileColor: Colors.white,
            leading: Icon(
                todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
                color: tdBlue,
                size: 30),
            title: Text(todo.todoTitle ?? "No title",
                style: TextStyle(
                  fontSize: 17,
                  color: tdBlack,
                  decoration: todo.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                )),
            trailing: Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.symmetric(vertical: 12),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: tdRed,
                borderRadius: BorderRadius.circular(5),
              ),
              child: IconButton(
                color: Colors.white,
                iconSize: 20,
                icon: Icon(Icons.delete),
                onPressed: () {
                  onTodoDeleted(todo.id);
                },
              ),
            )));
  }
}
