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
      drawer: drawer(context),
      appBar: appbar(widget.bookCategory),
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("asset/cou_logo.png"),
        )),
        child: Container(
          color: Colors.white.withOpacity(.9),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Container(
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
                                      Colors.blue.withOpacity(.9),
                                      Colors.orange.withOpacity(.9)
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
                                          "status: Available(${doc['Num_book']})",
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
                                    isAdmin
                                        ? showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                    "What would you like to do?"),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: <Widget>[
                                                      GestureDetector(
                                                        child: Text("Delete"),
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                    "Are you sure?"),
                                                                content: Text(
                                                                    "Do you really want to delete this book?"),
                                                                actions: <
                                                                    Widget>[
                                                                  TextButton(
                                                                    child: Text(
                                                                        "Cancel"),
                                                                    onPressed: () =>
                                                                        Navigator.of(context)
                                                                            .pop(),
                                                                  ),
                                                                  TextButton(
                                                                    child: Text(
                                                                        "Delete"),
                                                                    onPressed:
                                                                        () {
                                                                      FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'Books')
                                                                          .where(
                                                                              'Name',
                                                                              isEqualTo: doc["Name"])
                                                                          .get()
                                                                          .then((querySnapshot) {
                                                                        querySnapshot
                                                                            .docs
                                                                            .forEach((document) {
                                                                          document
                                                                              .reference
                                                                              .delete();
                                                                        });
                                                                      });
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                        SnackBar(
                                                                          content:
                                                                              Text(
                                                                            'Book Deleted successfully!',
                                                                            style:
                                                                                TextStyle(color: Colors.red),
                                                                          ),
                                                                          duration:
                                                                              Duration(seconds: 4),
                                                                        ),
                                                                      );
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0)),
                                                      GestureDetector(
                                                        child: Text("Issue"),
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                          // Handle issue action
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              String name = "";
                                                              String
                                                                  contactNumber =
                                                                  "";
                                                              DateTime
                                                                  returnDate =
                                                                  DateTime.now()
                                                                      .add(Duration(
                                                                          days:
                                                                              14));
                                                              DateTime
                                                                  dateOnlyReturnDate =
                                                                  DateTime(
                                                                      returnDate
                                                                          .year,
                                                                      returnDate
                                                                          .month,
                                                                      returnDate
                                                                          .day);
                                                              DateTime
                                                                  issueDate =
                                                                  DateTime
                                                                      .now();
                                                              DateTime dateOnlyIssueDate =
                                                                  DateTime(
                                                                      issueDate
                                                                          .year,
                                                                      issueDate
                                                                          .month,
                                                                      issueDate
                                                                          .day);

                                                              String
                                                                  formattedReturnDate =
                                                                  "${dateOnlyReturnDate.day}-${dateOnlyReturnDate.month}-${dateOnlyReturnDate.year}";
                                                              String
                                                                  formattedIssueDate =
                                                                  "${dateOnlyIssueDate.day}-${dateOnlyIssueDate.month}-${dateOnlyIssueDate.year}";

                                                              return AlertDialog(
                                                                title: Text(
                                                                    'Issue Book'),
                                                                content: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    TextField(
                                                                      decoration: InputDecoration(
                                                                          label: Text(
                                                                              "Name"),
                                                                          hintText:
                                                                              'Abu Sayeb Rayhan'),
                                                                      onChanged:
                                                                          (value) {
                                                                        name =
                                                                            value;
                                                                      },
                                                                    ),
                                                                    TextField(
                                                                      decoration: InputDecoration(
                                                                          label: Text(
                                                                              "Contact"),
                                                                          hintText:
                                                                              '+8801XXXXXXXX'),
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .number,
                                                                      onChanged:
                                                                          (value) {
                                                                        contactNumber =
                                                                            value;
                                                                      },
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            10),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                            'Issue Date: '),
                                                                        Text(issueDate
                                                                            .toString()
                                                                            .substring(0,
                                                                                10)),
                                                                      ],
                                                                    ),
                                                                    space(10),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                            'Return Date: '),
                                                                        Text(returnDate
                                                                            .toString()
                                                                            .substring(0,
                                                                                10)),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                actions: [
                                                                  TextButton(
                                                                    child: Text(
                                                                        'Cancel'),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  ),
                                                                  ElevatedButton(
                                                                    child: Text(
                                                                        'Issue'),
                                                                    onPressed:
                                                                        () {
                                                                      // Save the data to the database
                                                                      FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'Borrower')
                                                                          .add({
                                                                        'Name':
                                                                            name,
                                                                        'Contact':
                                                                            contactNumber,
                                                                        'Date':
                                                                            formattedIssueDate.toString(),
                                                                        'Return':
                                                                            formattedReturnDate.toString(),
                                                                        'Book_Name':
                                                                            doc['Name']
                                                                      });

                                                                      Navigator.pop(
                                                                          context);
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                        SnackBar(
                                                                          content:
                                                                              Text(
                                                                            'Saved the borrowers information.',
                                                                            style:
                                                                                TextStyle(color: Colors.green),
                                                                          ),
                                                                          duration:
                                                                              Duration(seconds: 4),
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        : null;
                                  },
                                )),
                          );
                        }).toList(),
                      );
                    }
                  }),
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }
}
