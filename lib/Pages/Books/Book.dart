import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lib_manage/Widgets/widgets.dart';

class Book extends StatefulWidget {
  final String bookCategory;

  const Book({required this.bookCategory});

  @override
  State<Book> createState() => _BookState();
}

class _BookState extends State<Book> {
  @override
  final db = FirebaseFirestore.instance;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(widget.bookCategory),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
            height: h,
            width: w,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.5),
              image: DecorationImage(
                image: AssetImage("asset/cou_logo.png"),
              ),
            ),
            child: Container(
              color: Colors.white.withOpacity(.5),
              height: h,
              child: StreamBuilder<QuerySnapshot>(
                stream: db
                    .collection('Books')
                    .where("Cat", isEqualTo: widget.bookCategory)
                    .snapshots(),
                builder: ((context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView(
                      scrollDirection: Axis.vertical,
                      children: snapshot.data!.docs.map((doc) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Ink(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.blue.withOpacity(.2),
                                  Colors.orange.withOpacity(.5)
                                ],
                              ),
                            ),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              style: ListTileStyle.list,
                              tileColor:
                                  //  Colors.grey[300],
                                  // Color.fromARGB(255, 241, 233, 181),
                                  Colors.transparent,
                              subtitle: doc['Num_book'] > 0
                                  ? Text(
                                      "status: Available",
                                      style: GoogleFonts.arvo(
                                        color: Colors.lightGreen,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  : Text(
                                      "status :Unvailable",
                                      style: GoogleFonts.arvo(
                                          color: Colors.redAccent),
                                      textAlign: TextAlign.center,
                                    ),
                              title: Text(
                                "Name : ${doc["Name"]}\nAuthor: ${doc["Author"]}",
                                style: GoogleFonts.arvo(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    DateTime selectedDate = DateTime.now();
                                    TextEditingController nameController =
                                        TextEditingController();
                                    TextEditingController emailController =
                                        TextEditingController();
                                    TextEditingController contactController =
                                        TextEditingController();

                                    return AlertDialog(
                                      title: Text(
                                        'Enter the ',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                            controller: nameController,
                                            decoration: InputDecoration(
                                              labelText: 'Name',
                                              labelStyle: TextStyle(
                                                color: Theme.of(context)
                                                    .accentColor,
                                              ),
                                            ),
                                          ),
                                          TextField(
                                            controller: emailController,
                                            decoration: InputDecoration(
                                              labelText: 'Email',
                                              labelStyle: TextStyle(
                                                color: Theme.of(context)
                                                    .accentColor,
                                              ),
                                            ),
                                          ),
                                          TextField(
                                            controller: contactController,
                                            keyboardType: TextInputType.phone,
                                            decoration: InputDecoration(
                                              labelText: 'Contact',
                                              labelStyle: TextStyle(
                                                color: Theme.of(context)
                                                    .accentColor,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          InkWell(
                                            onTap: () async {
                                              final DateTime? picked =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate:
                                                          DateTime(2015, 8),
                                                      lastDate: DateTime(2101));
                                              if (picked != null &&
                                                  picked != selectedDate)
                                                setState(() {
                                                  selectedDate = picked;
                                                });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10.0,
                                                  horizontal: 12.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    'Selected Date: ${selectedDate.toLocal()}'
                                                        .split(' ')[0],
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                    ),
                                                  ),
                                                  Icon(Icons.calendar_today),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                              color:
                                                  Theme.of(context).accentColor,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop(null);
                                          },
                                        ),
                                        TextButton(
                                          child: Text(
                                            'Save',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                          onPressed: () {
                                            String name = nameController.text;
                                            String email = emailController.text;
                                            String contact =
                                                contactController.text;

                                            // Do something with the data here
                                            // e.g., save to database, update state, etc.

                                            Navigator.of(context).pop(null);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
                }),
              ),
            ),
          ),
        ),
      )),
    );
  }
}
