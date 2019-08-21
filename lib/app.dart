import 'package:flutter/material.dart';
import 'package:food_app/login/login_form.dart';
import 'package:food_app/register/register_form.dart';
//import 'package:food_app/ui/screens/home_screen.dart';

import 'package:food_app/ui/theme.dart'; // New code

class FoodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Touré Honor Family Recipes',
      theme: buildTheme(), // New code
       routes: {
      //   '/': (context) =>  HomeScreen(name: 'hodari', state.displayName),
         '/login': (context) => LoginForm(userRepository: null,),
         '/sign_up': (context) => RegisterForm(),
       },
    );
  }
}


