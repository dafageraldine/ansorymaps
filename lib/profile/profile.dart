import 'dart:convert';

import 'package:ansory/login/login.dart';
import 'package:ansory/profile/editprofile.dart';
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

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            width: 1.sw,
            height: 0.2.sh,
            color: Color.fromRGBO(197, 133, 95, 1),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              30.verticalSpace,
              Padding(
                padding: EdgeInsets.only(left: 0.1.sw),
                child: Text(
                  dataUser[0].nama,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp),
                ),
              ),
              10.verticalSpace,
              Padding(
                padding: EdgeInsets.only(
                  left: 0.1.sw,
                ),
                child: Text(
                  dataUser[0].kelas == "admin"
                      ? "Anda login sebagai admin"
                      : "Kelas : " + dataUser[0].kelas,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp),
                ),
              ),
              10.verticalSpace,
              Padding(
                padding: EdgeInsets.only(left: 0.1.sw),
                child: Text(
                  dataUser[0].absen == "admin"
                      ? ""
                      : "Absen : " + dataUser[0].absen,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp),
                ),
              )
            ]),
          ),
          20.verticalSpace,
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePengembang()));
            },
            child: Container(
              width: 0.8.sw,
              height: 0.06.sh,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5.0,
                      color: Colors.black12,
                      spreadRadius: 5.0,
                      offset: Offset(0, 2))
                ],
              ),
              child: Center(
                  child: Text(
                "Profil pengembang",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
              )),
            ),
          ),
          20.verticalSpace,
          InkWell(
            onTap: () {
              if (dataUser[0].username == "admin") {
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfile()));
              }
            },
            child: Container(
              width: 0.8.sw,
              height: 0.06.sh,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5.0,
                      color: Colors.black12,
                      spreadRadius: 5.0,
                      offset: Offset(0, 2))
                ],
              ),
              child: Center(
                  child: Text(
                dataUser[0].username == "admin"
                    ? "Manage data siswa"
                    : "ubah profile",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
              )),
            ),
          ),
          20.verticalSpace,
          InkWell(
            onTap: () {
              showAlertDialog(context, "Apakah anda yakin ingin keluar ?", "");
            },
            child: Container(
              width: 0.8.sw,
              height: 0.06.sh,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5.0,
                      color: Colors.black12,
                      spreadRadius: 5.0,
                      offset: Offset(0, 2))
                ],
              ),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.exit_to_app),
                  10.horizontalSpace,
                  Text(
                    "Keluar",
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
                  ),
                ],
              )),
            ),
          )
        ],
      )),
    );
  }
}
