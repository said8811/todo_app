import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/screens/home/states/task_loaded.dart';
import 'package:todo_app/screens/home/states/tasks_empty.dart';
import 'package:todo_app/utils/colors.dart';

import '../../bloc/task_bloc/task_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: MyColors.background_color,
        child: BlocConsumer<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TasksEmptyState) {
              return const EmptyTaskList();
            }
            if (state is TasksLoadedState) {
              return LoadedTaskWidget(
                tasks: state.tasks,
                notifytask: state.notifyTask,
              );
            }
            return const SizedBox();
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}
