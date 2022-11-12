import 'package:ansory/data/data.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GalleryDetail extends StatefulWidget {
  final String title;
  const GalleryDetail(this.title, {Key? key}) : super(key: key);

  @override
  State<GalleryDetail> createState() => _GalleryDetailState();
}

class _GalleryDetailState extends State<GalleryDetail> {
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
              CarouselSlider(
                options: CarouselOptions(
                    height: 0.7.sh,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 8),
                    autoPlayAnimationDuration: Duration(seconds: 3)),
                items: widget.title == "Album Masjid"
                    ? index_masjid.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                  width: 1.sw,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
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
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                          child: Image.asset(
                                            "assets/" + album_masjid[i],
                                            fit: BoxFit.fill,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 0.05.sw, right: 0.05.sw),
                                        child: Container(
                                          width: 0.7.sw,
                                          child: Text(
                                            deskripsi_masjid[i],
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(fontSize: 16.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            );
                          },
                        );
                      }).toList()
                    : widget.title == "Album Makam"
                        ? index_makam.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                      width: 1.sw,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 5.0,
                                                color: Colors.black12,
                                                spreadRadius: 5.0,
                                                offset: Offset(0, 2))
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ClipRRect(
                                              child: Image.asset(
                                                "assets/" + album_makam[i],
                                                fit: BoxFit.fill,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 0.05.sw, right: 0.05.sw),
                                            child: Container(
                                              width: 0.7.sw,
                                              child: Text(
                                                deskripsi_makam[i],
                                                textAlign: TextAlign.justify,
                                                style:
                                                    TextStyle(fontSize: 16.0),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                );
                              },
                            );
                          }).toList()
                        : widget.title == "Album Mata Air"
                            ? index_sumur.map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                          width: 1.sw,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 5.0,
                                                    color: Colors.black12,
                                                    spreadRadius: 5.0,
                                                    offset: Offset(0, 2))
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ClipRRect(
                                                  child: Image.asset(
                                                    "assets/" + album_sumur[i],
                                                    fit: BoxFit.fill,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 0.05.sw,
                                                    right: 0.05.sw),
                                                child: Container(
                                                  width: 0.7.sw,
                                                  child: Text(
                                                    deskripsi_sumur[i],
                                                    textAlign:
                                                        TextAlign.justify,
                                                    style: TextStyle(
                                                        fontSize: 16.0),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                    );
                                  },
                                );
                              }).toList()
                            : widget.title == "Album Keterampilan"
                                ? index_keterampilan.map((i) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                              width: 1.sw,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 5.0),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        blurRadius: 5.0,
                                                        color: Colors.black12,
                                                        spreadRadius: 5.0,
                                                        offset: Offset(0, 2))
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: ClipRRect(
                                                      child: Image.asset(
                                                        "assets/" +
                                                            album_keterampilan[
                                                                i],
                                                        fit: BoxFit.fill,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 0.05.sw,
                                                        right: 0.05.sw),
                                                    child: Container(
                                                      width: 0.7.sw,
                                                      child: Text(
                                                        deskripsi_keterampilan[
                                                            i],
                                                        textAlign:
                                                            TextAlign.justify,
                                                        style: TextStyle(
                                                            fontSize: 16.0),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        );
                                      },
                                    );
                                  }).toList()
                                : index_psa.map((i) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                              width: 1.sw,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 5.0),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        blurRadius: 5.0,
                                                        color: Colors.black12,
                                                        spreadRadius: 5.0,
                                                        offset: Offset(0, 2))
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: ClipRRect(
                                                      child: Image.asset(
                                                        "assets/" +
                                                            album_psa[i],
                                                        fit: BoxFit.fill,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 0.05.sw,
                                                        right: 0.05.sw),
                                                    child: Container(
                                                      width: 0.7.sw,
                                                      child: Text(
                                                        deskripsi_psa[i],
                                                        textAlign:
                                                            TextAlign.justify,
                                                        style: TextStyle(
                                                            fontSize: 16.0),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        );
                                      },
                                    );
                                  }).toList(),
              )
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
                        widget.title,
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
