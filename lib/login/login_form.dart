import 'package:flutter/material.dart';
import 'package:food_app/login/bloc/login_bloc.dart';
import 'package:food_app/login/bloc/login_event.dart';
import 'package:food_app/login/bloc/login_state.dart';
import 'package:food_app/login/create_account_button.dart';
import 'package:food_app/login/google_login_button.dart';
import 'package:food_app/login/login_button.dart';
//import 'package:food_app/register/register_form.dart';
//import 'package:food_app/state_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter/services.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:food_app/authentication_bloc/bloc.dart';
import 'package:food_app/utils/user_repository.dart';

//import 'package:food_app/ui/screens/home.dart';



class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  LoginForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  static const PrimaryColor = const Color(0xffffdf00);

  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _loginBloc,
      listener: (BuildContext context, LoginState state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Login Failure'), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Logging In...'),
                    CircularProgressIndicator(),
                  ],
                ),
                backgroundColor: Colors.green,
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).dispatch(LoggedIn());
        }
      },
      child: BlocBuilder(
        bloc: _loginBloc,
        builder: (BuildContext context, LoginState state) {
          return Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Image.asset('assets/hodari.png', height: 200),
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: 'Email',
                      fillColor:Colors.blue,
                      hintText: 'gmail',
                      ),
                    autovalidate: true,
                    style: TextStyle(color: Colors.indigo[200]), 
                    autocorrect: false,
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
                    autovalidate: true,
                    autocorrect: false,
                    style: TextStyle(color:PrimaryColor),
                    validator: (_) {
                      return !state.isPasswordValid ? 'Invalid Password' : null;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        LoginButton(
                          onPressed: isLoginButtonEnabled(state)
                              ? _onFormSubmitted
                              : null,
                        ),
                        GoogleLoginButton(),
                        CreateAccountButton(userRepository: _userRepository),
                      ],
                    ),
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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.dispatch(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.dispatch(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.dispatch(
      LoginWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}

// class Login extends StatefulWidget {
//   @override
//   _LoginState createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   final GoogleSignIn googleSignIn = new GoogleSignIn();
//   bool isGoogleSignIn = false;
//   String errorMessage = 'try again';
//   String successMessage = 'Welcome back';
//   final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
//   String _emailId;
//   String _password;
//   final _emailIdController = TextEditingController(text: '');
//   final _passwordController = TextEditingController(text: '');

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: 
  //         Text('Touré Honor Family Recipes'),
  //           backgroundColor: Colors.green,
  //     )
      

  //     body: Center(
  //         child: Column(
  //       children: [
  //         Card(
  //           child: Padding(
  //             padding: EdgeInsets.all(10),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: <Widget>[
  //                 Form(
  //                   key: _formStateKey,
  //                   autovalidate: true,
  //                   child: Column(
  //                     children: <Widget>[
  //                       Padding(
  //                         padding:
  //                             EdgeInsets.only(left: 10, right: 10, bottom: 5),
  //                         child: TextFormField(
  //                           validator: validateEmail,
  //                           onSaved: (value) {
  //                             _emailId = value;
  //                           },
  //                           keyboardType: TextInputType.emailAddress,
  //                           controller: _emailIdController,
  //                           decoration: InputDecoration(
  //                             focusedBorder: new UnderlineInputBorder(
  //                               borderSide: new BorderSide(
  //                                   color: Colors.green,
  //                                   width: 2,
  //                                   style: BorderStyle.solid),
  //                             ),
  //                             labelText: "Email Id",
  //                             icon: Icon(
  //                               Icons.email,
  //                               color: Colors.green,
  //                             ),
  //                             fillColor: Colors.white,
  //                             labelStyle: TextStyle(
  //                               color: Colors.green,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding:
  //                             EdgeInsets.only(left: 10, right: 10, bottom: 5),
  //                         child: TextFormField(
  //                           validator: validatePassword,
  //                           onSaved: (value) {
  //                             _password = value;
  //                           },
  //                           controller: _passwordController,
  //                           obscureText: true,
  //                           decoration: InputDecoration(
  //                             focusedBorder: new UnderlineInputBorder(
  //                                 borderSide: new BorderSide(
  //                                     color: Colors.green,
  //                                     width: 2,
  //                                     style: BorderStyle.solid)),
  //                             labelText: "Password",
  //                             icon: Icon(
  //                               Icons.lock,
  //                               color: Colors.green,
  //                             ),
  //                             fillColor: Colors.white,
  //                             labelStyle: TextStyle(
  //                               color: Colors.green,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 (errorMessage != ''
  //                     ? Text(
  //                         errorMessage,
  //                         style: TextStyle(color: Colors.red),
  //                       ): 
  //                   Container()),
                    
  //                 ButtonTheme.bar(
  //                   child: ButtonBar(
  //                     children: <Widget>[
  //                       FlatButton(
  //                         child: Text(
  //                           'LOGIN',
  //                           style: TextStyle(
  //                             fontSize: 18,
  //                             color: Colors.green,
  //                           ),
  //                         ),
  //                         onPressed: () {
  //                           Navigator.push(context,
  //                           new MaterialPageRoute(
  //                             builder: (context) => HomeScreen(name: 'hodari', state.displayName),
  //                           ),
  //                         );
  //                           if (_formStateKey.currentState.validate()) {
  //                             _formStateKey.currentState.save();
  //                             signIn(_emailId, _password).then((user) {
  //                               if (user != null) {
  //                                 print('Logged in successfully.');
  //                                 setState(() {
  //                                   successMessage =
  //                                       'Logged in successfully.\nYou can now navigate to Home Page.';
  //                                 });
  //                               } else {
  //                                 print('Error while Login.');
  //                               }
  //                             });
  //                           }

  //                          } ),

  //                       FlatButton(
  //                         child: Text(
  //                           'Family, Please Register',
  //                           style: TextStyle(
  //                             fontSize: 12,
  //                             color: Colors.green,
  //                           ),
  //                         ),
  //                         onPressed: () {
  //                           Navigator.pushReplacement(
  //                             context,
  //                             new MaterialPageRoute(
  //                               builder: (context) => RegisterForm(),
  //                             ),
  //                           );
  //                         },
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
          
  //     ],
  //   )));
  // }

  // Future<FirebaseUser> signIn(String email, String password) async {
  //   try {
  //     FirebaseUser user = await auth.signInWithEmailAndPassword(
  //         email: email, password: password);

  //     assert(user != null);
  //     assert(await user.getIdToken() != null);

  //     final FirebaseUser currentUser = await auth.currentUser();
  //     assert(user.uid == currentUser.uid);
  //     return user;
  //   } catch (e) {
  //     handleError(e);
  //     return null;
  //   }
  // }

  // Future<FirebaseUser> googleSignin(BuildContext context) async {
  //   FirebaseUser currentUser;
  //   try {
  //     final GoogleSignInAccount googleUser = await googleSignIn.signIn();
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.getCredential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     final FirebaseUser user = await auth.signInWithCredential(credential);
  //     assert(user.email != null);
  //     assert(user.displayName != null);
  //     assert(!user.isAnonymous);
  //     assert(await user.getIdToken() != null);

  //     currentUser = await auth.currentUser();
  //     assert(user.uid == currentUser.uid);
  //     print(currentUser);
  //     print("User Name  : ${currentUser.displayName}");
  //   } catch (e) {
  //     handleError(e);
  //   }
  //   return currentUser;
  // }

  // Future<bool> googleSignout() async {
  //   await auth.signOut();
  //   await googleSignIn.signOut();
  //   return true;
  // }

  // handleError(PlatformException error) {
  //   print(error);
  //   switch (error.code) {
  //     case 'ERROR_USER_NOT_FOUND':
  //       setState(() {
  //         errorMessage = 'User Not Found!!!';
  //       });
  //       break;
  //     case 'ERROR_WRONG_PASSWORD':
  //       setState(() {
  //         errorMessage = 'Wrong Password!!!';
  //       });
  //       break;
  //   }
  // }

  
