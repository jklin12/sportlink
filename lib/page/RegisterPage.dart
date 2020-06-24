import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sportlink_demo/page/LoginPage.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextStyle style = TextStyle(fontSize: 20.0);
  TextEditingController _email = TextEditingController(text: "");
  TextEditingController _password = TextEditingController(text: "");
  TextEditingController _username = TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  bool loading = false;
  bool secureText = true;

  register() async {
    setState(() {
      loading = true;
    });
    final response =
        await http.post("http://202.169.224.10/api_sportlink/api.php", body: {
      "opsi": "register",
      "username": _username.text,
      "email": _email.text,
      "password": _password.text
    });
    final data = jsonDecode(response.body);
    int savevalue = data['value'];
    String savepesan = data['message'];
    if (savevalue == 1) {
      Navigator.pop(context, 'Berhasil Mendaftar');
    } else {
      setState(() {
        loading = false;
        _key.currentState.showSnackBar(SnackBar(content: Text(savepesan)));
      });
    }
  }

  showHidePsw() {
    setState(() {
      secureText = !secureText;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _username.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: new Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context, null),
          ),
        ],
        leading: Container(),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/images/sportlink.png",
                  width: 250.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: _username,
                    validator: (value) =>
                        (value.isEmpty) ? "Masukan Username" : null,
                    style: style,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: "Username",
                        border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: _email,
                    validator: (value) =>
                        (value.isEmpty) ? "Masukan Email" : null,
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
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Password tidak boleh kosong';
                      }
                      if (value.length < 6) {
                        return 'Password minimal 6 karakter';
                      }
                      if (value.contains(new RegExp(
                          r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$'))) {
                        return 'Password harus mengandung angka, huruf dan spesialkarakter';
                      }
                    },
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
                                register();
                              }
                            },
                            child: Text(
                              "Daftar",
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
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Masuk",
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
}
