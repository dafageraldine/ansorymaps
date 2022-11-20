import 'package:ansory/daftarpustaka/daftarpustaka.dart';
import 'package:ansory/data/data.dart';
import 'package:ansory/evaluasi/evaluasi.dart';
import 'package:ansory/galeri/galeri.dart';
import 'package:ansory/informasi/informasi.dart';
import 'package:ansory/login/login.dart';
import 'package:ansory/report/reportsiswa.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          Image.asset(
            fit: BoxFit.fill,
            "assets/banner.png",
            width: 1.sw,
            height: 0.28.sh,
          ),
          20.verticalSpace,
          Padding(
            padding: EdgeInsets.only(left: 0.05.sw),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Menu",
                  style: TextStyle(fontWeight: FontWeight.w800),
                )),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.02.sh),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Information()));
                  },
                  child: Container(
                    width: 0.35.sw,
                    height: 0.35.sw,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5.0,
                              color: Colors.black12,
                              spreadRadius: 5.0,
                              offset: Offset(0, 2))
                        ]),
                    child: Column(children: [
                      10.verticalSpace,
                      Text(
                        "informasi",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                            // fontFamily: 'Inter',
                            fontWeight: FontWeight.w600),
                      ),
                      10.verticalSpace,
                      Image.asset(
                        "assets/information.png",
                        width: 70.w,
                        height: 70.w,
                      ),
                    ]),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // cekakses("report_at_ro");

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Gallery()));
                  },
                  child: Container(
                    width: 0.35.sw,
                    height: 0.35.sw,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5.0,
                              color: Colors.black12,
                              spreadRadius: 5.0,
                              offset: Offset(0, 2))
                        ]),
                    child: Column(children: [
                      10.verticalSpace,
                      Text(
                        "Galeri",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                            // fontFamily: 'Inter',
                            fontWeight: FontWeight.w600),
                      ),
                      10.verticalSpace,
                      Image.asset(
                        "assets/gallery.png",
                        width: 70.w,
                        height: 70.w,
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.02.sh),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Evaluation()));

                    // cekakses("report_at_ro");
                  },
                  child: Container(
                    width: 0.35.sw,
                    height: 0.35.sw,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5.0,
                              color: Colors.black12,
                              spreadRadius: 5.0,
                              offset: Offset(0, 2))
                        ]),
                    child: Column(children: [
                      // Image.asset(
                      //   "assets/report.png",
                      //   width: 70.w,
                      //   height: 70.w,
                      // ),
                      10.verticalSpace,
                      Text(
                        "Evaluasi",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                            // fontFamily: 'Inter',
                            fontWeight: FontWeight.w600),
                      ),
                      10.verticalSpace,
                      Image.asset(
                        "assets/checklist.png",
                        width: 70.w,
                        height: 70.w,
                      ),
                    ]),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DaftarPustaka()));
                  },
                  child: Container(
                    width: 0.35.sw,
                    height: 0.35.sw,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5.0,
                              color: Colors.black12,
                              spreadRadius: 5.0,
                              offset: Offset(0, 2))
                        ]),
                    child: Column(children: [
                      // Image.asset(
                      //   "assets/report.png",
                      //   width: 70.w,
                      //   height: 70.w,
                      // ),
                      10.verticalSpace,
                      Text(
                        "Daftar Pustaka",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                            // fontFamily: 'Inter',
                            fontWeight: FontWeight.w600),
                      ),
                      10.verticalSpace,
                      Image.asset(
                        "assets/books.png",
                        width: 70.w,
                        height: 70.w,
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
          20.verticalSpace,
          dataUser[0].username != "admin"
              ? Text("")
              : Padding(
                  padding: EdgeInsets.only(left: 0.05.sw),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Nilai",
                          style: TextStyle(fontWeight: FontWeight.w800))),
                ),
          dataUser[0].username != "admin" ? Text("") : 15.verticalSpace,
          dataUser[0].username != "admin"
              ? Text("")
              : Padding(
                  padding: EdgeInsets.only(left: 0.1.sw),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReportSiswa()));
                      },
                      child: Container(
                          width: 0.5.sw,
                          height: 0.25.sw,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 2.0,
                                    color: Colors.black12,
                                    spreadRadius: 5.0,
                                    offset: Offset(0, 2))
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                "assets/score.png",
                                width: 50.w,
                                height: 50.w,
                              ),
                              Text(
                                "Lihat Nilai Siswa",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                    // fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          )
                          //  Column(children: [
                          //   10.verticalSpace,

                          //   10.verticalSpace,

                          // ]),
                          ),
                    ),
                  ),
                ),
          dataUser[0].username != "admin" ? Text("") : 20.verticalSpace
        ]),
      ),
    );
  }
}
