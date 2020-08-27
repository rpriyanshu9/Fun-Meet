import 'package:cloud_firestore/cloud_firestore.dart';
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
    final choices = Provider.of<QuerySnapshot>(context);
    // adding .documents gives us all the documents in the firestore collection
    if (choices != null) {
      for (var doc in choices.documents) {
        // adding .data gives the data inside a specific snapshot
        print(doc.data);
      }
    }
    return Container();
  }
}
