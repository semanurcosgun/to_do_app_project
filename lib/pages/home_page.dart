import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as DatePicker;
import 'package:flutter_todo_app/constants/constants.dart';
import 'package:flutter_todo_app/data/local_storage.dart';
import 'package:flutter_todo_app/main.dart';
import 'package:flutter_todo_app/models/task_model.dart';
import 'package:flutter_todo_app/widgets/custom_search.dart';
import 'package:flutter_todo_app/widgets/task_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  late List<TaskModel> allTasks;
  late LocalStorage _localStorage;

  @override
  void initState()  {
    super.initState();
    _localStorage=locator<LocalStorage>();
    allTasks=<TaskModel>[];
    _getAllTaskFromDb();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: GestureDetector  (
          onTap:(){_showAddTaskBottomSheet();},
          child: Text('title',style: TextStyle(color:Colors.black,fontSize: 22,fontFamily: "PinyonScript"),).tr()),
        centerTitle: false,
        actions: [
          IconButton(onPressed: (){
            _showSearchPage();
          }, icon: Icon(Icons.search)),
          IconButton(onPressed: (){
          _showAddTaskBottomSheet();
          }, icon:Icon(Icons.add)) 
        ],
      ),
      body: allTasks.isNotEmpty ? ListView.builder(
        itemBuilder:(context, index){
          var listElement=allTasks[index];
          return Dismissible(
            background:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Icon(Icons.delete,color: Colors.grey,),
              Text('remove_task').tr()
            ],),
            key: Key(listElement.id),
            onDismissed: (direction)async{
              allTasks.removeAt(index);
              await _localStorage.deleteTask(task:listElement);
              setState(() {
              });
            },
            child: TaskItem(task: listElement)
          );
        },
        itemCount: allTasks.length,
       ):Center(child: Text('add_task').tr(),),
    );
  }
  void _showAddTaskBottomSheet() {
    showModalBottomSheet(context: context, builder: (context){
      return Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        width: MediaQuery.of(context).size.width,
        child: ListTile(
          autofocus: true ,
          title: TextField(
            style: Constants.getTitleTextStyle(),
            decoration: InputDecoration(
              hintText:  'add_task'.tr(),
              border: InputBorder.none
            ),
            onSubmitted: (value) async {
            Navigator.of(context).pop();
            if(value.length > 3){
               DatePicker.showTimePicker(context: context, initialTime: TimeOfDay.now(),);
               var newAddTask=TaskModel.create(name:  value, createdAt:DateTime.now() );
               allTasks.add(newAddTask);
               await _localStorage.addTask(task:newAddTask);
               setState(() {
                 
               });
            }
            } ,
          ),
        ),
      );
    } ,);
  }
  void _getAllTaskFromDb() async {
    allTasks = await _localStorage.getAllTask();
    setState(() {
      
    });
  }

  void _showSearchPage() async{
    await showSearch(context: context, delegate: CustomSearchDelegate(allTasks: allTasks));
    _getAllTaskFromDb();
  }
}