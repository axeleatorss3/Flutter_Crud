import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:miau/pages/powerPage.dart';
import 'package:miau/pages/vendedorsPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(LoginApp());
}

String username;

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'flutter + Mysql',
      home: LoginPage(),
      routes: <String, WidgetBuilder>{
        '/PowerPage': (BuildContext context) => new Power(),
        '/VendedorPage': (BuildContext context) => new Vendedor(),
        '/LoginPage': (BuildContext context) => new LoginPage()
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController conntrollerUser = new TextEditingController();
  TextEditingController conntrollerPass = new TextEditingController();
  String messeage = '';
  Future<List> Login() async {
    final response = await http
        .post(Uri.parse("http://192.168.1.135/tienda/login.php"), body: {
      "username": conntrollerUser.text,
      "password": conntrollerPass.text
    });
    var dataUser = json.decode(response.body);
    if (dataUser.length == 0) {
      setState(() {
        messeage = "usuario incorrecto";
      });
    } else {
      if (dataUser[0]['nivel'] == 'admin') {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => Power()));
      } else if (dataUser[0]['nivel'] == 'super') {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => Vendedor()));
      }
      setState(() {
        username = dataUser[0]['username'];
      });
    }
    return dataUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        child: Container(
          decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: new AssetImage("assets/images/back2.png"),
                  fit: BoxFit.cover
              ),
          ),
          child: Column(
            children: <Widget>[
              new Container(margin: EdgeInsets.only(top: 60,right: 40,left: 40),
              child: new ClipOval(
              child: new Image(
                  height: 30,
                  width: 30,
                  image: new AssetImage("assets/images/Tohru_2.png"),
                  fit: BoxFit.cover,
              ),
              ),
                width: 170,
                height: 170,
                decoration: BoxDecoration(
                  shape: BoxShape.circle
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height/2,
                margin: EdgeInsets.only(top: 90,left: 20,right: 20,bottom: 90),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width/ 1 ,
                      padding: EdgeInsets.only(top: 15, left: 26, right: 26, bottom: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 50
                          )
                        ]
                      ),
                      child: TextFormField(
                        controller: conntrollerUser,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.mail,
                            color: Colors.deepPurpleAccent,
                          ),
                          hintText: "User"
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width /1,
                        margin: EdgeInsets.only(top: 40),
                        padding: EdgeInsets.only(top: 15, left: 26, right: 26, bottom: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 30
                          )
                        ]
                      ),
                      child: TextFormField(
                        controller: conntrollerPass,
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.vpn_key,
                            color: Colors.deepPurpleAccent,
                          ),
                          hintText: "password"
                        ),
                      ),
                    ),
                    Spacer(),
                    new ElevatedButton(
                      onPressed: () {
                        Login();
                      },
                      child: new Text("Ingresar",style: TextStyle(color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold,fontSize: 20)),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: new RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Text(
                          "¿Se te olvido tu contraseña?",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
