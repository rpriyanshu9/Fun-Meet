import 'package:daily_baithak/models/choices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'choice_tile.dart';

class ChoiceList extends StatefulWidget {
  @override
  _ChoiceListState createState() => _ChoiceListState();
}

class _ChoiceListState extends State<ChoiceList> {
  @override
  Widget build(BuildContext context) {
    //accessing data from snpshot stream
    final choices = Provider.of<List<Choices>>(context) ?? [];
    // adding .documents gives us all the documents in the firestore collection

    // now we're gonna use listbuilder widget which lists out a list tile for each item in the list
    return ListView.builder(
        itemCount: choices.length,
        // index is the index of items in choices list
        itemBuilder: (context, index) {
          return ChoiceTile(choice: choices[index]);
        });
  }
}
