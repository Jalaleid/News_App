// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/shared/network/remote/dio_helper/dio_helper.dart';
import 'layout/cubit/states.dart';
import 'shared/bloc_observer.dart';
import 'shared/network/local/cachhelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.intit();
  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  runApp(MyApp(isDark!));
}

class MyApp extends StatelessWidget {
  final bool isDark;

  const MyApp(this.isDark, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..getBusiness()..changeAppMode(fromshared: isDark),
      child: BlocConsumer<NewsCubit, NewsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              themeMode: NewsCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  primarySwatch: Colors.deepOrange,
                  scaffoldBackgroundColor: Colors.white,
                  textTheme: const TextTheme(
                      bodyLarge: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),
                  appBarTheme: const AppBarTheme(
                    titleSpacing: 20,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark,
                    ),
                    backgroundColor: Colors.white,
                    titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    elevation: 0,
                    iconTheme: IconThemeData(color: Colors.black),
                  ),
                  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                      selectedItemColor: Colors.deepOrange,
                      unselectedItemColor: Colors.grey,
                      backgroundColor: Colors.white,
                      elevation: 20,
                      type: BottomNavigationBarType.fixed),),
              darkTheme: ThemeData(
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      selectedItemColor: Colors.deepOrange,
                      unselectedItemColor: Colors.grey,
                      backgroundColor: Colors.grey[900],
                      elevation: 20,
                      type: BottomNavigationBarType.fixed),
                  primarySwatch: Colors.deepOrange,
                  floatingActionButtonTheme:
                      const FloatingActionButtonThemeData(
                          backgroundColor: Colors.deepOrange),
                  appBarTheme: AppBarTheme(
                    titleSpacing: 20,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.grey[900],
                      statusBarIconBrightness: Brightness.light,
                    ),
                    backgroundColor: Colors.grey[900],
                    titleTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    elevation: 0,
                    iconTheme: const IconThemeData(color: Colors.white),
                  ),
                  scaffoldBackgroundColor: Colors.grey[900],
                  textTheme: const TextTheme(
                      bodyLarge: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                      ))
                    ),
              home: const NewsLayout(),
            );
          }),
    );
  }
}
