import 'package:daily_baithak/services/auth.dart';
import 'package:daily_baithak/shared/constants.dart';
import 'package:daily_baithak/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
              title: Text("Sign up"),
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
                      "Sign In",
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
                            height: 20,
                          ),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: '  Email'),
                            //here string is the helper texxt and null says that it is valid
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
                            //here string is the helper texxt and null says that it is valid
                            validator: (val) =>
                            val.length < 6
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
                          "Register",
                          style: TextStyle(
                              color: Colors.white, fontSize: 18.0),
                        ),
                        // this is async as sign in results in using firebase utilities and that might take sometime
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            // for this to work we need individual validators on the form fields
                            //print("$email and $password");
                            dynamic result =
                            await _auth.registerWithEmailAndPassword(
                                email, password);
                            // null if error, user if success
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error = 'please supply a valid email';
                              });
                            }
                          }
                        },
                      ),
                    )
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery
                        .of(context)
                        .viewInsets
                        .bottom))
          ],
        ),
      ),
    );
  }
}
