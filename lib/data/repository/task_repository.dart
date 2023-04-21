import 'package:todo_app/data/models/task_model.dart';
import 'package:todo_app/service/local_database.dart';

class TaskRepository {
  LocalDataBase dataBase;
  TaskRepository({required this.dataBase});

  Future<List<TaskModel>> getTasks() async {
    await dataBase.init();
    return dataBase.getTasks();
  }

  void addTask(TaskModel task) {
    dataBase.addTask(task);
  }

  void deleteTask(TaskModel task) {
    dataBase.removeTask(task);
  }

  Future<void> updateTask(TaskModel task) async {
    await dataBase.updateTask(task);
  }
}
