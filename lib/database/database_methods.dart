import 'dart:typed_data';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:osar_user/database/storage_methods.dart';
import 'package:osar_user/models/store_models.dart';

class DatabaseMethods {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  // Future checkDocuement(String docID) async {
  //   final snapShot = await FirebaseFirestore.instance
  //       .collection('storeowners')
  //       .doc(FirebaseAuth.instance.currentUser!.uid) // varuId in your case
  //       .get();

  //   if (snapShot == null || !snapShot.exists) {
  //     // docuement is not exist
  //     print('id is not exist');
  //   } else {
  //     print("id is really exist");
  //   }
  // }
  Future<String> numberAdd() async {
    String res = 'Some error occured';
    try {
      //Add User to the database with modal
      StoreModel userModel = StoreModel(
          email: FirebaseAuth.instance.currentUser!.email!.toString(),
          address: '',
          dob: '',
          photoUrl: "",
          name: '',
          uid: FirebaseAuth.instance.currentUser!.uid,
          phoneNumber: "",
          blocked: false);
      await firebaseFirestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(
            userModel.toJson(),
          );
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //Profile Details
  Future<String> profileDetail({
    required String email,
    required String uid,
    required String name,
    String? address,
    required bool blocked,
    required String dob,
    required String phoneNumber,
    required Uint8List file,
  }) async {
    String res = 'Some error occured';

    try {
      if (email.isNotEmpty || name.isNotEmpty) {
        //Add User to the database with modal
        String photoURL = await StorageMethods()
            .uploadImageToStorage('UserPics', file, false);
        StoreModel userModel = StoreModel(
          blocked: blocked,
          name: name,
          address: "",
          dob: dob,
          uid: FirebaseAuth.instance.currentUser!.uid,
          email: FirebaseAuth.instance.currentUser!.email!.toString(),
          photoUrl: photoURL,
          phoneNumber: phoneNumber,
        );
        await firebaseFirestore
            .collection('users')
            .doc(uid)
            .set(userModel.toJson());

        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
