import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lib_manage/Widgets/widgets.dart';

class teachers extends StatefulWidget {
  const teachers({super.key});

  @override
  State<teachers> createState() => _teachersState();
}

class _teachersState extends State<teachers> {
  String name = "";
  String email = "";
  String phn = "";
  String post = "";
  final db = FirebaseFirestore.instance;
  @override
  Future<void> addData_Teacher(
      String name, String email, String phn, String post) async {
    // Get a Firestore instance
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Add a new document with a generated id
      await firestore.collection('Teachers').add({
        'Name': name,
        'Email': email,
        'Phn': phn,
        'Post': post,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text('Data uploaded successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Error uploading data! Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      appBar: appbar("Teachers"),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * .85,
            child: StreamBuilder<QuerySnapshot>(
              stream: db.collection('Teachers').snapshots(),
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
                              " ${doc["Email"]}\n ${doc["Phn"]}",
                              style: GoogleFonts.arvo(),
                              textAlign: TextAlign.center,
                            ),
                            title: Text(
                              "${doc["Name"]}\n${doc["Post"]}",
                              style: GoogleFonts.arvo(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                            onTap: () {},
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
      )),
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 195, 179, 144),
              onPressed: () async {
                final result = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        'Enter Details',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Name',
                              labelStyle: TextStyle(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            onChanged: (value) {
                              name = value;
                            },
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Post',
                              labelStyle: TextStyle(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            onChanged: (value) {
                              post = value;
                            },
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            onChanged: (value) {
                              email = value;
                            },
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Phone',
                              labelStyle: TextStyle(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            onChanged: (value) {
                              phn = value;
                            },
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
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
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          onPressed: () {
                            addData_Teacher(name, email, phn, post);
                            Navigator.of(context).pop(null);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              tooltip: 'Enter Teachers Details:',
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}
