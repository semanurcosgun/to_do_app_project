import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as date_picker;
import 'package:flutter_todo_app/constants/constants.dart';
import 'package:flutter_todo_app/data/local_storage.dart';
import 'package:flutter_todo_app/main.dart';
import 'package:flutter_todo_app/models/task_model.dart';
import 'package:flutter_todo_app/pages/detail_page.dart';
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
  void initState() {
    super.initState();
    _localStorage = locator<LocalStorage>();
    allTasks = <TaskModel>[];
    _getAllTaskFromDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            _showAddTaskBottomSheet();
          },
          child: Text(
            'title',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontFamily: "PinyonScript",
            ),
          ).tr(),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              _showSearchPage();
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              _showAddTaskBottomSheet();
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),

      body: allTasks.isNotEmpty
          ? ListView.builder(
              itemCount: allTasks.length,
              itemBuilder: (context, index) {
                var listElement = allTasks[index];
                return Dismissible(
                  key: Key(listElement.id),
                  // sağa kaydırdığımızda görğnğcek
                  background: Container(
                    color: Colors.grey.shade200,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 25),
                    child: Icon(Icons.edit, color: Colors.black),
                  ),

                  // sola kaydırdığımızda görğnecek
                  secondaryBackground: Container(
                    color: Colors.red.shade100,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 25),
                    child: Icon(Icons.delete, color: Colors.red),
                  ),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(task: listElement),
                        ),
                      );

                      if (!mounted) return false;

                      _getAllTaskFromDb();

                      return false;
                    }

                    if (direction == DismissDirection.endToStart) {
                      return true;
                    }

                    return false;
                  },

                  onDismissed: (direction) async {
                    allTasks.removeAt(index);
                    await _localStorage.deleteTask(task: listElement);

                    setState(() {});
                  },

                  child: TaskItem(task: listElement),
                );
              },
            )
          : Center(child: Text('add_task').tr()),
    );
  }

  void _showAddTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          width: MediaQuery.of(context).size.width,
          child: ListTile(
            autofocus: true,
            title: TextField(
              style: Constants.getTitleTextStyle(),
              decoration: InputDecoration(
                hintText: 'Add Task'.tr(),
                hintStyle: TextStyle(color: Colors.black),
                border: InputBorder.none,
              ),
              onSubmitted: (value) async {
                Navigator.of(context).pop();

                if (value.length > 3) {
                  date_picker.showTimePicker(
                    context: context,
                    initialTime: date_picker.TimeOfDay.now(),
                  );

                  var newAddTask = TaskModel.create(
                    name: value,
                    createdAt: DateTime.now(),
                  );

                  allTasks.add(newAddTask);

                  await _localStorage.addTask(task: newAddTask);

                  setState(() {});
                }
              },
            ),
          ),
        );
      },
    );
  }

  void _getAllTaskFromDb() async {
    allTasks = await _localStorage.getAllTask();

    setState(() {});
  }

  void _showSearchPage() async {
    await showSearch(
      context: context,
      delegate: CustomSearchDelegate(allTasks: allTasks),
    );

    _getAllTaskFromDb();
  }
}
