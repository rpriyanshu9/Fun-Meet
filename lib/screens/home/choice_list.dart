import 'package:daily_baithak/models/choices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChoiceList extends StatefulWidget {
  @override
  _ChoiceListState createState() => _ChoiceListState();
}

class _ChoiceListState extends State<ChoiceList> {
  @override
  Widget build(BuildContext context) {
    //accessing data from snpshot stream
    final choices = Provider.of<List<Choices>>(context);
    // adding .documents gives us all the documents in the firestore collection
    choices.forEach((element) {
      print(element.name);
      print(element.preference);
      print(element.cig);
      print(element.no_cig);
      print(element.food);
      print(element.qty_food);
    });
    return Container();
  }
}
