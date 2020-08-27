import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_baithak/screens/home/choice_list.dart';
import 'package:daily_baithak/services/auth.dart';
import 'package:daily_baithak/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().choice,
      child: Scaffold(
        backgroundColor: Colors.white60,
        appBar: AppBar(
          title: Text('Daily Baithak'),
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                label: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: ChoiceList(),
      ),
    );
  }
}
