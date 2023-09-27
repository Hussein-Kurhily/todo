import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/data/data_base.dart';
import 'package:todo/util/box_dialog.dart';
import 'package:todo/util/custom_box_dialog_editing.dart';
import '../util/to_do_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  final _myBox = Hive.box('myBox') ;
  ToDoDataBase db = ToDoDataBase() ;

  @override
  void initState() {
    if(_myBox.get('TASKLIST') == null){
      db.createInitData() ;
    }else {
      db.loadData();
    }
    super.initState();
  }

  // text controller
   final TextEditingController _controller = TextEditingController();
  final TextEditingController _controllerEditng = TextEditingController();
   // list of tasks


  //  check box was tapped
  VoidCallback? checkBoxChanged(bool val, int index) {
    setState(() {
      db.taskList[index][1] = !db.taskList[index][1] ;
      db.updateDataBase();
    });

  }

   // delete task
   void onDelete(int index) {
     setState(() {
       db.taskList.removeAt(index) ;
       db.updateDataBase();
     });
   }

  // create new Task
   createNewTask() {
    return showDialog(
        context: context,
        builder: (context) {
          return CustomBoxDialog(
            controller: _controller,
            //on save icon pressed
            onSave: onSaveNewTask,
            //on cancel icon pressed
            onCancel:onCancel,
          ) ;
        }
        ) ;
  }
   // on save task
   void onSaveNewTask() {
     setState(() {
       db.taskList.add([_controller.text,false]) ;
       db.updateDataBase();
     });
     _controllerEditng.text = _controller.text ;
     _controller.clear();
     Navigator.of(context).pop() ;
   }
   void onCancel() {
     _controller.clear();
     Navigator.of(context).pop() ;
   }



   // edite task
   editeTask(int index) {
     _controllerEditng.text == db.taskList[index][0] ;
     return showDialog(
         context: context,
         builder: (context) {
           return CustomBoxDialogEditing(
             editcontroller: _controllerEditng,
             //on save icon pressed
             onSave: (){
               setState(() {
                 db.taskList[index][0] = _controllerEditng.text ;
                 db.taskList[index][1] = false ;
                 Navigator.pop(context) ;
                 db.updateDataBase();
               });
               },

             //on cancel icon pressed
             onCancel:onCancel,
           ) ;

         }
     ) ;
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        title:const Text(
          'To Do', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.deepPurple[400],
      ),

      body: ListView.builder(
        itemCount: db.taskList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            editeTask: (context)  => editeTask(index),
            deleteTask: (context) => onDelete(index),
                taskName: db.taskList[index][0],
                taskDone: db.taskList[index][1],
                onCheck: (value) {
                  checkBoxChanged(value!, index);
                }
            );
        },

      ),
      floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
        child:const Icon(Icons.add),
      ),
    );
  }
}
