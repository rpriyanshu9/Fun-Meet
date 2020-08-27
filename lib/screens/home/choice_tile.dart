import 'package:daily_baithak/models/choices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChoiceTile extends StatelessWidget {
  final Choices choice;

  ChoiceTile({this.choice});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.black,
            ),
            title: Text(choice.name),
            subtitle: Text(
                "Takes ${choice.preference} and ${choice.no_cig} ${choice.cig} with ${choice.qty_food} plate of ${choice.food}"),
          )),
    );
  }
}
