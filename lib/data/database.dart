import 'package:hive/hive.dart';

class TodoDatabase {
  //reference our box
  final _myBox = Hive.box('myBox');

  List todoList = [];

  // run this method when forst time ever open the app

  void createInitialData() {
    List todoList = ['Watch tutorial', false];
  }

// load data from database
  void loadData() {
    todoList = _myBox.get('TODO');
  }

  //update the database

  void updateData() {
    _myBox.put("TODO", todoList);
  }
}
