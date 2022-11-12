import 'dart:convert';

import 'package:ansory/login/login.dart';
import 'package:ansory/profile/profilepengembang.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../bottombar.dart';
import '../data/data.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  showAlertDialog(BuildContext context, String info, String ids) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "Tidak",
        style: TextStyle(color: Colors.grey[400]),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        // await delete();
      },
    );

    Widget continueButton = TextButton(
      child: Text(
        "Ya",
        style: TextStyle(color: Color.fromRGBO(187, 121, 91, 1)),
      ),
      onPressed: () async {
        Navigator.of(context).pop();
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('uname');
        await prefs.remove('pass');
        dataUser.clear();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));

        // await deletedata(ids);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Warning"),
      content: Text(info),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
              child: Column(
            children: [
              0.12.sh.verticalSpace,
              Padding(
                padding: EdgeInsets.only(left: 0.1.sw),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Pengembang : ",
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp),
                  ),
                ),
              ),
              15.verticalSpace,
              Padding(
                padding: EdgeInsets.only(left: 0.18.sw),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Syihabuddin",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
                  ),
                ),
              ),
              15.verticalSpace,
              Padding(
                padding: EdgeInsets.only(left: 0.18.sw),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "NIM 170731637629",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
                  ),
                ),
              ),
              15.verticalSpace,
              Padding(
                padding: EdgeInsets.only(left: 0.18.sw),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Prodi. S1 Pendidikan Sejarah",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
                  ),
                ),
              ),
              15.verticalSpace,
              Padding(
                padding: EdgeInsets.only(left: 0.1.sw),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Tenaga Ahli : ",
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp),
                  ),
                ),
              ),
              15.verticalSpace,
              Padding(
                padding: EdgeInsets.only(left: 0.18.sw),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Muhammad Dafa Geraldine Putra Malik",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
                  ),
                ),
              ),
            ],
          )),
          Container(
            width: 1.sw,
            height: 0.12.sh,
            color: Color.fromRGBO(197, 133, 95, 1),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 0.05.sh, left: 0.1.sw),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 0.12.sw,
                      height: 0.1.sw,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 20.sp,
                        color: Color.fromRGBO(197, 133, 95, 1),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    45.verticalSpace,
                    Center(
                      child: Text(
                        "Ubah Profile",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            // fontFamily: 'Inter',
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
