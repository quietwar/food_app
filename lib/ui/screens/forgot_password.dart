// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:food_app/authentication_bloc/authentication_bloc.dart';
// import 'package:food_app/authentication_bloc/authentication_event.dart';

// class HomeScreen extends StatelessWidget {
//   final String name;

//   HomeScreen({Key key, @required this.name}) : super(key: key);
//     static const double _iconSize = 20.0;
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       //const double _iconSize = 20.0;
//       length: 4,
//       child: new Scaffold(
//       appBar: AppBar(
//         elevation: 2.0, 
//         title: Text('Touré Honor Family Recipes && Welcome $name!'),
//         bottom: TabBar(
//               labelColor: Theme.of(context).indicatorColor,
//               tabs: [
//                 Tab(icon: Icon(Icons.restaurant, size: _iconSize)),
//                 Tab(icon: Icon(Icons.local_drink, size: _iconSize)),
//                 Tab(icon: Icon(Icons.favorite, size: _iconSize)),
//                 Tab(icon: Icon(Icons.settings, size: _iconSize)),
//               ],
//             ),
//           actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.exit_to_app),
//             onPressed: () {
//               BlocProvider.of<AuthenticationBloc>(context).dispatch(
//                 LoggedOut(),
//               );
//             },
//           )
//         ],
      
//           )
//         ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           Center(child: Text('Welcome $name!')),
//         ],
//       ),
//     )
//     );
//   }
// }
