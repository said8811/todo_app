part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
}

class LoadTasksEvent extends TaskEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddTaskEvent extends TaskEvent {
  TaskModel task;
  AddTaskEvent({required this.task});

  @override
  // TODO: implement props
  List<Object?> get props => [task];
}

class DeleteTaskEvent extends TaskEvent {
  TaskModel task;
  DeleteTaskEvent({required this.task});

  @override
  // TODO: implement props
  List<Object?> get props => [task];
}

class UpDateTaskEvent extends TaskEvent {
  TaskModel task;
  UpDateTaskEvent({required this.task});

  @override
  // TODO: implement props
  List<Object?> get props => [task];
}
