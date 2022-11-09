// ignore_for_file: prefer_const_constructors, unnecessary_import

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/foundation/key.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'home.dart';

class Bottom extends StatefulWidget {
  const Bottom({Key? key}) : super(key: key);

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  PageController pageController = PageController();
  // ignore: prefer_final_fields
  int _currentIndex = 1;
  final screens = [
    Center(
      child: Text("2"),
    ),
    Home(),
    Center(
      child: Text("3"),
    )
  ];

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "No",
        style: TextStyle(color: Colors.grey),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "yes",
        style: TextStyle(color: Color.fromRGBO(187, 121, 91, 1)),
      ),
      onPressed: () async {
        exit(0);
        // await delete();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Warning"),
      content: Text("Do you want exit ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: sort_child_properties_last
    return WillPopScope(
        // ignore: sort_child_properties_last
        child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Color.fromRGBO(187, 121, 91, 1),
              unselectedItemColor: Colors.grey[500],
              currentIndex: _currentIndex,
              // ignore: prefer_const_literals_to_create_immutables
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.map_sharp), label: "Peta"),
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle), label: "Profile"),
              ],
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            body: screens[_currentIndex]),
        onWillPop: () async {
          showAlertDialog(context);
          return true;
        });
  }
}
