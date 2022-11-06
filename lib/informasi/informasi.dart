import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Information extends StatefulWidget {
  const Information({Key? key}) : super(key: key);

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
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
              Text("Petunjuk Pengunaan",
                  style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp)),
              15.verticalSpace,
              Padding(
                padding: EdgeInsets.only(left: 0.05.sw),
                child: Container(
                    width: 1.sw,
                    height: 0.07.sh,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("1. Pilih menu peta"),
                        10.horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [Icon(Icons.map_sharp), Text("Peta")],
                        ),
                      ],
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(left: 0.05.sw),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("2. Pilih menu "),
                      Text(
                        "next",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(" untuk memunculkan"),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 0.05.sw),
                child: Container(
                  width: 0.9.sw,
                  child: Text(
                      "animasi pemandu dan materi dalam memulai petualangan"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 0.05.sw, top: 0.01.sh),
                child: Row(
                  children: [
                    Container(
                      width: 0.2.sw,
                      height: 0.05.sh,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(54, 37, 35, 1),
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
                        "Back",
                        style: TextStyle(
                            color: Color.fromRGBO(227, 205, 148, 1),
                            fontWeight: FontWeight.w700),
                      )),
                    ),
                    10.horizontalSpace,
                    Container(
                      width: 0.2.sw,
                      height: 0.05.sh,
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
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 0.05.sw, top: 0.02.sh),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 0.9.sw,
                    child: Text(
                        "3. Selesaikan misi petualangan di setiap pos dan kerjakan pertanyaan evaluasi",
                        textAlign: TextAlign.left),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 0.05.sw, top: 0.01.sh),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 0.2.sw,
                    height: 0.2.sw,
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
                      5.verticalSpace,
                      Text(
                        "Evaluasi",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10.sp,
                            // fontFamily: 'Inter',
                            fontWeight: FontWeight.w600),
                      ),
                      5.verticalSpace,
                      Image.asset(
                        "assets/checklist.png",
                        width: 35.w,
                        height: 35.w,
                      ),
                    ]),
                  ),
                ),
              ),
              15.verticalSpace,
              Text("Menu Alternatif",
                  style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp)),
              10.verticalSpace,
              Padding(
                padding: EdgeInsets.only(left: 0.05.sw, top: 0.01.sh),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Icon(Icons.map_sharp), Text("Peta")],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 0.05.sw, top: 0.01.sh),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 0.9.sw,
                    child: Text(
                        "Menu Peta : Menampilkan visual area situs dan informasi pendukung di sekitarnya"),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 0.05.sw, top: 0.01.sh),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Icon(Icons.home), Text("Home")],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 0.05.sw, top: 0.01.sh),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 0.9.sw,
                    child:
                        Text("Menu Home : Menampilkan halaman awal informasi"),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 0.05.sw, top: 0.01.sh),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Icon(Icons.account_circle), Text("Profile")],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 0.05.sw, top: 0.01.sh),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 0.9.sw,
                    child: Text(
                        "Menu Profile : Menampilkan halaman profil penulis dan pengembang"),
                  ),
                ),
              ),
              18.verticalSpace,
              Container(
                width: 0.85.sw,
                height: 0.25.sh,
                // 227, 205, 148
                decoration: BoxDecoration(
                    color: Color.fromRGBO(227, 205, 148, 1),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5.0,
                          color: Colors.black12,
                          spreadRadius: 5.0,
                          offset: Offset(0, 2))
                    ]),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 0.05.sw, top: 0.02.sh),
                        child: Text(
                          "A. Kompetensi Dasar",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 12.sp),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 0.05.sw, top: 0.02.sh),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "3.8 ",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Container(
                              width: 0.7.sw,
                              child: Text(
                                "Menganalisis karakteristik kehidupan masyarakat, pemerintahan, dan kebudayaan pada masa kerajaan-kerajaan islam Di Indonesia dan menunjukkan contoh bukti yang masih berlaku pada kehidupan masyarakat Indonesia masa kini.",
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),
                // color: Colors.brown,
              ),
              10.verticalSpace,
              Container(
                width: 0.85.sw,
                height: 0.35.sh,
                // 227, 205, 148
                decoration: BoxDecoration(
                    color: Color.fromRGBO(227, 205, 148, 1),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5.0,
                          color: Colors.black12,
                          spreadRadius: 5.0,
                          offset: Offset(0, 2))
                    ]),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 0.05.sw, top: 0.02.sh),
                        child: Text(
                          "B. Indikator Pencapaian Kompetensi",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 12.sp),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 0.05.sw, top: 0.02.sh),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "3.8.1 ",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Container(
                              width: 0.65.sw,
                              child: Text(
                                "Menjelaskan proses islamisasi di Wilayah Sendang Duwur Di Kabupaten Lamongan.",
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 0.05.sw, top: 0.01.sh),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "3.8.2 ",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Container(
                              width: 0.65.sw,
                              child: Text(
                                "Menunjukkan bukti-bukti peninggalan proses islamisasi pada Situs Sendang Duwur Di Kabupaten Lamongan.",
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 0.05.sw, top: 0.01.sh),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "3.8.3 ",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Container(
                              width: 0.65.sw,
                              child: Text(
                                "Menganalisis bukti-bukti akulturasi kebudayaan yang masih berlaku pada masyarakat di sekitar situs Sendang Duwur Di Kabupaten Lamongan.",
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                // color: Colors.brown,
              ),
              10.verticalSpace,
              Container(
                width: 0.85.sw,
                height: 0.55.sh,
                // 227, 205, 148
                decoration: BoxDecoration(
                    color: Color.fromRGBO(227, 205, 148, 1),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5.0,
                          color: Colors.black12,
                          spreadRadius: 5.0,
                          offset: Offset(0, 2))
                    ]),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 0.05.sw, top: 0.02.sh),
                        child: Text(
                          "C. Tujuan Pembelajaran",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 12.sp),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 0.05.sw, top: 0.02.sh),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "1. ",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  width: 0.7.sw,
                                  child: RichText(
                                      textAlign: TextAlign.justify,
                                      text: TextSpan(children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                "Siswa dapat menjelaskan proses islamisasi di wilayah Sendang Duwur Di Kabupaten Lamongan melalui penggunaan aplikasi ",
                                            style:
                                                TextStyle(color: Colors.black)),
                                        TextSpan(
                                          text:
                                              "“ANSORY MAPS” (Android studio history maps)",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontStyle: FontStyle.italic),
                                        ),
                                        TextSpan(
                                          text: " dengan baik.",
                                          style: TextStyle(color: Colors.black),
                                        )
                                      ])),
                                  // Text(
                                  //   "Siswa dapat menjelaskan proses islamisasi di wilayah Sendang Duwur Di Kabupaten Lamongan melalui penggunaan aplikasi ",
                                  //   textAlign: TextAlign.justify,
                                  // ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 0.05.sw, top: 0.02.sh),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "2. ",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  width: 0.7.sw,
                                  child: RichText(
                                      textAlign: TextAlign.justify,
                                      text: TextSpan(children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                "Siswa dapat menunjukkan bukti-bukti peninggalan dalam proses masuknya islam pada Situs Sendang Duwur Di Kabupaten Lamongan penggunaan aplikasi ",
                                            style:
                                                TextStyle(color: Colors.black)),
                                        TextSpan(
                                          text:
                                              "“ANSORY MAPS” (Android studio history maps)",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontStyle: FontStyle.italic),
                                        ),
                                        TextSpan(
                                          text: " dengan baik.",
                                          style: TextStyle(color: Colors.black),
                                        )
                                      ])),
                                  // Text(
                                  //   "Siswa dapat menjelaskan proses islamisasi di wilayah Sendang Duwur Di Kabupaten Lamongan melalui penggunaan aplikasi ",
                                  //   textAlign: TextAlign.justify,
                                  // ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 0.05.sw, top: 0.02.sh),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "3. ",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  width: 0.7.sw,
                                  child: RichText(
                                      textAlign: TextAlign.justify,
                                      text: TextSpan(children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                "Siswa dapat menganalisis bukti-bukti akulturasi kebudayaan yang masih berlaku pada masyarakat di sekitar Situs Sendang Duwur Di Kabupaten Lamongan penggunaan aplikasi ",
                                            style:
                                                TextStyle(color: Colors.black)),
                                        TextSpan(
                                          text:
                                              "“ANSORY MAPS” (Android studio history maps)",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontStyle: FontStyle.italic),
                                        ),
                                        TextSpan(
                                          text: " dengan baik.",
                                          style: TextStyle(color: Colors.black),
                                        )
                                      ])),
                                  // Text(
                                  //   "Siswa dapat menjelaskan proses islamisasi di wilayah Sendang Duwur Di Kabupaten Lamongan melalui penggunaan aplikasi ",
                                  //   textAlign: TextAlign.justify,
                                  // ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ]),
                // color: Colors.brown,
              ),
              10.verticalSpace,
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
                        "Informasi",
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
