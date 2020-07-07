import 'package:emphaty/src/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/main_screen.dart';
import 'pages/signup_login.dart';
import 'pages/login_page.dart';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Emphaty',
      theme: ThemeData(
        primaryColor: Colors.blue[400]
      ),
      routes: <String, WidgetBuilder> {
        '/signup' : (BuildContext context) => new SignUpPage(),
        '/mainscreen' : (BuildContext context) => new MainScreen(),
        '/login' : (BuildContext context) => new LoginPage(),
      },
      home: CheckAuth(),
    );
  }
}

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;  
  @override
  void initState() { 
    _checkIfLoggedIn();
    super.initState();
  }

  void _checkIfLoggedIn() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if(token != null){
      setState(() => isAuth = true);
    }
  }

  Widget build(BuildContext context) {
    Widget child;
    if(isAuth){
      child = MainScreen();
    } else {
      child = LoginPage();
    }
    return Scaffold(
      body: child,
    );
  }
}

