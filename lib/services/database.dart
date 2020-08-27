import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  //inside here we're gonna have all the methods and properties that we're gonna use to interact with cloud firestore databse

  //collection reference-reference to particular collection in firestore database
  final CollectionReference choicesCollection = Firestore.instance.collection('choices');

}