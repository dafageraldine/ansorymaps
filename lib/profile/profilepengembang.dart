import 'dart:convert';

import 'package:ansory/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../bottombar.dart';
import '../data/data.dart';

class ProfilePengembang extends StatefulWidget {
  const ProfilePengembang({Key? key}) : super(key: key);

  @override
  State<ProfilePengembang> createState() => _ProfilePengembangState();
}

class _ProfilePengembangState extends State<ProfilePengembang> {
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
              Padding(
                padding: EdgeInsets.only(top: 0.12.sh),
                child: Container(
                  width: 1.sw,
                  height: 0.3.sh,
                  color: Color.fromRGBO(197, 133, 95, 1),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        10.verticalSpace,
                        Center(
                          child: ClipRRect(
                              child: Image.asset(
                                "assets/pp.jpg",
                                width: 0.5.sw,
                                height: 0.5.sw,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(20)),
                        )
                      ]),
                ),
              ),
              20.verticalSpace,
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
                        "Pengembang",
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
