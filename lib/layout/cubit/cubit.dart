// ignore_for_file: non_constant_identifier_names, avoid_print, avoid_types_as_parameter_names


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sport_screen.dart';
import 'package:news_app/shared/network/remote/dio_helper/dio_helper.dart';

import '../../shared/network/local/cachhelper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
  ];

  List<Widget> Screens = [
    const BusinessScreen(),
    const SportScreen(),
    const ScienceScreen(),
  ];

  void changeBottomNavBar(index) {
    currentIndex = index;
    if (index == 1) {
      getSports();
    } else if (index == 2) {
      getScince();
    }
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    if (business.isEmpty) {
      emit(NewBusinessLoadingssState());
      DioHelper.getData(
        // url: 'v2/top-headlines',
        // query: {
        //   'country': 'eg',
        //   'category': 'business',
        //   'apikey': '65f7f556ec76449fa7dc7c0069f040ca'
        // },

        url: 'v4/top-headlines',
        query: {
          'category' : 'business',
          'lang' : 'en',
          'country' : 'us',
          'max' : '10',
          'apikey' : '79bf7be85e0500a4c69b8220dae6be33'
        }
      ).then((value) {
        //print(value.data['articles'][0]['title']);
        business = value.data['articles'];
        print(business[0]['title']);

        emit(NewBusinessSuccessState());
      }).catchError((Error) {
        print(Error.toString());
        emit(NewBusinessErrorState(Error.toString()));
      });
    } else {
      emit(NewBusinessSuccessState());
    }
  }

  List<dynamic> sports = [];
  void getSports() {
    if (sports.isEmpty) {
      emit(NewSportsLoadingssState());
      DioHelper.getData(
        // url: 'v2/top-headlines',
        // query: {
        //   'country': 'eg',
        //   'category': 'Sports',
        //   'apikey': '65f7f556ec76449fa7dc7c0069f040ca'
        // },

        url: 'v4/top-headlines',
        query: {
          'category' : 'sports',
          'lang' : 'en',
          'country' : 'us',
          'max' : '10',
          'apikey' : '79bf7be85e0500a4c69b8220dae6be33'
        }
      ).then((value) {
        //print(value.data['articles'][0]['title']);
        sports = value.data['articles'];
        print(sports[0]['title']);

        emit(NewSportsSuccessState());
      }).catchError((Error) {
        print(Error.toString());
        emit(NewSportsErrorState(Error.toString()));
      });
    } else {
      emit(NewSportsSuccessState());
    }
  }

  List<dynamic> scince = [];

  void getScince() {
    if (scince.isEmpty) {
      emit(NewScinceLoadingssState());
      DioHelper.getData(
        // url: 'v2/top-headlines',
        // query: {
        //   'country': 'eg',
        //   'category': 'science',
        //   'apikey': '65f7f556ec76449fa7dc7c0069f040ca'
        // },

        url: 'v4/top-headlines',
        query: {
          'category' : 'science',
          'lang' : 'en',
          'country' : 'us',
          'max' : '10',
          'apikey' : '79bf7be85e0500a4c69b8220dae6be33'
        }
      ).then((value) {
        //print(value.data['articles'][0]['title']);
        scince = value.data['articles'];
        print(scince[0]['title']);

        emit(NewScinceSuccessState());
      }).catchError((Error) {
        print(Error.toString());
        emit(NewScinceErrorState(Error.toString()));
      });
    } else {
      emit(NewScinceSuccessState());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewSearchLoadingssState());

    DioHelper.getData(
      url: 'v4/search',
      query: {'q': value, 'apikey': '79bf7be85e0500a4c69b8220dae6be33'},
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      print(search[0]['title']);

      emit(NewSearchSuccessState());
    }).catchError((Error) {
      print(Error.toString());
      emit(NewSearchErrorState(Error.toString()));
    });
  }

  bool isDark = false;

  void changeAppMode({bool? fromshared}) {
    if (fromshared != null) {
      isDark = fromshared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}
