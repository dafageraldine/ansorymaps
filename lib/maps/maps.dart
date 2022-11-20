import 'dart:convert';

import 'package:ansory/login/login.dart';
import 'package:ansory/materi/pilih_materi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../bottombar.dart';
import '../data/data.dart';

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  var top = 0.25;
  var right = 0.18;
  var states = 2;
  var isloading = 0;

  void _showDialogfilter(judul, konten) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: RotatedBox(
            quarterTurns: 1,
            child: Container(
              width: 0.85.sw,
              height: 0.3.sh,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 0.1.sw, top: 0.05.sh),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          states == 0
                              ? "Kamu berada di Sedayu Lawas !"
                              : "Kamu berada di Masjid Sendang Duwur !",
                          style: TextStyle(
                              color: Color.fromRGBO(82, 82, 82, 1),
                              fontSize: 15.sp,
                              // fontFamily: 'Inter',
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                  10.verticalSpace,
                  Padding(
                    padding: EdgeInsets.only(
                      left: 0.1.sw,
                    ),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Ayo pelajari materinya !",
                          style: TextStyle(
                              color: Color.fromRGBO(82, 82, 82, 1),
                              fontSize: 14.sp,
                              // fontFamily: 'Inter',
                              fontWeight: FontWeight.w400),
                        )),
                  ),
                  20.verticalSpace,
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PilihMateri(states)));
                    },
                    child: Container(
                        width: 0.7.sw,
                        height: 0.08.sh,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 2.0,
                                color: Colors.black12,
                                spreadRadius: 2.0,
                                offset: Offset(0, 2))
                          ],
                          color: Color.fromRGBO(54, 37, 35, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                            child: Text(
                          "Pelajari Materi",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Color.fromRGBO(227, 205, 148, 1),
                              fontWeight: FontWeight.w600),
                        ))),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> showMateri() async {
    print("delay");
    await Future.delayed(Duration(seconds: 2));
    if (states == 0) {
      print("materi 0");
      _showDialogfilter("", "");
    } else if (states == 1) {
      _showDialogfilter("", "");
      print("materi 1");
    }
    print("show");
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              child: Image.asset(
                "assets/Peta_new.png",
                fit: BoxFit.fill,
                width: 1.sw,
                height: 1.sh,
              ),
            ),
            AnimatedPositioned(
                top: top.sh,
                right: right.sw,
                // ignore: sort_child_properties_last
                child: AnimatedOpacity(
                  opacity: states == 2 ? 0 : 1,
                  duration: const Duration(seconds: 3),
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Image.asset(
                      "assets/walk.gif",
                      height: 0.15.sh,
                    ),
                  ),
                ),
                duration: const Duration(seconds: 3)),
            Padding(
              padding: EdgeInsets.only(left: 0.05.sw, top: 0.08.sh),
              child: Column(
                children: [
                  RotatedBox(
                    quarterTurns: 1,
                    child: InkWell(
                      onTap: () {
                        if (states == 0) {
                          setState(() {
                            print("btn_back_clicked_0");
                            states = 1;
                            top = 0.45;
                            right = 0.12;
                            showMateri();
                          });
                        } else if (states == 1) {
                          setState(() {
                            print("btn_back_clicked_1");
                            states = 0;
                            top = 0.25;
                            right = 0.18;
                            showMateri();
                          });
                        } else {
                          setState(() {
                            print("btn_back_clicked_else");
                            states = 0;
                            showMateri();
                          });
                        }
                      },
                      child: Container(
                        width: 0.25.sw,
                        height: 0.07.sh,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(54, 37, 35, 1),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5.0,
                                  color: Colors.black12,
                                  spreadRadius: 4.0,
                                  offset: Offset(0, 2))
                            ]),
                        child: Center(
                            child: Text(
                          "Back",
                          style: TextStyle(
                              color: Color.fromRGBO(227, 205, 148, 1),
                              fontWeight: FontWeight.w700),
                        )),
                      ),
                    ),
                  ),
                  10.verticalSpace,
                  RotatedBox(
                    quarterTurns: 1,
                    child: InkWell(
                      onTap: () {
                        if (states == 0) {
                          setState(() {
                            print("btn_next_clicked_0");
                            states = 1;
                            top = 0.45;
                            right = 0.12;
                            showMateri();
                          });
                        } else if (states == 1) {
                          setState(() {
                            print("btn_next_clicked_1");
                            states = 0;
                            top = 0.25;
                            right = 0.18;
                            showMateri();
                          });
                        } else {
                          setState(() {
                            print("btn_next_clicked_else");
                            states = 0;
                            showMateri();
                          });
                        }
                      },
                      child: Container(
                        width: 0.25.sw,
                        height: 0.07.sh,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(227, 205, 148, 1),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5.0,
                                  color: Colors.black12,
                                  spreadRadius: 2.0,
                                  offset: Offset(0, 2))
                            ]),
                        child: Center(
                            child: Text(
                          "Next",
                          style: TextStyle(
                              color: Color.fromRGBO(54, 37, 35, 1),
                              fontWeight: FontWeight.w700),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(top: 0.25.sh, right: 0.18.sw),
            //   child: Align(
            //     alignment: Alignment.topRight,
            //     child: RotatedBox(
            //       quarterTurns: 1,
            //       child: Image.asset(
            //         "assets/walk.gif",
            //         height: 0.15.sh,
            //       ),
            //     ),
            //   ),
            // )
          ],
        ));
  }
}
