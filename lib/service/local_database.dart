import 'package:hive/hive.dart';
import 'package:todo_app/data/models/task_model.dart';

class LocalDataBase {
  late Box<TaskModel> _tasks;

  Future<void> init() async {
    if (!Hive.isAdapterRegistered(6)) {
      Hive.registerAdapter(TaskModelAdapter());
    }
    _tasks = await Hive.openBox<TaskModel>("tasks");
  }

  List<TaskModel> getTasks() {
    final tasks = _tasks.values.toList();
    return tasks.toList();
  }

  void addTask(final TaskModel task) {
    _tasks.add(task);
  }

  Future<void> removeTask(final TaskModel task) async {
    final taskToRemove =
        _tasks.values.firstWhere((element) => element.task == task.task);
    await taskToRemove.delete();
  }

  Future<void> updateTask(final TaskModel task) async {
    final taskToUpdate =
        _tasks.values.firstWhere((element) => element.date == task.date);
    final index = taskToUpdate.key as int;
    await _tasks.put(index, task);
  }
}
