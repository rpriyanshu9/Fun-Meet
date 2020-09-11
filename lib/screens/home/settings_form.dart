import 'package:daily_baithak/models/user.dart';
import 'package:daily_baithak/services/database.dart';
import 'package:daily_baithak/shared/constants.dart';
import 'package:daily_baithak/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> preference = ['chai', 'cold-drink'];

  String _currentName;
  String _currentpreference;
  String _currentFood;
  int _currentQty;

  @override
  Widget build(BuildContext context) {
    //getting the user that is logged in
    final user = Provider.of<User>(context);

    return SingleChildScrollView(
      //we use the stream builder for listening to streams rather than provider because we need data only..
      //..in this particular widget tree and we wont pass the context to any other widget tree further
      child: StreamBuilder<UserData>(
        // we getting stream from which func
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            // has data to check if snapshot has data or not
            if (snapshot.hasData) {
              UserData userData = snapshot.data;
              return Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Update your choices",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      initialValue: userData.name,
                      decoration:
                          textInputDecoration.copyWith(hintText: "Name"),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) => _currentName = val,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    DropdownButtonFormField(
                      value: _currentpreference ?? userData.preference,
                      items: preference.map((String dropDownStringItem) {
                        return DropdownMenuItem(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _currentpreference = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      initialValue: userData.food,
                      decoration:
                          textInputDecoration.copyWith(hintText: "Food"),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter an item' : null,
                      onChanged: (val) => _currentFood = val,
                    ),
                    Slider(
                        label: _currentQty != null
                            ? "$_currentQty"
                            : "${userData.qtyFood}",
                        value: (_currentQty ?? userData.qtyFood).toDouble(),
                        activeColor: Colors.red[_currentQty != null
                            ? _currentQty * 100
                            : userData.qtyFood * 100],
                        inactiveColor: Colors.red[_currentQty != null
                            ? _currentQty * 100
                            : userData.qtyFood * 100],
                        min: 1.0,
                        max: 9.0,
                        divisions: 8,
                        onChanged: (val) =>
                            setState(() => _currentQty = val.round())),
                    RaisedButton(
                      child: Text("Update"),
                      color: Colors.greenAccent[100],
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          //this sends the updated data to firestore databse and updates our listview
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentName ?? userData.name,
                              _currentpreference ?? userData.preference,
                              _currentFood ?? userData.food,
                              _currentQty ?? userData.qtyFood);
                          Navigator.pop(context);
                        }
                      },
                    )
                  ],
                ),
              );
            } else {
              return Loading();
            }
          }),
    );
  }
}
