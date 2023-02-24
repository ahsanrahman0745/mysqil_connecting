
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({Key? key}) : super(key: key);

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String status='';
  
  
  login() async {
    try{
      var settings =  ConnectionSettings(
          host: '192.168.1.7',
          port: 3306,
          user: 'ahsan',
          password: 'ahsan',
          db: 'flutter_test'
      );
      var connect = await MySqlConnection.connect(settings);
      var result =await connect.query("SELECT * FROM users where email = ? AND password = ? ",[email.text,password.text]);
      // var results = await conn.query('select name, email from users where id = ?', [userId]);
      setState(() {
        if(result.isNotEmpty){
          status = "login $result";
        }else {
          status = "not login";
        }
      });
      print("result $result");
    }catch(e){
      print("Exception: $e");
    }

  }
  
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: email,
              ),
              TextField(
                controller: password,
              ),
              ElevatedButton(onPressed: login, child: Text("Login")),
              Text("Status: $status")
            ],
          ),
        ),
      ),
    );
  }
}
