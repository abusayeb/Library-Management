import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lib_manage/Borrowers/borrow.dart';
import 'package:lib_manage/Widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class book_cat extends StatefulWidget {
  const book_cat({Key? key}) : super(key: key);

  @override
  State<book_cat> createState() => _book_catState();
}

class _book_catState extends State<book_cat> {
  late String bookName;
  late String category;
  late int numberOfBooks;
  late String selectedCategory;
  late String authorName;

  List<String> bookCategories = [
    'Computer Studies',
    'Management Studies',
    'International Business',
    'Economics',
    'Marketing',
    'Finance & Banking',
    'Arts',
    'Law',
    'Others'
  ];

  final db = FirebaseFirestore.instance;

  @override
  Future<void> addBook() async {
    // Get a Firestore instance
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Add a new document with a generated id
      await firestore.collection('Books').add({
        'Name': bookName,
        'Author': authorName,
        'Cat': selectedCategory,
        'Num_book': numberOfBooks
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

  @override
  void initState() {
    super.initState();
    selectedCategory = bookCategories[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      appBar: appbar("Book Category"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 280,
                width: w,
                child: const Image(
                  image: AssetImage("asset/book_3.jpg"),
                  fit: BoxFit.fitWidth,
                ),
              ),
              space(5),
              if (isAdmin)
                Container(
                  height: 60,
                  width: w,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent, width: 3),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        nextScreen(context, borrower());
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
                          child: Text("Borrowers",
                              style: GoogleFonts.merriweather(
                                  fontSize: 35,
                                  color: Color.fromARGB(255, 110, 98, 215))),
                        ),
                      ),
                    ),
                  ),
                ),
              space(5),
              Container(
                padding: EdgeInsets.all(8),
                child: Column(children: [
                  Category("Computer Studies", context),
                  space(10),
                  Category("Management Studies", context),
                  space(10),
                  Category("International Business", context),
                  space(10),
                  Category("Economics", context),
                  space(10),
                  Category("Marketing", context),
                  space(10),
                  Category("Finance & Banking", context),
                  space(10),
                  Category("Arts", context),
                  space(10),
                  Category("Law", context),
                  space(10),
                  Category("Others", context),
                  space(20)
                ]),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 205, 181, 129),
              onPressed: () async {
                final result = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        'Enter Book Details',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Book Name',
                              labelStyle: TextStyle(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            onChanged: (value) {
                              bookName = value;
                            },
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Author',
                              labelStyle: TextStyle(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            onChanged: (value) {
                              authorName = value;
                            },
                          ),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Category',
                              labelStyle: TextStyle(
                                color: Theme.of(context).accentColor,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor),
                              ),
                            ),
                            value: selectedCategory,
                            onChanged: (value) {
                              setState(() {
                                selectedCategory = value!;
                              });
                            },
                            items: bookCategories.map((category) {
                              return DropdownMenuItem(
                                value: category,
                                child: Text(category),
                              );
                            }).toList(),
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 16,
                            ),
                            isExpanded: true,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Number of Books',
                              labelStyle: TextStyle(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            onChanged: (value) {
                              if (int.tryParse(value) != null) {
                                numberOfBooks = int.parse(value);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Data not saved!\nPlease enter the valid information',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    duration: Duration(seconds: 4),
                                  ),
                                );
                              }
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
                            try {
                              addBook();
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'The field must have data!',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  duration: Duration(seconds: 4),
                                ),
                              );
                            }

                            Navigator.of(context).pop(null);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              tooltip: 'Enter Book Details:',
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}
