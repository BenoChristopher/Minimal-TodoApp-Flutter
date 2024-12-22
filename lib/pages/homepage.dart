import 'package:exercise2_app/data/database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'components/dateandtime.dart';
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

  void taskDone() {}

  var date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Datetimemonth(),
        // title: Center(
        //   child: Text(date.toString(),
        //       style: TextStyle(fontWeight: FontWeight.bold)),
        // ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black87,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

        onPressed: createNewTask,
        // to create new task

        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Stack(children: [
        // Positioned.fill(
        //     child: Image.asset(
        //   'assets/v904-nunny-012-f.jpg',
        //   fit: BoxFit.fill,
        // )),

        Positioned.fill(
            child: Image.asset(
          'assets/vecteezy_purple-gradient-shade_21103429.png',
          fit: BoxFit.fitHeight,
        )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Divider between active and completed tasks
            Divider(
              thickness: 2,
              color: Colors.grey[300],
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 40,
                top: 10,
              ),
              child: Text('ToDo',
                  style:
                      GoogleFonts.nunito(textStyle: TextStyle(fontSize: 25))),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: db.todoList.length,
                itemBuilder: (context, index) => TodoTile(
                  taskName: db.todoList[index][0],
                  taskCompleted: db.todoList[index][1],
                  onChanged: (value) => tapCheckBox(value, index),
                  deleteTask: (context) => deleteTask(index),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
