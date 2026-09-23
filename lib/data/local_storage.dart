import 'package:flutter_todo_app/models/task_model.dart';
import 'package:hive/hive.dart';

// Hangi depolama sistemi kullanılırsa kullanılsın
// bu metotları sağlamak zorunda.
abstract class LocalStorage {
  Future<void> addTask({required TaskModel task});

  Future<TaskModel?> getTask({required String id});

  Future<List<TaskModel>> getAllTask();

  Future<bool> deleteTask({required TaskModel task});

  Future<TaskModel> updateTask({required TaskModel task});
}

class HiveLocalStorage extends LocalStorage {
  late Box<TaskModel> _taskBox;

  HiveLocalStorage() {
    _taskBox = Hive.box<TaskModel>('tasks');
  }

  // Görev ekleme
  @override
  Future<void> addTask({required TaskModel task}) async {
    await _taskBox.put(task.id, task);
  }

  // Görev silme
  @override
  Future<bool> deleteTask({required TaskModel task}) async {
    await _taskBox.delete(task.id);
    return true;
  }

  // Bütün görevleri getirme
  @override
  Future<List<TaskModel>> getAllTask() async {
    List<TaskModel> allTasks = _taskBox.values.toList();

    if (allTasks.isNotEmpty) {
      allTasks.sort(
        (TaskModel a, TaskModel b) =>
            a.createdAt.compareTo(b.createdAt),
      );
    }

    return allTasks;
  }

  // ID'ye göre tek görev getirme
  @override
  Future<TaskModel?> getTask({required String id}) async {
    if (_taskBox.containsKey(id)) {
      return _taskBox.get(id);
    }

    return null;
  }

  // Görev güncelleme
  @override
  Future<TaskModel> updateTask({
    required TaskModel task,
  }) async {
    await task.save();

    return task;
  }
}