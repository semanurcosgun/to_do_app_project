import 'package:flutter/material.dart';
import 'package:flutter_todo_app/data/local_storage.dart';
import 'package:flutter_todo_app/main.dart';
import 'package:flutter_todo_app/models/task_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter_todo_app/constants/constants.dart';

class TaskItem extends StatefulWidget {
  final TaskModel task;

  const TaskItem({super.key, required this.task});

  @override
  State<TaskItem> createState() => _TaskItemState();
}
class _TaskItemState extends State<TaskItem> {
  TextEditingController taskNameController = TextEditingController();
  late LocalStorage _localStorage;
  @override
  void initState() {
    super.initState();
    _localStorage=locator<LocalStorage>();
    print('init state tetiklendi');

  }
  @override
  Widget build(BuildContext context) {
    taskNameController.text = widget.task.name;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: .2), blurRadius: 10),
        ],
      ),
      child: ListTile(
        leading: GestureDetector(
          onTap: () {
            widget.task.isCompleted = !widget.task.isCompleted;
            _localStorage.updateTask(task:widget.task);
            setState(() {});
          },
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: widget.task.isCompleted ? Colors.green : Colors.red,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 0.8),
            ),
            child: const Icon(Icons.check, color: Colors.white, size: 18),
          ),
        ),
        title: widget.task.isCompleted
            ? Text(
                widget.task.name,
                style:Constants.completedTaskTextStyle() ,
              )
            : TextField(
                style: Constants.taskTextStyle(),
                controller: taskNameController,
                minLines: 1,
                maxLines: null,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(border: InputBorder.none),
                onSubmitted: (yeniDeger) {
                  if (yeniDeger.length > 3) {
                    widget.task.name = yeniDeger;
                  }
                },
              ),
        trailing: Text(
          DateFormat("hh:mm a").format(widget.task.createdAt),
          style:Constants.taskTimeTextStyle(),
        ),
      ),
    );
  }
}
