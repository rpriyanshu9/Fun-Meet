import 'package:daily_baithak/models/user.dart';
import 'package:daily_baithak/screens/authenticate/authenticate.dart';
import 'package:daily_baithak/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //listening for auth changes from stream provide in the main.dart file
    //we specified what type of data we need here... after .of
    final user = Provider.of<User>(context);
    return user==null ? Authenticate() : Home();
  }
}
