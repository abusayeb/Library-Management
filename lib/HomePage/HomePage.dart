import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lib_manage/Pages/Books/Book_cat.dart';
import 'package:lib_manage/Pages/Teachers.dart';
import 'package:lib_manage/User_Access/login.dart';
import 'package:lib_manage/Widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ElevatedButton(
          onPressed: () async {
            await _auth.signOut();
            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.clear();
            nextScreen(context, LogIn());
          },
          child: Text("LogOut"),
        ),
      ),
      appBar: appbar("Library Management"),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          height: h,
          width: w,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.5),
            image: DecorationImage(
              alignment: Alignment(.1, .1),
              image: AssetImage("asset/cou_logo.png"),
            ),
          ),
          child: Container(
              height: h - 10,
              width: w,
              color: Colors.white.withOpacity(.9),
              child: Column(
                children: [
                  SizedBox(
                    height: 250,
                    width: w,
                    child: const Image(
                      image: AssetImage("asset/library_1.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  space(10),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          nextScreen(context, book_cat());
                        },
                        child: Ink(
                          height: 60,
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
                            child: Text("Books Catalog",
                                style: GoogleFonts.alegreya(
                                    color: Color.fromARGB(255, 110, 98, 215),
                                    fontSize: 35,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  space(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Button(context, "Teachers"),
                          space(10),
                          Button(context, "Magazine"),
                          space(10),
                          Button(context, "Notice"),
                        ],
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        children: [
                          Button(context, "Researcher"),
                          space(10),
                          Button(context, "News"),
                          space(10),
                          Button(context, "Blogs")
                        ],
                      )
                    ],
                  ),
                ],
              )),
        ),
      )),
    );
  }
}
