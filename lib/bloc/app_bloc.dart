import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class ToggleThemeEvent extends AppEvent {}

// States
abstract class AppState extends Equatable {
  final bool isDarkMode;

  const AppState({required this.isDarkMode});

  @override
  List<Object> get props => [isDarkMode];
}

class ThemeState extends AppState {
  const ThemeState({required super.isDarkMode});
}

// BLoC
class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const ThemeState(isDarkMode: false)) {
    on<ToggleThemeEvent>((event, emit) {
      emit(ThemeState(isDarkMode: !state.isDarkMode));
    });
  }
}
