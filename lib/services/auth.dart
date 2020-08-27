import 'dart:async';

import 'package:daily_baithak/models/user.dart';
import 'package:daily_baithak/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //instance of firebase authentication
  //this instance will allow us to communicate to firebase auth in the backend
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //this function creates our User object based on the firebase user
  User _privateUserFromFirebaseUser ( FirebaseUser user){
    return user!=null ? User(uid: user.uid): null;
  }

  //auth change user stream
  Stream<User> get user{
    // it returns every time auth changes form null to user object and vice versa
    //since we are working on our own version of user, we prefer that user which is given by the function above
    return _auth.onAuthStateChanged.map((FirebaseUser user) => _privateUserFromFirebaseUser(user));
  }

  //sign in anon
  //this is an async task and its gonna return a Future
  Future signInAnon() async {
    try{
      //await becz it could take some time to return the auth object
      //_auth.signInAnonymously() returns an AuthResult object
      AuthResult result= await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _privateUserFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
}

  //sign in with email and password
  Future signInWithEmailAndPassword(String email,String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _privateUserFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      //create new doc for the user with uid... this uses the choicesCollection in database.dart
      await DatabaseService(uid: user.uid).updateUserData(
          "new user", "chai", "ultra mild", 2, "biryani", 1);

      return _privateUserFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }
}

