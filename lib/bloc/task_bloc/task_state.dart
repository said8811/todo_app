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
  // TODO: implement props
  List<Object?> get props => [];
}

class TasksEmptyState extends TaskState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TasksLoadedState extends TaskState {
  final List<TaskModel> tasks;
  final TaskModel? notifyTask;
  TasksLoadedState({required this.tasks, this.notifyTask});
  @override
  // TODO: implement props
  List<Object?> get props => [tasks];
}
