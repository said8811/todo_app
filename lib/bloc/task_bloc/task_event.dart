part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
}

class LoadTasksEvent extends TaskEvent {
  @override
  List<Object?> get props => [];
}

class AddTaskEvent extends TaskEvent {
  final TaskModel task;
  const AddTaskEvent({required this.task});

  @override
  List<Object?> get props => [task];
}

class DeleteTaskEvent extends TaskEvent {
  final TaskModel task;
  const DeleteTaskEvent({required this.task});

  @override
  List<Object?> get props => [task];
}

class UpDateTaskEvent extends TaskEvent {
  final TaskModel task;
  const UpDateTaskEvent({required this.task});

  @override
  List<Object?> get props => [task];
}
