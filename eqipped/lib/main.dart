
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aman',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Aman Kumar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _username = '';
  String _password = '';
  bool _isLoading = false;
  String _errorText = '';
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

 void _submitForm() async {
  setState(() {
    _isLoading = true;
  });

  Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

  final response = await http.post(Uri.parse('http://codea2z.online:8093/user/api/login'),headers: headers, body: {
    'username': _username,
    'password': _password,
  });

  setState(() {
    _isLoading = false;
  });

  if (response.statusCode == 200) {
    // Handle successful login
  } else {
    setState(() {
      _errorText = 'Invalid username or password';
    });
  }
}


  @override

Widget build(BuildContext context) {
  return Scaffold(
    body: Container(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
              validator: (value) {
                // if (value.isEmpty) {
                //   return 'Please enter your username';
                // }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _username = value;
                });
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
              validator: (value) {
                // if (value.isEmpty) {
                //   return 'Please enter your password';
                // }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _isLoading ? null : _submitForm,
              child: _isLoading
                  ? CircularProgressIndicator()
                  : Text('Log in'),
            ),
            SizedBox(height: 16),
            Text(
              _errorText,
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
    ),
  );
}

}
