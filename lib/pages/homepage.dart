import 'package:exercise2_app/data/database.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'components/dialogbox.dart';
import 'components/todotile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _TodoPageState();
}

class _TodoPageState extends State<HomePage> {
  TextEditingController _controller = TextEditingController();

  TodoDatabase db = TodoDatabase();

  @override
  void initState() {
    //first time when open the app/it create default data

    if (_myBox.get('TODO') == null) {
      db.createInitialData();
    } else {
      //already exist data
      db.loadData();
    }

    super.initState();
  }

  //to reference hive box

  final _myBox = Hive.box('myBox');

  //dummy data list
  // List todoList = [
  //   ['WATCH TUT', false],
  //   ['run marathon', false]
  // ];
// check box was tapped
  void tapCheckBox(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateData();
  }

//save a task
  void saveNewTask() {
    setState(() {
      db.todoList.add(
        [_controller.text, false],
      );
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }

//create a task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: Navigator.of(context).pop,
          );
        });
    db.updateData();
  }

  //delete task

  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        title: Center(
          child: Text('TO DO 😼',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        // to create new task

        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) => TodoTile(
          taskName: db.todoList[index][0],
          taskCompleted: db.todoList[index][1],
          onChanged: (value) => tapCheckBox(value, index),
          deleteTask: (context) => deleteTask(index),
        ),
      ),
    );
  }
}
