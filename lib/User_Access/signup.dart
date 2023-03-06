import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lib_manage/User_Access/login.dart';
import 'package:lib_manage/User_Access/verify_email.dart';
import 'package:lib_manage/Widgets/widgets.dart';
import 'package:lottie/lottie.dart';

class signUp extends StatefulWidget {
  signUp({Key? key}) : super(key: key);

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  @override
  String name = "";
  String email = "";
  String password = "";
  String confirmPass = "";
  String id = "";
  String dept = "";
  final formkey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Lottie Image
              Container(
                child: Lottie.asset("asset/signup.json"),
              ),

              //Signup text
              Container(
                height: 45,
                width: w - 5,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  border: Border.all(
                      color: const Color.fromARGB(255, 222, 79, 247), width: 3),
                ),
                alignment: Alignment.center,
                child: Text("Sign up Here",
                    style: GoogleFonts.bebasNeue(
                      fontSize: 30,
                      color: Colors.white,
                    )),
              ),
              space(20),

              Form(
                key: formkey,
                child: Column(
                  children: [
//Name textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: TextFormField(
                          cursorColor: Colors.blueAccent,
                          decoration: textInputDecoration.copyWith(
                              prefixIcon: const Icon(Icons.account_circle,
                                  color: Colors.blue),
                              hintText: "Full name",
                              hintStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                              )),
                          onChanged: (value) {
                            setState(() {
                              name = value;
                              print(name);
                            });
                          },
                          validator: (val) {
                            if (val!.length == 0) {
                              return "Name can't be null";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),

                    space(10),

                    //Id field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: TextFormField(
                          cursorColor: Colors.blueAccent,
                          decoration: textInputDecoration.copyWith(
                              prefixIcon:
                                  const Icon(Icons.mail, color: Colors.blue),
                              hintText: "Id",
                              hintStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                              )),
                          onChanged: (value) {
                            setState(() {
                              id = value;
                              print(id);
                            });
                          },
                          validator: (val) {
                            if (val!.length != 8) {
                              return "Id must be 8 characters";
                            }
                          },
                        ),
                      ),
                    ),

                    space(10),

                    //Email textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: TextFormField(
                          cursorColor: Colors.blueAccent,
                          decoration: textInputDecoration.copyWith(
                              prefixIcon:
                                  const Icon(Icons.mail, color: Colors.blue),
                              hintText: "Email",
                              hintStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                              )),
                          onChanged: (value) {
                            setState(() {
                              email = value;
                              print(email);
                            });
                          },
                          validator: (val) {
                            bool isValid = EmailValidator.validate(val!);
                            return isValid
                                ? null
                                : "Please enter a valid email";
                          },
                        ),
                      ),
                    ),

                    space(10),

                    //Password Field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: TextFormField(
                          cursorColor: Colors.blueAccent,
                          obscureText: true,
                          decoration: textInputDecoration.copyWith(
                              prefixIcon:
                                  const Icon(Icons.vpn_key, color: Colors.blue),
                              hintText: "Password",
                              hintStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                              )),
                          onChanged: (value) {
                            setState(() {
                              password = value;
                              print(password);
                            });
                          },
                          validator: (val) {
                            if (val!.length < 6) {
                              return "Password must be at least 6 characters";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),

                    space(10),

                    //confirm password file
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: TextFormField(
                          cursorColor: Colors.blueAccent,
                          obscureText: true,
                          decoration: textInputDecoration.copyWith(
                              prefixIcon:
                                  const Icon(Icons.key, color: Colors.blue),
                              hintText: "Confirm password",
                              hintStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                              )),
                          onChanged: (value) {
                            setState(() {
                              confirmPass = value;
                              print(confirmPass);
                            });
                          },
                          validator: (val) {
                            if (val == password) {
                              return null;
                            } else {
                              return "doesn't match";
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              space(10),

              //Sign in button
              ElevatedButton(
                  onPressed: () {
                    register();
                  },
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(
                          255, 196, 71, 218), //background color of button
                      side: const BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 98, 153,
                              249)), //border width and color //elevation of button
                      shape: RoundedRectangleBorder(
                          //to set border radius to button
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30) //content padding inside button
                      ),
                  child: Text(
                    "Register",
                    style: GoogleFonts.bebasNeue(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  )),

              //Footer text
              Text.rich(textSpan(context, const LogIn(),
                  "Already have an account? ", "Sign in")),
              space(30)
            ],
          ),
        ),
      ),
    );
  }

  //firebase work for signUp page
  register() async {
    if (formkey.currentState!.validate()) {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      final user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final firestore = FirebaseFirestore.instance;
      firestore.collection('Users').doc(user.user!.uid).set({
        "Name": name,
        "Id": id,
        "Email": email,
        "Pass": password,
      });
      print(user);
      Navigator.of(context).pop();
      if (user != null) {
        nextScreen(context, VerifyEmailPage());
      } else {
        print("error");
      }
    }
  }
}
