import 'package:daily_baithak/models/choices.dart';
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
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: Text("Bottom Sheet"),
            );
          });
    }

    return StreamProvider<List<Choices>>.value(
      value: DatabaseService().choice,
      child: Scaffold(
        backgroundColor: Colors.white60,
        appBar: AppBar(
          title: Text('Daily Baithak'),
          actions: <Widget>[
            FlatButton.icon(
                padding: EdgeInsets.only(right: 0.0),
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
                )),
            SizedBox(
              width: 60.0,
              child: FlatButton.icon(
                  onPressed: () => _showSettingsPanel(),
                  icon: Icon(Icons.settings, color: Colors.white),
                  label: Text(
                    "",
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
        body: ChoiceList(),
      ),
    );
  }
}
