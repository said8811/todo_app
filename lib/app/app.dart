import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/bloc/task_bloc.dart';
import 'package:todo_app/service/local_database.dart';
import '../data/repository/task_repository.dart';
import '../screens/app_router.dart';
import '../screens/splash/splash.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              TaskBloc(repository: TaskRepository(dataBase: LocalDataBase()))
                ..add(LoadTasksEvent()),
        )
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: RouteName.splash,
            onGenerateRoute: AppRoutes.generateRoute),
      ),
    );
  }
}
