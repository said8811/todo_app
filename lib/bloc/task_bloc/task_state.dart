part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();
}

class TaskInitial extends TaskState {
  @override
  List<Object> get props => [];
}

class TasksLoadingState extends TaskState {
  @override
  List<Object?> get props => [];
}

class TasksEmptyState extends TaskState {
  @override
  List<Object?> get props => [];
}

class TasksLoadedState extends TaskState {
  final List<TaskModel> tasks;
  final TaskModel? notifyTask;
  const TasksLoadedState({required this.tasks, this.notifyTask});
  @override
  List<Object?> get props => [tasks];
}
