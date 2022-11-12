import 'package:ansory/galeri/galeridetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
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
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                GalleryDetail("Album Masjid")));
                  },
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
                          "assets/am_1.jpg",
                          width: 0.8.sw,
                          height: 0.23.sh,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 0.02.sh),
                        child: Text(
                          "Bangunan Masjid",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w500),
                        ),
                      )
                    ]),
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 0.1.sw, top: 0.02.sh, right: 0.1.sw),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                GalleryDetail("Album Makam")));
                  },
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
                          "assets/km_3.jpg",
                          width: 0.8.sw,
                          height: 0.23.sh,
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 0.02.sh),
                        child: Text(
                          "Kompleks Makam",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w500),
                        ),
                      )
                    ]),
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 0.1.sw, top: 0.02.sh, right: 0.1.sw),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                GalleryDetail("Album Mata Air")));
                  },
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
                          "assets/foto_soal_no_9.jpg",
                          width: 0.8.sw,
                          height: 0.23.sh,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 0.02.sh),
                        child: Text(
                          "Sumber mata air / Sumur",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w500),
                        ),
                      )
                    ]),
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 0.1.sw, top: 0.02.sh, right: 0.1.sw),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                GalleryDetail("Album Keterampilan")));
                  },
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
                          "assets/k_1.jpg",
                          width: 0.8.sw,
                          height: 0.23.sh,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 0.02.sh),
                        child: Text(
                          "Keterampilan",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w500),
                        ),
                      )
                    ]),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 0.1.sw, top: 0.02.sh, right: 0.1.sw, bottom: 0.02.sh),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                GalleryDetail("Album Peninggalan")));
                  },
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
                          "assets/psa_1.jpg",
                          width: 0.8.sw,
                          height: 0.23.sh,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 0.02.sh),
                        child: Text(
                          "Peninggalan Secara ajaran",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w500),
                        ),
                      )
                    ]),
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
                        "Galeri",
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
