abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomNavState extends NewsStates {}

class NewBusinessSuccessState extends NewsStates {}

class NewBusinessErrorState extends NewsStates {
  final String error;

  NewBusinessErrorState(this.error);
}

class NewBusinessLoadingssState extends NewsStates {}

class NewSportsSuccessState extends NewsStates {}

class NewSportsErrorState extends NewsStates {
  final String error;

  NewSportsErrorState(this.error);
}

class NewSportsLoadingssState extends NewsStates {}

class NewScinceSuccessState extends NewsStates {}

class NewScinceErrorState extends NewsStates {
  final String error;

  NewScinceErrorState(this.error);
}

class NewScinceLoadingssState extends NewsStates {}

class NewSearchSuccessState extends NewsStates {}

class NewSearchErrorState extends NewsStates {
  final String error;

  NewSearchErrorState(this.error);
}

class NewSearchLoadingssState extends NewsStates {}


class AppChangeModeState extends NewsStates {}