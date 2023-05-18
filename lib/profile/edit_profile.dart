import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:osar_user/user_main_dashboard.dart';

import '../widgets/utils.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var _image;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController nameController = TextEditingController();

    TextEditingController addressController = TextEditingController();

    TextEditingController dobController = TextEditingController();

    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return new CircularProgressIndicator();
              }
              var document = snapshot.data;
              nameController.text = document['name'];
              emailController.text = document['email'];
              dobController.text = document['dob'];
              addressController.text = document['address'];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 4),
                            child: Text(
                              "Name",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.person),
                              fillColor: Colors.white,
                              hintText: 'Update Name',
                              border: inputBorder,
                              focusedBorder: inputBorder,
                              enabledBorder: inputBorder,
                              filled: true,
                              contentPadding: EdgeInsets.all(8),
                            ),
                            keyboardType: TextInputType.text,
                            controller: nameController,
                          ),
                          SizedBox(height: 10),
                          Container(
                            margin: EdgeInsets.only(left: 4),
                            child: Text(
                              "Email",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.email),
                              fillColor: Colors.white,
                              hintText: 'Update Email',
                              border: inputBorder,
                              focusedBorder: inputBorder,
                              enabledBorder: inputBorder,
                              filled: true,
                              contentPadding: EdgeInsets.all(8),
                            ),
                            keyboardType: TextInputType.text,
                            controller: emailController,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 4),
                            child: Text(
                              "Address",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.local_hospital_outlined),
                              fillColor: Colors.white,
                              hintText: 'Address',
                              border: inputBorder,
                              focusedBorder: inputBorder,
                              enabledBorder: inputBorder,
                              filled: true,
                              contentPadding: EdgeInsets.all(8),
                            ),
                            controller: addressController,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 4),
                            child: Text(
                              "Date of Birth",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.streetAddress,
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.brightness_1_rounded),
                              fillColor: Colors.white,
                              hintText: 'Date of Birth',
                              border: inputBorder,
                              focusedBorder: inputBorder,
                              enabledBorder: inputBorder,
                              filled: true,
                              contentPadding: EdgeInsets.all(8),
                            ),
                            controller: dobController,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 25),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xfffFFBF00).withOpacity(.6),
                          fixedSize: const Size(350, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                        ),
                        onPressed: () async {
                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({
                            "name": nameController.text,
                            "email": emailController.text,
                            "address": addressController.text,
                            "dob": dobController.text,
                          }).then((value) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => UserMainDashBoard()));
                          });
                        },
                        child: _isLoading == true
                            ? const Center(
                                child: CircularProgressIndicator.adaptive(),
                              )
                            : Text(
                                'Update',
                                style: GoogleFonts.getFont('Montserrat',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontStyle: FontStyle.normal),
                              ),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  selectImage() async {
    Uint8List ui = await pickImage(ImageSource.gallery);
    setState(() {
      _image = ui;
    });
  }
}
