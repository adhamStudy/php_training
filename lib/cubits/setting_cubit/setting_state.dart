abstract class SettingStates{}

class SettingInitialState extends SettingStates{}

class SettingLoadingState extends SettingStates{}

class SettingSuccessState extends SettingStates{}

class SettingErrorState extends SettingStates{
  final String error;
  SettingErrorState(this.error);
}

class SettingLogoutState extends SettingStates{}
