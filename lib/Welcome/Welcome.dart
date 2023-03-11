import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lib_manage/HomePage/HomePage.dart';
import 'package:lib_manage/User_Access/login.dart';
import 'package:lib_manage/Widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  double _progressValue = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
    LogInStatus();
  }

  bool _isLoggedIn = false;

  Future LogInStatus() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var str = pref.getString('email');
    if (str != null) admin_check(str);
    print(isAdmin);
    setState(() {
      if (str != null) {
        getCurrentUserData();
        _isLoggedIn = true;
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          if (_progressValue == 1.0) {
            if (_isLoggedIn) {
              print("sayeb");
              nextScreen(context, HomePage());
            } else
              nextScreen(context, LogIn());
            timer.cancel();
          } else {
            _progressValue += 0.2;
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'asset/cou_logo.png',
                  width: 200,
                  height: 200,
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'পাঠাগার',
              style: GoogleFonts.raleway(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 35),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 10,
              child: LinearProgressIndicator(
                value: _progressValue,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Powered by:',
              style: GoogleFonts.raleway(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Department of\nManagement Studies',
              style: GoogleFonts.raleway(
                fontSize: 20,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Developed by:',
              style: GoogleFonts.raleway(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Abu Sayeb Rayhan\n13th Batch\nDepartment of CSE',
              style: GoogleFonts.raleway(
                fontSize: 20,
                color: Colors.red[600],
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
