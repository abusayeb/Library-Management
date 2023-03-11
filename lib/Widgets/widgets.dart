import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lib_manage/Pages/Teachers.dart';
import 'package:lib_manage/User_Access/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../Pages/Books/Book.dart';

var h = Get.height;
var w = Get.width;

final textInputDecoration = InputDecoration(
  filled: true,
  fillColor: Color.fromARGB(255, 241, 226, 226),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
    borderRadius: BorderRadius.circular(15),
  ),
  disabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.grey, width: 2),
    borderRadius: BorderRadius.circular(15),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.orange, width: 2),
    borderRadius: BorderRadius.circular(15),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.red, width: 2),
    borderRadius: BorderRadius.circular(15),
  ),
);

TextSpan textSpan(context, page, st1, st2) {
  return TextSpan(
      text: st1,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
      children: <TextSpan>[
        TextSpan(
            text: st2,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.orangeAccent,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    });
                Navigator.of(context).pop();
                nextScreen(context, page);
              })
      ]);
}

void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

SizedBox space(double val) {
  return SizedBox(height: val);
}

Text text(st) {
  return Text(
    st,
    style: GoogleFonts.arvo(
      fontSize: 20,
      // fontWeight: FontWeight.bold,
    ),
  );
}

String? userName;
String? userEmail;
String? userId;

drawer(context) {
  getCurrentUserData();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text(userName ?? ''),
          accountEmail: Text(userEmail ?? ''),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
              size: 40.0,
              color: Colors.grey,
            ),
          ),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Logout'),
          onTap: () async {
            await _auth.signOut();
            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.clear();
            nextScreen(context, LogIn());
          },
        ),
      ],
    ),
  );
}

Future<void> getCurrentUserData() async {
  final User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final DocumentSnapshot<Map<String, dynamic>> userDoc =
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .get();
    userName = userDoc.data()?['Name'];
    userEmail = user.email!;
    userId = userDoc.data()!['Id'];
    print(userName);
  }
}

show_snackbar(String st) {
  return SnackBar(
    content: Text(st),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {},
    ),
  );
}

appbar(String st) {
  return AppBar(
    title: Text(
      st,
      style: GoogleFonts.aldrich(
          color: Colors.white, fontSize: 25, fontWeight: FontWeight.w900),
    ),
    centerTitle: true,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue.withOpacity(0.8),
            Colors.orange.withOpacity(0.6),
          ],
        ),
      ),
    ),
  );
}

Button(context, String st) {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(15))),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (st == "Teachers") nextScreen(context, teachers());
        },
        child: Ink(
          height: 50,
          width: w / 2.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.withOpacity(.2),
                Colors.orange.withOpacity(.5)
              ],
            ),
          ),
          child: Center(
            child: Text(st,
                style: GoogleFonts.merriweather(
                    fontSize: 22, color: Color.fromARGB(255, 110, 98, 215))),
          ),
        ),
      ),
    ),
  );
}

//Book category
Category(String st, context) {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(15))),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          nextScreen(context, Book(bookCategory: st));
        },
        child: Ink(
          height: 40,
          width: w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.withOpacity(.2),
                Colors.orange.withOpacity(.5)
              ],
            ),
          ),
          child: Center(
            child: Text(st,
                style: GoogleFonts.alegreya(
                    color: Color.fromARGB(255, 110, 98, 215),
                    fontSize: 25,
                    fontWeight: FontWeight.w600)),
          ),
        ),
      ),
    ),
  );
}

late bool isAdmin = false;

void admin_check(String email) {
  print(email);
  if (email == "sayeb.cc.75@gmail.com")
    isAdmin = true;
  else
    isAdmin = false;
}
