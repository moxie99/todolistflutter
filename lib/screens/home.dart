import 'package:flutter/material.dart';
import 'package:todolistapp/constants/colors.dart';
import 'package:todolistapp/model/todo.dart';
import 'package:todolistapp/widget/todo_item.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: buildAppbar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(children: [
              searchBox(),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 50, bottom: 20),
                      child: Text("All Todos",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    for (ToDo todoo in _foundToDo.reversed)
                      TodoItem(
                          todo: todoo,
                          onTodoChanged: _handleTodoChange,
                          onTodoDeleted: _deleteTodoItem),
                  ],
                ),
              )
            ]),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Row(children: [
                Expanded(
                    child: Container(
                        margin:
                            EdgeInsets.only(bottom: 20, right: 20, left: 20),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 10.0,
                              spreadRadius: 0.0,
                            )
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                            controller: todoController,
                            decoration: InputDecoration(
                              hintText: "Add a new todo item",
                              border: InputBorder.none,
                            )))),
                Container(
                  margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                  child: ElevatedButton(
                    child: Text("+", style: TextStyle(fontSize: 30)),
                    onPressed: () {
                      _addTodoitem(todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: tdBlue,
                        minimumSize: Size(60, 60),
                        elevation: 10),
                  ),
                ),
              ]))
        ],
      ),
    );
  }

  void _handleTodoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteTodoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addTodoitem(String toDo) {
    setState(() {
      todosList.add(ToDo(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        todoTitle: toDo,
      ));
    });
    todoController.clear();
  }

  void _runFilter(String enteredKeyWord) {
    List<ToDo> results = [];
    if (enteredKeyWord.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) => item.todoTitle!
              .toLowerCase()
              .contains(enteredKeyWord.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(Icons.search, size: 20, color: tdBlack),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            maxWidth: 20,
          ),
          border: InputBorder.none,
          hintText: "Search",
        ),
      ),
    );
  }

  AppBar buildAppbar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(
          Icons.menu,
          color: tdBlack,
          size: 30,
        ),
        Container(
            height: 40,
            width: 40,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset("assets/images/avatar.jpeg")))
      ]),
    );
  }
}
