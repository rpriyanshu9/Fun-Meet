import 'package:daily_baithak/models/choices.dart';
import 'package:daily_baithak/screens/home/settings_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChoiceTile extends StatelessWidget {
  final Choices choice;

  ChoiceTile({this.choice});

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    bool tea = true;
    if (choice.preference == 'chai')
      tea = true;
    else
      tea = false;
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            onTap: () {
              _showSettingsPanel();
            },
            isThreeLine: true,
            leading: CircleAvatar(
              backgroundImage: tea
                  ? AssetImage('assets/tea.png')
                  : AssetImage('assets/cold_drink.jpg'),
              radius: 25.0,
              backgroundColor: Colors.white,
            ),
            title: Text(choice.name),
            subtitle: choice.no_cig != 0
                ? Text(
                    "${choice.no_cig} ${choice.cig} with ${choice.qty_food} plate(s) of ${choice.food}")
                : Text("${choice.qty_food} plate(s) of ${choice.food}"),
          )),
    );
  }
}
