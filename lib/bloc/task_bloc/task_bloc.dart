import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/data/models/task_model.dart';
import 'package:todo_app/data/models/tasks_category_model.dart';
import 'package:todo_app/service/local_database.dart';
import 'package:todo_app/utils/count.dart';

import '../../data/repository/task_repository.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;
  TaskModel? notifyTask;
  TaskBloc({required this.repository}) : super(TaskInitial()) {
    on<LoadTasksEvent>((event, emit) async {
      emit(TasksLoadingState());
      final tasks = await repository.getTasks();
      if (tasks.isNotEmpty) {
        tasks.forEach((e) {
          TaskCategory.counts[e.category] = count(tasks, e.category);
        });
        emit(TasksLoadedState(tasks: tasks, notifyTask: notifyTask));
      } else {
        emit(TasksEmptyState());
      }
    });
    on<AddTaskEvent>((event, emit) async {
      repository.addTask(event.task);
      final tasks = await repository.getTasks();
      emit(TasksLoadedState(tasks: tasks, notifyTask: notifyTask));
    });
    on<DeleteTaskEvent>((event, emit) async {
      repository.deleteTask(event.task);
      final tasks = await repository.getTasks();
      emit(TasksLoadedState(tasks: tasks, notifyTask: notifyTask));
    });
    on<UpDateTaskEvent>((event, emit) async {
      await repository.updateTask(event.task);
      final tasks = await repository.getTasks();
      emit(TasksLoadedState(
          tasks: tasks,
          notifyTask: event.task.isNotify ? event.task : notifyTask));
    });
  }
}
