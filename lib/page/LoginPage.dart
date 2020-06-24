import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportlink_demo/page/RegisterPage.dart';
import 'package:sportlink_demo/widget/PageController.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextStyle style = TextStyle(fontSize: 20.0);
  TextEditingController _email;
  TextEditingController _password;
  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  bool loading = false;
  bool secureText = true;

  login() async {
    setState(() {
      loading = true;
    });
    final response = await http
        .post("http://202.169.224.10/api_sportlink/api.php", body: {
      "opsi": "login",
      "email": _email.text,
      "password": _password.text
    });
    final data = jsonDecode(response.body);
    int savevalue = data['value'];
    if (savevalue == 1) {
      String saveid = data['data']['id_user'];
      print("berhasil");
      setState(() {
        savePref(savevalue, saveid);
        Navigator.pop(context);
      });
    } else {
      setState(() {
        loading = false;
      });
      print("gagal");
      _key.currentState.showSnackBar(
          SnackBar(content: Text("Username or password incorect")));
    }
  }

  savePref(int value, String userid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      pref.setInt("value", value);
      pref.setString("userid", userid);
    });
  }

  var value;

  /* void getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      value = pref.getInt("value");
      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
      print(value);
    });
  }*/

  showHidePsw() {
    setState(() {
      secureText = !secureText;
    });
  }

  @override
  void initState() {
    super.initState();
    _email = TextEditingController(text: "");
    _password = TextEditingController(text: "");
    //getPref();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: new Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
        leading: Container(),
      ),
      key: _key,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/images/sportlink.png",
                  width: 250.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: _email,
                    validator: (value) =>
                        (value.isEmpty) ? "Please Enter Email" : null,
                    style: style,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: "Email",
                        border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: _password,
                    obscureText: secureText,
                    validator: (value) =>
                        (value.isEmpty) ? "Please Enter Password" : null,
                    style: style,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: showHidePsw,
                          icon: Icon(secureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        prefixIcon: Icon(Icons.lock),
                        labelText: "Password",
                        border: OutlineInputBorder()),
                  ),
                ),
                loading == true
                    ? Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.red,
                          child: MaterialButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                //print(_email.text);
                                //print(_password.text);
                                login();
                              }
                            },
                            child: Text(
                              "Masuk",
                              style: style.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.red,
                    child: MaterialButton(
                      onPressed: () async {
                        _routeregister(context);
                      },
                      child: Text(
                        "Daftar",
                        style: style.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _routeregister(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    if (result == null) {
    } else {
      _key.currentState
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text("$result")));
    }
  }
}
