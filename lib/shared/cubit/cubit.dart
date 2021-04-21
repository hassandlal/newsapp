import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/business_page.dart';
import 'package:news_app/modules/science/science_page.dart';
import 'package:news_app/modules/sport/sport_page.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cash_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> pages = [businessPage(), sportPage(), sciencePage()];
  List<String> titles = ['Business News', 'Sports News', 'Science News'];
  List<BottomNavigationBarItem> navBarItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'science'),
  ];

  void changePageIndex(int index) {
    currentIndex = index;
    //if (index == 1) getSportsNews();
    //if (index == 2) getScienceNews();
    emit(AppChangeBottomNavBarState());
  }

  List<dynamic> business = [];

  void getBusinessNews() {
    emit(AppGetBusinessLoadingStateState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': '1378c0e054e5499c966c1ae8a5a4036d'
    }).then((value) {
      business = value.data['articles'];
      print(business[0]['title']);
      emit(AppGetBusinessSuccessStateState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetBusinessErrorStateState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSportsNews() {
    emit(AppGetSportsLoadingStateState());
    if (sports.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '1378c0e054e5499c966c1ae8a5a4036d'
      }).then((value) {
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(AppGetSportsSuccessStateState());
      }).catchError((error) {
        print(error.toString());
        emit(AppGetSportsErrorStateState(error.toString()));
      });
    } else {
      emit(AppGetSportsSuccessStateState());
    }
  }

  List<dynamic> science = [];

  void getScienceNews() {
    emit(AppGetScienceLoadingStateState());
    if (science.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '1378c0e054e5499c966c1ae8a5a4036d'
      }).then((value) {
        science = value.data['articles'];
        print(science[0]['title']);
        emit(AppGetScienceSuccessStateState());
      }).catchError((error) {
        print(error.toString());
        emit(AppGetScienceErrorStateState(error.toString()));
      });
    } else {
      emit(AppGetScienceSuccessStateState());
    }
  }

  bool isDark = false;

  void changeAppMode({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeAppModeState());
    } else {
      isDark = !isDark;
      CashHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeAppModeState());
      });
    }
  }

  List<dynamic> searchList = [];

  void searchItems(String value) {
    emit(AppGetSearchLoadingStateState());
    searchList = [];
    DioHelper.getData(url: 'v2/everything', query: {
      'q': '$value',
      'apiKey': '1378c0e054e5499c966c1ae8a5a4036d'
    }).then((value) {
      searchList = value.data['articles'];
      print(science[0]['title']);
      emit(AppGetSearchSuccessStateState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetSearchErrorStateState(error.toString()));
    });
  }
}
