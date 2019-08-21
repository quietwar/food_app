import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/authentication_bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:food_app/login/create_account_button.dart';
import 'package:food_app/login/google_login_button.dart';
import 'package:food_app/model/food.dart';
import 'package:food_app/utils/store.dart';
import 'package:food_app/ui/widgets/recipe_card.dart';
import 'package:food_app/state_widget.dart';
import 'package:food_app/model/state.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomeScreenState(name: null);
}

class HomeScreenState extends State<HomeScreen> {
  StateModel appState;
  final String name;

  HomeScreenState({Key key, @required this.name});// : super(key: key);

  DefaultTabController buildTabView({Widget body}) {
    const double _iconSize = 20.0;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          // We set Size equal to passed height (50.0) and infinite width:
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            elevation: 2.0,
            title: Text('Touré Honor Family Recipes && Welcome $name!'),
              actions: <Widget>[
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).dispatch(
                    LoggedOut(),
                  );
                },
              ) 
              ],
            bottom: TabBar(
              labelColor: Theme.of(context).indicatorColor,
              tabs: [
                Tab(icon: Icon(Icons.restaurant, size: _iconSize)),
                Tab(icon: Icon(Icons.local_drink, size: _iconSize)),
                Tab(icon: Icon(Icons.favorite, size: _iconSize)),
                Tab(icon: Icon(Icons.settings, size: _iconSize)),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(5.0),
          child: body,
        ),
      ),
    );
  }

  Center _buildLoadingIndicator() {
    return Center(
      child: new CircularProgressIndicator(),
    );
  }

  Center _buildSettings() {
    return Center(
        child:  GoogleLoginButton(),
          //CreateAccountButton(userRepository: _userRepository),
      ); 
  }
  
  TabBarView _buildContent() {
    Padding _buildRecipes({RecipeType recipeType, List<String> ids}) {
      CollectionReference collectionReference =
          Firestore.instance.collection('recipes');
      Stream<QuerySnapshot> stream;
      // The argument recipeType is set
      if (recipeType != null) {
        stream = collectionReference
            .where("type", isEqualTo: recipeType.index)
            .snapshots();
      } else {
        // Use snapshots of all recipes if recipeType has not been passed
        stream = collectionReference.snapshots();
      }

      // Define query depeneding on passed args
      return Padding(
        // Padding before and after the list view:
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: new StreamBuilder(
                stream: stream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return _buildLoadingIndicator();
                  return new ListView(
                    children: snapshot.data.documents
                        // Check if the argument ids contains document ID if ids has been passed:
                        .where((d) => ids == null || ids.contains(d.documentID))
                        .map((document) {
                      return new RecipeCard(
                        recipe:
                            Recipe.fromMap(document.data, document.documentID),
                        inFavorites:
                            appState.favorites.contains(document.documentID),
                        onFavoriteButtonPressed: _handleFavoritesListChanged,
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    return TabBarView(
      children: [
        _buildRecipes(recipeType: RecipeType.food),
        _buildRecipes(recipeType: RecipeType.drink),
        _buildRecipes(ids: appState.favorites),
        _buildSettings(),
      ],
    );
  }
   
   void _handleFavoritesListChanged(String recipeID) {
    updateFavorites(appState.user.uid, recipeID).then((result) {
      if (result == true) {
        setState(() {
          if (!appState.favorites.contains(recipeID))
            appState.favorites.add(recipeID);
          else
            appState.favorites.remove(recipeID);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build the content depending on the state:
    appState = StateWidget.of(context).state;
    return _buildContent();
      }
    
      //  
}
