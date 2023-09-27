import 'package:hive/hive.dart';

class ToDoDataBase {
  List taskList = [] ;
  // reference our box
  var _myBox = Hive.box('myBox') ;

  // Run this method if this is first time opening the app
  createInitData() {
    taskList = [
      ["Create To Do Task", true],
    ] ;
  }

  // load the data from the database
  loadData() {
    taskList = _myBox.get("TASKLIST") ;
  }
  // update DataBase
  updateDataBase() {
    _myBox.put("TASKLIST", taskList) ;
  }
}