import 'package:daily_baithak/services/auth.dart';
import 'package:daily_baithak/shared/constants.dart';
import 'package:daily_baithak/shared/loading.dart';
import 'package:flutter/material.dart';

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
  bool loading=false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white60,
      appBar: AppBar(
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
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
            child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            TextFormField(
              //copyWith helps to pass properties to consts in shared package
              decoration: textInputDecoration.copyWith(hintText: 'Email'),
              validator: (val) => val.isEmpty ? 'Enter an email' : null,
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
              decoration: textInputDecoration.copyWith(hintText: 'Password'),
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
            RaisedButton(
              color: Colors.black26,
              child: Text(
                "Sign IN",
                style: TextStyle(color: Colors.white),
              ),
              // this is async as sign in results in using firebase utilities and that might take sometime
              onPressed: () async {
//                    print("$email and $password");
                if (_formKey.currentState.validate()){
                  setState(()=>loading=true);
                  dynamic res =_auth.signInWithEmailAndPassword(email, password);
                  if (res==null) {
                    setState(()=>loading=false);
                    print('ERROR SIGNING IN');
                  }
                }
              },
            )
          ],
        )),
      ),
    );
  }
}
