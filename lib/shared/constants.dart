import 'package:flutter/material.dart';

//remember to use .copyWith() to pass properties to const here

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  errorStyle: TextStyle(fontSize: 16.0, color: Colors.yellow),
  errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
      borderSide: BorderSide(color: Colors.red, width: 2.0)),
  focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
      borderSide: BorderSide(color: Colors.red, width: 2.0)),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
      borderSide: BorderSide(color: Colors.black, width: 2.0)),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
    borderSide: BorderSide(color: Colors.cyan, width: 2.0),
  ),
);
