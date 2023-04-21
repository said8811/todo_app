import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 6)
class TaskModel extends HiveObject {
  @HiveField(0)
  String task;
  @HiveField(1)
  String category;
  @HiveField(2)
  int color;
  @HiveField(3)
  bool isDone;
  @HiveField(4)
  bool isNotify;
  @HiveField(5)
  String date;
  @HiveField(6)
  int count;

  TaskModel(
      {required this.task,
      required this.category,
      required this.color,
      required this.isDone,
      required this.isNotify,
      required this.date,
      this.count = 0});

  TaskModel copyWith({
    String? task,
    String? category,
    int? color,
    bool? isDone,
    bool? isNotify,
    String? date,
  }) {
    return TaskModel(
        task: task ?? this.task,
        category: category ?? this.category,
        color: color ?? this.color,
        isDone: isDone ?? this.isDone,
        isNotify: isNotify ?? this.isNotify,
        date: date ?? this.date);
  }
}
