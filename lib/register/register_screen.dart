import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/register/bloc/register_bloc.dart';
import 'package:food_app/register/register_form.dart';
import 'package:food_app/utils/user_repository.dart';

class RegisterScreen extends StatelessWidget {
  final UserRepository _userRepository;
  static const PrimaryColor = const Color(0xffffdf00);

  RegisterScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register',
      style: TextStyle(color:PrimaryColor)),
      backgroundColor: Colors.green),
      body: Center(
        child: BlocProvider<RegisterBloc>(
          builder: (context) => RegisterBloc(userRepository: _userRepository),
          child: RegisterForm(),
        ),
      ),
    );
  }
}
