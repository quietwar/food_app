import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/authentication_bloc/authentication_bloc.dart';
import 'package:food_app/authentication_bloc/authentication_event.dart';
import 'package:food_app/register/bloc/register_bloc.dart';
import 'package:food_app/register/bloc/register_state.dart';
import 'package:food_app/register/bloc/register_event.dart';
import 'package:food_app/register/register_button.dart';


class RegisterForm extends StatefulWidget {
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController(text: '');
  final TextEditingController _fullNameController = TextEditingController(text: '');
  final TextEditingController _cellyController = TextEditingController();

  RegisterBloc _registerBloc;

  bool get isPopulated =>
     _userNameController.text.isNotEmpty && _fullNameController.text.isNotEmpty && _cellyController.text.isNotEmpty && _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }
  String fullName, userName, email, password, confirmPassword, celly;

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _userNameController.addListener(_onUserNameChanged);
    _fullNameController.addListener(_onFullNameChanged);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    _cellyController.addListener(_onCellyChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _registerBloc,
      listener: (BuildContext context, RegisterState state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registering...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).dispatch(LoggedIn());
          Navigator.of(context).pop();
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registration Failure'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder(
        bloc: _registerBloc,
        builder: (BuildContext context, RegisterState state) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    decoration: new InputDecoration(hintText: 'User Name',
                      icon: Icon(Icons.people, color: Colors.green),
                      fillColor: Colors.white,
                      labelStyle: TextStyle(
                        color: Colors.green
                      )),
                    controller: _userNameController,
                    keyboardType: TextInputType.text,
                    maxLength: 32,
                    validator: (_) {
                      return !state.isUserNameValid ? 'Try again Playa' : null;
                    },
                  ),
                TextFormField(
                  decoration: new InputDecoration(hintText: 'Full Name',
                    icon: Icon(Icons.person, color: Colors.green),
                    fillColor: Colors.white,
                    labelStyle: TextStyle(
                      color: Colors.green
                        )),
                    keyboardType: TextInputType.text,
                    controller: _fullNameController,
                    maxLength: 32,
                    validator: (_) {
                      return !state.isFullNameValid ? 'Government Name' : null;
                    },
                    ),
                TextFormField(
                  decoration: new InputDecoration(hintText: 'Celly',
                  icon: Icon(Icons.phone, color: Colors.green),
                        fillColor: Colors.white,
                        labelStyle: TextStyle(
                          color: Colors.green
                        )),
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  validator: (_) {
                      return !state.isCellyValid ? 'No burner phones please' : null;
                    },),
                TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: 'Email',
                    ),
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isEmailValid ? 'Invalid Email' : null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isPasswordValid ? 'Invalid Password' : null;
                    },
                  ),
                  RegisterButton(
                    onPressed: isRegisterButtonEnabled(state)
                        ? _onFormSubmitted
                        : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }


  @override
  void dispose() {
    _userNameController.dispose();
    _fullNameController.dispose();
    _cellyController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _registerBloc.dispatch(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _registerBloc.dispatch(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onUserNameChanged() {
    _registerBloc.dispatch(
      UserNameChanged(userName: _userNameController.text),
    );
  }

  void _onCellyChanged() {
      _registerBloc.dispatch(
        UserNameChanged(userName: _userNameController.text),
      );
    }
  void _onFullNameChanged() {
    _registerBloc.dispatch(
      FullNameChanged(fullName: _fullNameController.text),
    );
  }
  void _onFormSubmitted() {
    _registerBloc.dispatch(
      Submitted(
        userName: _userNameController.text,
        fullName: _fullNameController.text,
        celly: _cellyController.text,
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}