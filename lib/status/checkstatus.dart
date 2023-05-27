import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:osar_user/database/database_methods.dart';
import 'package:osar_user/profile/setupuserprofile.dart';
import 'package:osar_user/status/blockstatus.dart';

class CheckStatus extends StatefulWidget {
  const CheckStatus({super.key});

  @override
  State<CheckStatus> createState() => _CheckStatusState();
}

class _CheckStatusState extends State<CheckStatus> {
  @override
  void initState() {
    // TODO: implement initState
    checkresult();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void checkresult() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    final bool doesDocExist = doc.exists;

    if (doesDocExist) {
      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => UserStatus()));
    } else {
      DatabaseMethods().numberAdd().then((value) => {
            Navigator.push(context,
                MaterialPageRoute(builder: (builder) => SetupUserProfile()))
          });
    }
  }
}
