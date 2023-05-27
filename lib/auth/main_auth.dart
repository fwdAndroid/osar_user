import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:osar_user/auth/verifyphone.dart';
import 'package:osar_user/database/database_methods.dart';
import 'package:osar_user/status/checkstatus.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_social_button/flutter_social_button.dart';

class MainAuth extends StatefulWidget {
  const MainAuth({Key? key}) : super(key: key);

  @override
  State<MainAuth> createState() => _MainAuthState();
}

class _MainAuthState extends State<MainAuth> {
  final formKey = GlobalKey<FormState>();
  int? isviewed;

  String dialCodeDigits = "+92";
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logo.png",
                width: 150,
                height: 200,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "OTP Verification",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                "We will send you a code for verification dont share \n anyone your code",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white70),
                margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                  children: [
                    CountryCodePicker(
                        onChanged: (country) {
                          setState(() {
                            dialCodeDigits = country.dialCode!;
                          });
                        },
                        initialSelection: "PK",
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                        favorite: ["+92", "PAK"]),
                    Expanded(
                      child: Container(
                        child: TextFormField(
                          validator: RequiredValidator(errorText: "Required"),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "3070684743",
                            //  prefix: Padding(padding: EdgeInsets.all(10),child: Text(dialCodeDigits,style: TextStyle(color: Colors.black),),),
                          ),
                          keyboardType: TextInputType.number,
                          controller: _controller,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => VerifyPhone(
                                    phone: _controller.text,
                                    codeDigits: dialCodeDigits)));
                      }
                    },
                    child: Text('Get OTP'),
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        primary: Color(0xfffFFBF00).withOpacity(.5),
                        fixedSize: Size(300, 46))),
              ),
              Text("OR"),
              FlutterSocialButton(
                onTap: () async {
                  await DatabaseMethods().signInWithGoogle().then((value) => {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => CheckStatus()))
                      });
                },
                buttonType:
                    ButtonType.google, // Button type for different type buttons
                iconColor: Colors.black, // for change icons colors
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
