import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lib_manage/User_Access/login.dart';

import '../../Widgets/widgets.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

String email = "";

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: const Text(
                  'Password resent link has been sent to your mail!'),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      nextScreen(context, const LogIn());
                    },
                    child: const Text("OK"))
              ],
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text("Please enter the valid email"),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(),
      title: Text(
        "Password Recovery",
        style: GoogleFonts.aldrich(
          fontSize: 20,
        ),
      ),
      content: TextFormField(
        cursorColor: Colors.blueAccent,
        decoration: textInputDecoration.copyWith(
            prefixIcon: const Icon(Icons.mail, color: Colors.blue),
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
          return isValid ? null : "Please enter a valid email";
        },
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              passwordReset();
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
              "Sent",
              style: GoogleFonts.bebasNeue(
                fontSize: 20,
                color: Colors.white,
              ),
            )),
      ],
    );
  }
}
