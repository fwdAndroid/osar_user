import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:osar_user/auth/main_auth.dart';
import 'package:osar_user/introscreens/onboard.dart';
import 'package:osar_user/user_main_dashboard.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user != null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (builder) => UserMainDashBoard()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (builder) => MainAuth()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Expanded(child: OnBoardingScreens()),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width, 60)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => MainAuth()));
                },
                child: Text("Sign In"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
