import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:osar_user/database/database_methods.dart';
import 'package:osar_user/profile/add_map_address.dart';
import 'package:osar_user/widgets/textfieldwidget.dart';
import 'package:osar_user/widgets/utils.dart';

class SetupUserProfile extends StatefulWidget {
  const SetupUserProfile({Key? key}) : super(key: key);

  @override
  _SetupUserProfileState createState() => _SetupUserProfileState();
}

class _SetupUserProfileState extends State<SetupUserProfile> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Uint8List? _image;

  bool _isLoading = false;

  final ImagePicker _picker = ImagePicker();
  File? imageUrl;
  String imageLink = "";
  void getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageUrl = File(image!.path);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.clear();
    _phoneController.clear();
    _dobController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 15,
          ),
          Center(
            child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  "User Profile",
                  style: TextStyle(
                      color: Color(0xff1D1E20),
                      fontWeight: FontWeight.w800,
                      fontSize: 22),
                )),
          ),
          SizedBox(
            height: 25,
          ),
          Center(
            child: InkWell(
              onTap: () => selectImage(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Color(0xffD2D2D2),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 59, backgroundImage: MemoryImage(_image!))
                          : Image.asset(
                              "assets/cam.png",
                              width: 51,
                              height: 39,
                            ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: RichText(
                          text: TextSpan(
                            text: 'Upload User Photo',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '*',
                                  style: GoogleFonts.getFont(
                                    'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red,
                                    fontStyle: FontStyle.normal,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: TextFormInputField(
              hintText: 'Enter your username',
              textInputType: TextInputType.text,
              controller: _nameController,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: TextFormInputField(
              hintText: 'Enter your email',
              textInputType: TextInputType.emailAddress,
              controller: _phoneController,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: TextFormInputField(
              hintText: 'Enter Date of Birth',
              textInputType: TextInputType.text,
              controller: _dobController,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xfffFFBF00).withOpacity(.6),
                fixedSize: const Size(350, 60),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              onPressed: SetupUserProfile,
              child: _isLoading == true
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : Text(
                      'Create Profile',
                      style: GoogleFonts.getFont('Montserrat',
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 15,
                          fontStyle: FontStyle.normal),
                    ),
            ),
          ),
        ]),
      ),
    );
  }

  // Select Image From Gallery
  selectImage() async {
    Uint8List ui = await pickImage(ImageSource.gallery);
    setState(() {
      _image = ui;
    });
  }

  SetupUserProfile() async {
    if (_nameController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _dobController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("All Fields are required")));
    } else {
      setState(() {
        _isLoading = true;
      });
      String rse = await DatabaseMethods().profileDetail(
          email: FirebaseAuth.instance.currentUser!.email!.toString(),
          name: _nameController.text,
          dob: _dobController.text,
          phoneNumber: _phoneController.text,
          file: _image!,
          uid: FirebaseAuth.instance.currentUser!.uid,
          blocked: false);

      print(rse);
      setState(() {
        _isLoading = false;
      });
      if (rse == 'success') {
        showSnakBar(rse, context);
        Navigator.push(
            context, MaterialPageRoute(builder: (builder) => AddMapAddress()));
      } else {
        showSnakBar(rse, context);
      }
    }
  }
}
