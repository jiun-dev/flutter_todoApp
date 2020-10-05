import 'package:flutter/material.dart';
import 'package:flutter_todo/screen/addItem.dart';

void main() => runApp(new TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(title: 'Todo List', home: new TodoList());
  }
}

class TodoList extends StatefulWidget {
  @override
  createState() => new TodoListState();
}

class TodoListState extends State<TodoList> {
  List<String> _todoItems = [];

  Widget _buildToDoList() {
    return ListView.builder(itemBuilder: (context, index) {
      if (index < _todoItems.length) {
        return _buildToDoItem(_todoItems[index], index);
      }
    });
  }

  Widget _buildToDoItem(String todoText, int index) {
    return new ListTile(
      title: Text(todoText),
      onTap: () => _promptRemoveTodoItem(index),
    );
  }

  _addTodoItem(String item) {
    setState(() {
      _todoItems.add(item);
    });
  }

  _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: new Text(' "${_todoItems[index]}" 완료 처리 하시겠습니까?'),
              actions: <Widget>[
                new FlatButton(
                    child: new Text('CANCEL'),
                    onPressed: () => Navigator.of(context).pop()),
                new FlatButton(
                    child: new Text('완료'),
                    onPressed: () {
                      _removeTodoItem(index);
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }

  _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  _navigatorAddItemScreen() async {
    Map results = await Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) {
        return AddItemScreen();
      },
    ));

    if (results != null && results.containsKey("item")) {
      _addTodoItem(results["item"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Todo List')),
      body: _buildToDoList(),
      floatingActionButton: new FloatingActionButton(
          onPressed: _navigatorAddItemScreen,
          tooltip: '추가',
          child: new Icon(Icons.add)),
    );
  }
}
