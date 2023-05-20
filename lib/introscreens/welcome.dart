import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:osar_user/auth/main_auth.dart';
import 'package:osar_user/introscreens/onboard.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   firebaseAuth.authStateChanges().listen((User? user) {
  //     if (user == null) {
  //       print('User is currently signed out!');
  //     } else {
  //       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>HomePage()), (route) => false) ;
  //     }
  //   });
  // }
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
