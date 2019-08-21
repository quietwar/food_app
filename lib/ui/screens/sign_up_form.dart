// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class SignUpForm extends StatefulWidget {
//   @override
//   _FormState createState() => _FormState();
// }


// class _FormState extends State<SignUpForm> {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   String errorMessage = '';
//   String successMessage = '';
//   final GlobalKey<FormState> _key = GlobalKey();
//   bool _validate = false;
//   String fullName, userName, email, password, confirmPassword, celly;

//   get validateUserName => null;// _emailId;
 
//   final _userNameController = TextEditingController(text: '');
//   final _fullNameController = TextEditingController(text: '');
//   final _emailIdController = TextEditingController(text: '');
//   final _passwordController = TextEditingController(text: '');
//   final _confirmPasswordController = TextEditingController(text: '');

 

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//         appBar: new AppBar(
//           title:
//             Text('Touré Honor Family Recipes'),
//             backgroundColor: Colors.green
//         ),
//         body: new SingleChildScrollView(
//           child: new Container(
//             child: new Card(
//               child: Padding(
//                 padding: EdgeInsets.all(10),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                       new Form(
//                     key: _key,
//                     autovalidate: _validate,
//                     child: getFormUI(),
//                       )
//                   ]
//                 ),
//               ),
//             ),
//           ), 
//         ));
//   }
//   Widget getFormUI() {
//     var validateConfirmPassword;
//         return new Column(
//           children: <Widget>[   
//             new TextFormField(
//                 decoration: new InputDecoration(hintText: 'User Name',
//                 icon: Icon(Icons.people, color: Colors.green),
//                       fillColor: Colors.white,
//                       labelStyle: TextStyle(
//                         color: Colors.green
//                       )),
//                 controller: _userNameController,
//                 keyboardType: TextInputType.text,
//                 maxLength: 32,
//                 validator: validateUserName,
//                 onSaved: (String val) {
//                   fullName = val;
//                 },
//               ),
//             new TextFormField(
//                 decoration: new InputDecoration(hintText: 'Full Name',
//                 icon: Icon(Icons.person, color: Colors.green),
//                       fillColor: Colors.white,
//                       labelStyle: TextStyle(
//                         color: Colors.green
//                       )),
//                 keyboardType: TextInputType.text,
//                 controller: _fullNameController,
//                 maxLength: 32,
//                 validator: validateFullName,
//                 onSaved: (String val) {
//                   fullName = val;
//                 }),
//             new TextFormField(
//                 decoration: new InputDecoration(hintText: 'Celly',
//                 icon: Icon(Icons.phone, color: Colors.green),
//                       fillColor: Colors.white,
//                       labelStyle: TextStyle(
//                         color: Colors.green
//                       )),
//                 keyboardType: TextInputType.phone,
//                 maxLength: 10,
//                 validator: validateMobile,
//                 onSaved: (String val) {
//                     celly = val;
//                 }),
//             new TextFormField(
//                 decoration: new InputDecoration(hintText: 'Email ID',
//                 icon: Icon(Icons.email, color: Colors.green),
//                       fillColor: Colors.white,
//                       labelStyle: TextStyle(
//                         color: Colors.green
//                       )),
//                 keyboardType: TextInputType.emailAddress,
//                 controller: _emailIdController,
//                 maxLength: 32,
//                 validator: validateEmail,
//                 onSaved: (String val) {
//                 email = val;
//                 }),
//              new TextFormField(
//                  decoration: new InputDecoration(hintText: 'Password',
//                  icon: Icon(Icons.lock, color: Colors.green),
//                        fillColor: Colors.white,
//                        labelStyle: TextStyle(
//                          color: Colors.green
//                        )),
//                   controller: _passwordController,
//                   obscureText: true,
//                   keyboardType: TextInputType.text,
//                   maxLength: 32,
//                   validator: validatePassword,
//                   onSaved: (String val) {
//                   email = val;
//                   }),
//               new TextFormField(
//                  decoration: new InputDecoration(hintText: 'Confirm Password',
//                  icon: Icon(Icons.lock, color: Colors.green),
//                        fillColor: Colors.white,
//                        labelStyle: TextStyle(
//                          color: Colors.green
//                        )),
                  
//                   validator: validateConfirmPassword,
//                   controller: _confirmPasswordController,
//                   obscureText: true,
//                   maxLength: 32,
//                   onSaved: (String val) {
//                   email = val;
//                   }),
//           new SizedBox(height: 15.0),
//             new RaisedButton(
//               onPressed: _submit,
//               child: new Text('Submit'),
//             )
//           ],
//         );
//   }



//  String validateFullName(String value) {
//     String pattern = r'(^[a-zA-Z ]*$)';
//     RegExp regExp = new RegExp(pattern);
//     if (value.length == 0) {
//       return "Name is Required";
//     } else if (!regExp.hasMatch(value)) {
//       return "Name must be a-z and A-Z";
//     }
//     return null;
//   }
// //Here, We have set 10 digits validation on mobile number.
//   String validateCelly(String value) {
//     String patttern = r'(^[0-9]*$)';
//     RegExp regExp = new RegExp(patttern);
//     if (value.length == 0) {
//       return "Mobile is Required";
//     } else if(value.length != 10){
//       return "Mobile number must 10 digits";
//     }else if (!regExp.hasMatch(value)) {
//       return "Mobile Number must be digits";
//     }
//     return null;
//   }
//   //For Email Verification we using RegEx.
//   String validateEmail(String value) {
//     String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//     RegExp regExp = new RegExp(pattern);
//     if (value.length == 0) {
//       return "Email is Required";
//     } else if(!regExp.hasMatch(value)){
//       return "Invalid Email";
//     }else {
//       return null;
//     }
//   }

//    //For Password Verification we using RegEx.
//   String validatePassword(String value) {
//     String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//     RegExp regExp = new RegExp(pattern);
//     if (value.length == 0) {
//       return "Password is Required";
//     } else if(!regExp.hasMatch(value)){
//       return "Invalid Password";
//     }else {
//       return null;
//     }
//   }
//  _submit() {
//         if (_key.currentState.validate()) {
//     //    If all data are correct then save data to out variables
//         _key.currentState.save();
//       } else {
//     //    If all data are not valid then start auto validation.
//         setState(() {
//           _validate = true;
//         });
//       }
//      }
//   }
 
  
    