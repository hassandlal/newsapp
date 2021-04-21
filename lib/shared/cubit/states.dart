abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeBottomNavBarState extends AppStates {}

class AppGetBusinessLoadingStateState extends AppStates {}

class AppGetBusinessSuccessStateState extends AppStates {}

class AppGetBusinessErrorStateState extends AppStates {
  final String error;

  AppGetBusinessErrorStateState(this.error);
}

class AppGetSportsLoadingStateState extends AppStates {}

class AppGetSportsSuccessStateState extends AppStates {}

class AppGetSportsErrorStateState extends AppStates {
  final String error;

  AppGetSportsErrorStateState(this.error);
}

class AppGetScienceLoadingStateState extends AppStates {}

class AppGetScienceSuccessStateState extends AppStates {}

class AppGetScienceErrorStateState extends AppStates {
  final String error;

  AppGetScienceErrorStateState(this.error);
}
class AppChangeAppModeState extends AppStates {}
class AppGetSearchSuccessStateState extends AppStates {}

class AppGetSearchErrorStateState extends AppStates {
  final String error;

  AppGetSearchErrorStateState(this.error);
}
class AppGetSearchLoadingStateState extends AppStates {}