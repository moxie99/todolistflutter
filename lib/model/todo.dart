class ToDo {
  String? todoTitle;
  String? id;
  bool isDone;

  ToDo({
    required this.todoTitle,
    required this.id,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(
        todoTitle: 'Give a token to the homeless man',
        id: '1',
        isDone: true,
      ),
      ToDo(
        todoTitle: 'Visit Grandma',
        id: '2',
        isDone: false,
      ),
      ToDo(
        todoTitle: 'Buy Groceries while coming',
        id: '3',
      ),
      ToDo(
        todoTitle: 'Exercise Daily',
        id: '4',
      ),
      ToDo(
        todoTitle: 'Jog 10 kilometers',
        id: '5',
        isDone: true,
      ),
    ];
  }
}
