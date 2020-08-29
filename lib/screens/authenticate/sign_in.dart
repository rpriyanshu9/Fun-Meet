import 'package:daily_baithak/services/auth.dart';
import 'package:daily_baithak/shared/constants.dart';
import 'package:daily_baithak/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String password = "";
  String error = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomPadding: false,
            backgroundColor: Colors.white60,
            appBar: GradientAppBar(
              backgroundColorStart: Colors.cyan,
              backgroundColorEnd: Colors.indigo,
              title: Text("Sign In"),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Register",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Colors.blue, Colors.red])),
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            //copyWith helps to pass properties to consts in shared package
                            decoration: textInputDecoration.copyWith(
                                hintText: '  Email'),
                            validator: (val) =>
                                val.isEmpty ? 'Enter an email' : null,
                            // this val represents whatever is inside the form field at that time
                            // and this onChanged will trigger when ever this val changes
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: '  Password'),
                            validator: (val) => val.length < 6
                                ? 'Password must be atleat 6 chars long'
                                : null,
                            //obscures means to hide the password as you type
                            obscureText: true,
                            onChanged: (val) {
                              password = val;
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ButtonTheme(
                            minWidth: 140.0,
                            height: 50,
                            child: RaisedButton(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                                side: BorderSide(color: Colors.black),
                              ),
                              splashColor: Colors.cyan,
                              color: Colors.black,
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0),
                              ),
                              // this is async as sign in results in using firebase utilities and that might take sometime
                              onPressed: () async {
//                    print("$email and $password");
                                if (_formKey.currentState.validate()) {
                                  setState(() => loading = true);
                                  dynamic res =
                                      _auth.signInWithEmailAndPassword(
                                          email, password);
                                  if (res == null) {
                                    setState(() => loading = false);
                                    print('ERROR SIGNING IN');
                                  }
                                }
                              },
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom))
                        ],
                      )),
                ],
              ),
            ),
          );
  }
}
