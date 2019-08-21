import 'package:flutter/material.dart';
import 'package:food_app/login/login_screen.dart';
//import 'package:food_app/state_widget.dart';
import 'package:bloc/bloc.dart';
import 'package:food_app/authentication_bloc/bloc.dart';
import 'package:food_app/utils/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/simple_bloc_delegate.dart';
import 'package:food_app/splash_screen.dart';
import 'package:food_app/ui/screens/home_screen.dart';


void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      builder: (context) => AuthenticationBloc(userRepository: userRepository)
        ..dispatch(AppStarted()),
      child: App(userRepository: userRepository), //bloc: null,
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Unauthenticated) {
            return LoginScreen(userRepository: _userRepository);
          }
          if (state is Authenticated) {
            return HomeScreen( );
          }
          return SplashScreen();
        }, bloc: null,
      ),
    );
  }
}