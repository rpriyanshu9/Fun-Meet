import 'package:daily_baithak/models/user.dart';
import 'package:daily_baithak/screens/wrapper.dart';
import 'package:daily_baithak/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //we need to wrap this material app into provider as this is the root element of the widget tree.
    //we use .value, so that inside we can specify which stream to listen to
    // we used <USer> because the stream returns our User object
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chai Sutta',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white60,
          primaryColor: Color(0xff2C2C2C),
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Wrapper(),
      ),
    );
  }
}
