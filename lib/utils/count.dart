import 'package:todo_app/data/models/task_model.dart';

int count(List<TaskModel> list, String category) {
  int count = 0;
  list.forEach((element) {
    if (element.category == category) {
      count++;
    }
  });
  return count;
}
