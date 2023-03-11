import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Widgets/widgets.dart';

class borrower extends StatefulWidget {
  const borrower({super.key});

  @override
  State<borrower> createState() => _borrowerState();
}

class _borrowerState extends State<borrower> {
  @override
  final db = FirebaseFirestore.instance;
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      appBar: appbar("Borrowers"),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * .85,
            child: StreamBuilder<QuerySnapshot>(
              stream: db.collection('Borrower').snapshots(),
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
                          child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              style: ListTileStyle.list,
                              tileColor:
                                  //  Colors.grey[300],
                                  // Color.fromARGB(255, 241, 233, 181),
                                  Colors.transparent,
                              subtitle: Text(
                                " ${doc["Contact"]}\n Issue Date: ${doc["Date"]}\n Return Date: ${doc["Return"]}",
                                style: GoogleFonts.arvo(),
                                textAlign: TextAlign.center,
                              ),
                              title: Text(
                                "${doc["Name"]}\nBook Name: ${doc["Book_Name"]}",
                                style: GoogleFonts.arvo(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("What would you like to do?"),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            GestureDetector(
                                              child: Text("Delete"),
                                              onTap: () {
                                                Navigator.of(context).pop();
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title:
                                                          Text("Are you sure?"),
                                                      content: Text(
                                                          "Do you really want to delete this borrower?"),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          child: Text("Cancel"),
                                                          onPressed: () =>
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(),
                                                        ),
                                                        TextButton(
                                                          child: Text("Delete"),
                                                          onPressed: () {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'Borrower')
                                                                .where('Name',
                                                                    isEqualTo: doc[
                                                                        "Name"])
                                                                .where(
                                                                    'Book_Name',
                                                                    isEqualTo: doc[
                                                                        "Book_Name"])
                                                                .get()
                                                                .then(
                                                                    (querySnapshot) {
                                                              querySnapshot.docs
                                                                  .forEach(
                                                                      (document) {
                                                                document
                                                                    .reference
                                                                    .delete();
                                                              });
                                                            });
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'Borrower Deleted successfully!',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red),
                                                                ),
                                                                duration:
                                                                    Duration(
                                                                        seconds:
                                                                            4),
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
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }),
                        ),
                      );
                    }).toList(),
                  );
                }
              }),
            ),
          ),
        ),
      )),
    );
  }
}
