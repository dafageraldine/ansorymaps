import 'package:ansory/galeri/galeridetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PilihMateri extends StatefulWidget {
  final int states;
  const PilihMateri(this.states, {Key? key}) : super(key: key);

  @override
  State<PilihMateri> createState() => _PilihMateriState();
}

class _PilihMateriState extends State<PilihMateri> {
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
              0.14.sh.verticalSpace,
              Padding(
                padding: EdgeInsets.only(left: 0.1.sw, right: 0.1.sw),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    width: 0.8.sw,
                    height: 0.3.sh,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5.0,
                              color: Colors.black12,
                              spreadRadius: 5.0,
                              offset: Offset(0, 2))
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(children: [
                      ClipRRect(
                        child: Image.asset(
                          widget.states == 0
                              ? "assets/m_0_3.png"
                              : "assets/m_1_0.png",
                          width: 0.8.sw,
                          height: 0.23.sh,
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 0.02.sh),
                        child: Text(
                          widget.states == 0
                              ? "Latar Belakang Proses Islamisasi"
                              : "Biografi Raden Noer Rahmat",
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.w500),
                        ),
                      )
                    ]),
                  ),
                ),
              ),
              widget.states == 1
                  ? Padding(
                      padding: EdgeInsets.only(
                          left: 0.1.sw, top: 0.02.sh, right: 0.1.sw),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          width: 0.8.sw,
                          height: 0.3.sh,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 5.0,
                                    color: Colors.black12,
                                    spreadRadius: 5.0,
                                    offset: Offset(0, 2))
                              ],
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(children: [
                            ClipRRect(
                              child: Image.asset(
                                "assets/m_1_1.png",
                                width: 0.8.sw,
                                height: 0.23.sh,
                                fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 0.02.sh),
                              child: Text(
                                "Bentuk Dakwah Akulturasi dan Peninggalan Secara Fisik",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ]),
                        ),
                      ),
                    )
                  : Text(""),
              widget.states == 1
                  ? Padding(
                      padding: EdgeInsets.only(
                          left: 0.1.sw,
                          top: 0.02.sh,
                          right: 0.1.sw,
                          bottom: 0.02.sh),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          width: 0.8.sw,
                          height: 0.3.sh,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 5.0,
                                    color: Colors.black12,
                                    spreadRadius: 5.0,
                                    offset: Offset(0, 2))
                              ],
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(children: [
                            ClipRRect(
                              child: Image.asset(
                                "assets/m_1_2.png",
                                width: 0.8.sw,
                                height: 0.23.sh,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 0.02.sh),
                              child: Text(
                                "Bentuk Dakwah Akulturasi dan Peninggalan Secara Ajaran",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ]),
                        ),
                      ),
                    )
                  : Text(""),
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
                        "Pilih Materi",
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
