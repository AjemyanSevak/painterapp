part of 'home_cubit.dart';

abstract class HomeState implements Built<HomeState, HomeStateBuilder> {
  HomeState._();

  bool get isLoading;
  bool get createButtonVisible;

  factory HomeState([Function(HomeStateBuilder b) updates]) = _$HomeState;

  factory HomeState.initial() {
    return HomeState(
      (s) => s
        ..isLoading = false
        ..createButtonVisible = true,
    );
  }
}
