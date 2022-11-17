import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../data/data.dart';

class Evaluation extends StatefulWidget {
  const Evaluation({Key? key}) : super(key: key);

  @override
  State<Evaluation> createState() => _EvaluationState();
}

class _EvaluationState extends State<Evaluation> {
  var soal = 1;
  var nilai = 0.0;
  var salah = 0.0;
  var benar = 0.0;
  var isloading = 1;
  var iserror = 0;

  // final kunci = [
  //   "15-17M",
  //   "Syeh Abdul Qahar Bin Malik Al-Bagdadi dan Dewi Sukarsih",
  //   "Cara pernikahan",
  //   "i,ii,v",
  //   "Manut Ilining Banyu",
  //   "Lontar dan Wilus",
  //   "Sunan Drajat",
  //   "Memboyong salah satu masjid kembar yang berada Di Mantingan Jepara menuju ke Bukit Amitunon dalam waktu semalam tanpa bantuan orang lain.",
  //   "Untuk di jual kepada warga sekitar yang notabennya merupakan bukit kapur yang sulit persediaan air pada musim kemarau",
  //   "Tempat tertinggi sehingga ketika mengumandangkan adzan dapat di dengar oleh seluruh warga desa",
  //   "Karena mendapat pulung untuk berdakwah dengan cara tersebut",
  //   "1520 M dan 5 Agustus 1585 M",
  //   "Sebagai pembatas menuju halaman yang lebih suci sehingga dalam melewatinya harus membungkuk sebagai bentuk kesopanan",
  //   "i,ii,iii,iv,v",
  //   "Adanya Sumur Paidon di bagian halaman kedua Komplek Makam Sunan Sendang Duwur sebagai air penyembuh segala macam penyakit",
  //   "Menaruh sesaji di sekitar kompleks makam untuk mencari berkah dan bentuk rasa syukur",
  //   "Menyamarkan wujud asli dari benda hidup yang di ukir agar tidak bertentangan dengan nilai-nilai islami",
  //   "Mlakuo kang bener lan Ilingo wong kang sak mburimu",
  //   "Bentuk rasa syukur bersama atas nikmat yang diberikan oleh Allah SWT",
  //   "iii,iv,v"
  // ];
  var key = [3, 1, 1, 3, 2, 4, 5, 1, 5, 3, 3, 3, 2, 5, 3, 2, 1, 4, 2, 3];
  var selected = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  @override
  void initState() {
    if (dataUser[0].username != "admin") {
      cekisalreadytes();
    } else {
      setState(() {
        isloading = 0;
        iserror = 0;
      });
    }
    // TODO: implement initState
    super.initState();
  }

  Future<void> cekisalreadytes() async {
    try {
      var body = {
        "username": dataUser[0].username.toString(),
      };
      http.Response cek =
          await http.post(Uri.parse(baseurl + "getuserdata"), body: body);
      print(cek.body);
      var data = json.decode(cek.body);
      if (data["data"].length > 0) {
        if (data["data"][0]["nilai"].toString() == "belum tes") {
          setState(() {
            isloading = 0;
            iserror = 0;
          });
        } else {
          nilai = double.parse(data["data"][0]["nilai"]);
          print(nilai);
          salah = (100.0 - nilai) / 5.0;
          benar = 20.0 - salah;
          setState(() {
            isloading = 2;
            iserror = 0;
          });
        }
      }
    } catch (e) {
      setState(() {
        isloading = 0;
        iserror = 1;
      });
      Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: Colors.black,
          textColor: Colors.white);
    }
  }

  void _showDialogloading(judul, konten) {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: new Text(
              judul,
              textAlign: TextAlign.center,
            ),
            content: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 0.2.sw),
                  child: LoadingAnimationWidget.inkDrop(
                    color: Color.fromRGBO(197, 133, 95, 1),
                    size: 0.1.sh,
                  ),
                )
              ],
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              // new FlatButton(
              //   child: new Text(
              //     "Close",
              //     style: TextStyle(color: Color.fromRGBO(16, 34, 156, 1)),
              //   ),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              // ),
            ],
          ),
        );
      },
    );
  }

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
        style: TextStyle(
          color: Color.fromRGBO(227, 205, 148, 1),
        ),
      ),
      onPressed: () async {
        Navigator.of(context, rootNavigator: true).pop();
        await getNilai();
        // await delete();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("perhatian"),
      content: Text("apakah kamu yakin untuk submit ?"),
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

  Future<void> getNilai() async {
    nilai = 0.0;
    isloading = 1;
    setState(() {});
    var flag = 0;
    for (var i = 0; i < key.length; i++) {
      if (selected[i] == 0) {
        flag = 1;
      }
    }
    if (flag == 1) {
      isloading = 0;
      setState(() {});
      Fluttertoast.showToast(
          msg: "Masih ada soal yang belum diselesaikan !",
          backgroundColor: Colors.black,
          textColor: Colors.white);
    } else {
      _showDialogloading("memeriksa jawaban !", "mengambil data !");
      for (var i = 0; i < key.length; i++) {
        if (key[i] == selected[i]) {
          nilai = nilai + 5.0;
        }
      }
      if (nilai == 0.0) {
        salah = 20.0;
        benar = 0.0;
      } else {
        salah = (100.0 - nilai) / 5.0;
        benar = nilai / 5.0;
      }
      print(nilai);
      try {
        var body = {
          "username": dataUser[0].username,
          "nilai": nilai.toString()
        };
        http.Response cek =
            await http.post(Uri.parse(baseurl + "insertnilai"), body: body);
        // print(cek.body);
        var data = json.decode(cek.body);
        if (data["data"] == "sukses") {
          setState(() {});
          Navigator.of(context).pop();
          isloading = 2;
        }
      } catch (e) {
        setState(() {
          isloading = 0;
        });
        Navigator.of(context).pop();
        Fluttertoast.showToast(
            msg: e.toString(),
            backgroundColor: Colors.black,
            textColor: Colors.white);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        SingleChildScrollView(
          child: iserror == 1
              ? Column(
                  children: [
                    0.12.sh.verticalSpace,
                    Padding(
                      padding: EdgeInsets.only(left: 0.1.sw),
                      child: Container(
                        width: 0.8.sw,
                        child: Text(
                          "Gagal mendapatkan data silahkan cek koneksi internet mu !",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14.sp),
                        ),
                      ),
                    ),
                    20.verticalSpace,
                    Padding(
                      padding: EdgeInsets.only(left: 0.1.sw),
                      child: InkWell(
                        onTap: () {
                          cekisalreadytes();
                        },
                        child: Container(
                          width: 0.4.sw,
                          height: 0.15.sw,
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
                          child: Padding(
                            padding: EdgeInsets.all(0.05.sw),
                            child: Center(
                              child: Text(
                                "refresh",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 180, 136, 14)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              : isloading == 2
                  ? Column(children: [
                      0.12.sh.verticalSpace,
                      Padding(
                        padding: EdgeInsets.only(left: 0.1.sw),
                        child: Container(
                          width: 0.8.sw,
                          child: Text(
                            "Hai " +
                                dataUser[0].nama +
                                " berikut adalah hasil tes kamu !",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14.sp),
                          ),
                        ),
                      ),
                      20.verticalSpace,
                      Padding(
                        padding: EdgeInsets.only(left: 0.1.sw),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 0.8.sw,
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
                              child: Padding(
                                padding: EdgeInsets.all(0.05.sw),
                                child: Center(
                                  child: Text(
                                    "Jumlah Jawaban benar : " +
                                        benar.round().toString(),
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            Color.fromARGB(255, 25, 209, 191)),
                                  ),
                                ),
                              ),
                            )),
                      ),
                      20.verticalSpace,
                      Padding(
                        padding: EdgeInsets.only(left: 0.1.sw),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 0.8.sw,
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
                              child: Padding(
                                padding: EdgeInsets.all(0.05.sw),
                                child: Center(
                                  child: Text(
                                      "Jumlah Jawaban salah : " +
                                          salah.round().toString(),
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromARGB(
                                              255, 224, 35, 35))),
                                ),
                              ),
                            )),
                      ),
                      20.verticalSpace,
                      Padding(
                        padding: EdgeInsets.only(left: 0.1.sw),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 0.8.sw,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 97, 87, 87),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 5.0,
                                        color: Colors.black12,
                                        spreadRadius: 5.0,
                                        offset: Offset(0, 2))
                                  ]),
                              child: Padding(
                                padding: EdgeInsets.all(0.05.sw),
                                child: Center(
                                  child: Text(
                                      "Nilai : " + nilai.round().toString(),
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white)),
                                ),
                              ),
                            )),
                      )
                    ])
                  : isloading == 1
                      ? Stack(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 0.4.sw, top: 0.5.sh),
                              child: LoadingAnimationWidget.threeArchedCircle(
                                color: Color.fromRGBO(233, 207, 146, 1),
                                size: 0.1.sh,
                              ),
                            )
                          ],
                        )
                      : Column(children: [
                          0.12.sh.verticalSpace,
                          Padding(
                            padding: EdgeInsets.only(left: 0.1.sw),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: 0.7.sw,
                                child: RichText(
                                    textAlign: TextAlign.justify,
                                    text: TextSpan(children: <TextSpan>[
                                      TextSpan(
                                          text: "Soal ke ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.sp)),
                                      TextSpan(
                                          text: soal.toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w800)),
                                      TextSpan(
                                          text: " dari ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.sp)),
                                      TextSpan(
                                          text: "20",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 14.sp)),
                                      // TextSpan(
                                      //   text: "“ANSORY MAPS” (Android studio history maps)",
                                      //   style: TextStyle(
                                      //       color: Colors.black, fontStyle: FontStyle.italic),
                                      // ),
                                      // TextSpan(
                                      //   text: " dengan baik.",
                                      //   style: TextStyle(color: Colors.black),
                                      // )
                                    ])),
                                // Text(
                                //   "Siswa dapat menjelaskan proses islamisasi di wilayah Sendang Duwur Di Kabupaten Lamongan melalui penggunaan aplikasi ",
                                //   textAlign: TextAlign.justify,
                                // ),
                              ),
                            ),
                          ),
                          10.verticalSpace,
                          soal == 1
                              ? Padding(
                                  padding: EdgeInsets.only(left: 0.1.sw),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 0.1.sw,
                                        child: Text("1. ",
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.black)),
                                      ),
                                      Container(
                                        width: 0.7.sw,
                                        child: RichText(
                                            textAlign: TextAlign.justify,
                                            text: TextSpan(children: <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      "Sejak Abad ke berapa Pantai Timur Utara Jawa Timur menjadi pelabuhan dagang internasional...",
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                              // TextSpan(
                                              //   text: "“ANSORY MAPS” (Android studio history maps)",
                                              //   style: TextStyle(
                                              //       color: Colors.black, fontStyle: FontStyle.italic),
                                              // ),
                                              // TextSpan(
                                              //   text: " dengan baik.",
                                              //   style: TextStyle(color: Colors.black),
                                              // )
                                            ])),
                                        // Text(
                                        //   "Siswa dapat menjelaskan proses islamisasi di wilayah Sendang Duwur Di Kabupaten Lamongan melalui penggunaan aplikasi ",
                                        //   textAlign: TextAlign.justify,
                                        // ),
                                      ),
                                    ],
                                  ),
                                )
                              : soal == 2
                                  ? Padding(
                                      padding: EdgeInsets.only(left: 0.1.sw),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 0.1.sw,
                                            child: Text("2. ",
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w800,
                                                    color: Colors.black)),
                                          ),
                                          Container(
                                            width: 0.7.sw,
                                            child: RichText(
                                                textAlign: TextAlign.justify,
                                                text: TextSpan(
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text:
                                                              "Raden Noer Rahmad merupakan keturunan Baghdad-Jawa Timur yang dilahirkan oleh pasangan yang bernama....",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black)),
                                                      // TextSpan(
                                                      //   text: "“ANSORY MAPS” (Android studio history maps)",
                                                      //   style: TextStyle(
                                                      //       color: Colors.black, fontStyle: FontStyle.italic),
                                                      // ),
                                                      // TextSpan(
                                                      //   text: " dengan baik.",
                                                      //   style: TextStyle(color: Colors.black),
                                                      // )
                                                    ])),
                                            // Text(
                                            //   "Siswa dapat menjelaskan proses islamisasi di wilayah Sendang Duwur Di Kabupaten Lamongan melalui penggunaan aplikasi ",
                                            //   textAlign: TextAlign.justify,
                                            // ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : soal == 3
                                      ? Padding(
                                          padding:
                                              EdgeInsets.only(left: 0.1.sw),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 0.1.sw,
                                                child: Text("3. ",
                                                    style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        color: Colors.black)),
                                              ),
                                              Container(
                                                width: 0.7.sw,
                                                child: RichText(
                                                    textAlign:
                                                        TextAlign.justify,
                                                    text: TextSpan(
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                              text:
                                                                  "Raden Noer Rahmad merupakan keturunan Bagdad-Jawa Timur, cara tersebut temasuk kategori proses islamisasi dengan cara.......",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black)),
                                                          // TextSpan(
                                                          //   text: "“ANSORY MAPS” (Android studio history maps)",
                                                          //   style: TextStyle(
                                                          //       color: Colors.black, fontStyle: FontStyle.italic),
                                                          // ),
                                                          // TextSpan(
                                                          //   text: " dengan baik.",
                                                          //   style: TextStyle(color: Colors.black),
                                                          // )
                                                        ])),
                                                // Text(
                                                //   "Siswa dapat menjelaskan proses islamisasi di wilayah Sendang Duwur Di Kabupaten Lamongan melalui penggunaan aplikasi ",
                                                //   textAlign: TextAlign.justify,
                                                // ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : soal == 4
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  left: 0.06.sw),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 0.1.sw,
                                                    child: Text("4. ",
                                                        style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color:
                                                                Colors.black)),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Container(
                                                        width: 0.7.sw,
                                                        child: RichText(
                                                            textAlign: TextAlign
                                                                .justify,
                                                            text: TextSpan(
                                                                children: <
                                                                    TextSpan>[
                                                                  TextSpan(
                                                                      text:
                                                                          "Cermatilah Peta Tersebut !",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.black)),
                                                                  // TextSpan(
                                                                  //   text: "“ANSORY MAPS” (Android studio history maps)",
                                                                  //   style: TextStyle(
                                                                  //       color: Colors.black, fontStyle: FontStyle.italic),
                                                                  // ),
                                                                  // TextSpan(
                                                                  //   text: " dengan baik.",
                                                                  //   style: TextStyle(color: Colors.black),
                                                                  // )
                                                                ])),
                                                        // Text(
                                                        //   "Siswa dapat menjelaskan proses islamisasi di wilayah Sendang Duwur Di Kabupaten Lamongan melalui penggunaan aplikasi ",
                                                        //   textAlign: TextAlign.justify,
                                                        // ),
                                                      ),
                                                      5.verticalSpace,
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                style:
                                                                    BorderStyle
                                                                        .solid,
                                                                width: 4)),
                                                        child: Image.asset(
                                                          fit: BoxFit.fill,
                                                          "assets/peta_soal_no_4.jpg",
                                                          width: 0.7.sw,
                                                          height: 0.25.sh,
                                                        ),
                                                      ),
                                                      5.verticalSpace,
                                                      Container(
                                                        width: 0.7.sw,
                                                        child: RichText(
                                                            textAlign: TextAlign
                                                                .justify,
                                                            text: TextSpan(
                                                                children: <
                                                                    TextSpan>[
                                                                  TextSpan(
                                                                    text:
                                                                        "Pesisir Pantai Utara Jawa Timur menjadi saksi hiruk-pikuk kapal-kapal asing yang bersandar di pelabuhan untuk berniaga dalam kurun waktu tertentu :",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                  )
                                                                ])),
                                                      ),
                                                      8.verticalSpace,
                                                      Container(
                                                        width: 0.7.sw,
                                                        child: RichText(
                                                            textAlign: TextAlign
                                                                .justify,
                                                            text: TextSpan(
                                                                children: <
                                                                    TextSpan>[
                                                                  TextSpan(
                                                                    text:
                                                                        "i) Pesisir Pantai Utara Jawa Timur memiliki pelabuhan-pelabuhan yang besar sehingga kapal-kapal asing yang besar dapat bersandar ",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                  )
                                                                ])),
                                                      ),
                                                      8.verticalSpace,
                                                      Container(
                                                        width: 0.7.sw,
                                                        child: RichText(
                                                            textAlign: TextAlign
                                                                .justify,
                                                            text: TextSpan(
                                                                children: <
                                                                    TextSpan>[
                                                                  TextSpan(
                                                                    text:
                                                                        "ii) Secara geografis wilayah ini merupakan titik kumpul kapal-kapal dari benua asia atau eropa ",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                  )
                                                                ])),
                                                      ),
                                                      8.verticalSpace,
                                                      Container(
                                                        width: 0.7.sw,
                                                        child: RichText(
                                                            textAlign: TextAlign
                                                                .justify,
                                                            text: TextSpan(
                                                                children: <
                                                                    TextSpan>[
                                                                  TextSpan(
                                                                    text:
                                                                        "iii) Pusat Rempah-Rempah Cengkeh, Pala, dan Kopra dengan harga yang relatif murah",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                  )
                                                                ])),
                                                      ),
                                                      8.verticalSpace,
                                                      Container(
                                                        width: 0.7.sw,
                                                        child: RichText(
                                                            textAlign: TextAlign
                                                                .justify,
                                                            text: TextSpan(
                                                                children: <
                                                                    TextSpan>[
                                                                  TextSpan(
                                                                    text:
                                                                        "iv) Memiliki banyak tanjung dengan kedalaman yang dangkal sehingga kapal asing lebih mudah bersandar",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                  )
                                                                ])),
                                                      ),
                                                      8.verticalSpace,
                                                      Container(
                                                        width: 0.7.sw,
                                                        child: RichText(
                                                            textAlign: TextAlign
                                                                .justify,
                                                            text: TextSpan(
                                                                children: <
                                                                    TextSpan>[
                                                                  TextSpan(
                                                                    text:
                                                                        "v) Laut Di Pantai Pesisir Utara Jawa Timur relatif aman dengan ombak yang lebih tenang",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                  )
                                                                ])),
                                                      ),
                                                      8.verticalSpace,
                                                      Container(
                                                        width: 0.7.sw,
                                                        child: RichText(
                                                            textAlign: TextAlign
                                                                .justify,
                                                            text: TextSpan(
                                                                children: <
                                                                    TextSpan>[
                                                                  TextSpan(
                                                                    text:
                                                                        "Hal yang melatar belakangi Pantai Pesisir Utara Jawa Timur sebagai pelabuhan dunia adalah.....",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                  )
                                                                ])),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          : soal == 5
                                              ? Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 0.1.sw),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: 0.1.sw,
                                                        child: Text("5. ",
                                                            style: TextStyle(
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                color: Colors
                                                                    .black)),
                                                      ),
                                                      Container(
                                                        width: 0.7.sw,
                                                        child: RichText(
                                                            textAlign: TextAlign
                                                                .justify,
                                                            text: TextSpan(
                                                                children: <
                                                                    TextSpan>[
                                                                  TextSpan(
                                                                      text:
                                                                          "Raden Noer Rahmad Di Pedukuhan Amitunon dalam berdakwah memiliki prinsip dakwah yang berbunyi.......",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.black)),
                                                                  // TextSpan(
                                                                  //   text: "“ANSORY MAPS” (Android studio history maps)",
                                                                  //   style: TextStyle(
                                                                  //       color: Colors.black, fontStyle: FontStyle.italic),
                                                                  // ),
                                                                  // TextSpan(
                                                                  //   text: " dengan baik.",
                                                                  //   style: TextStyle(color: Colors.black),
                                                                  // )
                                                                ])),
                                                        // Text(
                                                        //   "Siswa dapat menjelaskan proses islamisasi di wilayah Sendang Duwur Di Kabupaten Lamongan melalui penggunaan aplikasi ",
                                                        //   textAlign: TextAlign.justify,
                                                        // ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : soal == 6
                                                  ? Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 0.1.sw),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: 0.1.sw,
                                                            child: Text("6. ",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                    color: Colors
                                                                        .black)),
                                                          ),
                                                          Container(
                                                            width: 0.7.sw,
                                                            child: RichText(
                                                                textAlign:
                                                                    TextAlign
                                                                        .justify,
                                                                text: TextSpan(
                                                                    children: <
                                                                        TextSpan>[
                                                                      TextSpan(
                                                                          text:
                                                                              "Dalam berdakwah di Pedukuhan Amitunon, Raden Noer Rahmad diberi pesan oleh ibunya untuk menanam pohon......",
                                                                          style:
                                                                              TextStyle(color: Colors.black)),
                                                                      // TextSpan(
                                                                      //   text: "“ANSORY MAPS” (Android studio history maps)",
                                                                      //   style: TextStyle(
                                                                      //       color: Colors.black, fontStyle: FontStyle.italic),
                                                                      // ),
                                                                      // TextSpan(
                                                                      //   text: " dengan baik.",
                                                                      //   style: TextStyle(color: Colors.black),
                                                                      // )
                                                                    ])),
                                                            // Text(
                                                            //   "Siswa dapat menjelaskan proses islamisasi di wilayah Sendang Duwur Di Kabupaten Lamongan melalui penggunaan aplikasi ",
                                                            //   textAlign: TextAlign.justify,
                                                            // ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : soal == 7
                                                      ? Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 0.1.sw),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                width: 0.1.sw,
                                                                child: Text(
                                                                    "7. ",
                                                                    style: TextStyle(
                                                                        fontSize: 14
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w800,
                                                                        color: Colors
                                                                            .black)),
                                                              ),
                                                              Container(
                                                                width: 0.7.sw,
                                                                child: RichText(
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                    text: TextSpan(
                                                                        children: <
                                                                            TextSpan>[
                                                                          TextSpan(
                                                                              text: "Raden Noer Rahmad dalam dakwahnya diperkirakan satu zaman dan satu wilayah dengan Tokoh Walisongo yang bernama Sunan......",
                                                                              style: TextStyle(color: Colors.black)),
                                                                          // TextSpan(
                                                                          //   text: "“ANSORY MAPS” (Android studio history maps)",
                                                                          //   style: TextStyle(
                                                                          //       color: Colors.black, fontStyle: FontStyle.italic),
                                                                          // ),
                                                                          // TextSpan(
                                                                          //   text: " dengan baik.",
                                                                          //   style: TextStyle(color: Colors.black),
                                                                          // )
                                                                        ])),
                                                                // Text(
                                                                //   "Siswa dapat menjelaskan proses islamisasi di wilayah Sendang Duwur Di Kabupaten Lamongan melalui penggunaan aplikasi ",
                                                                //   textAlign: TextAlign.justify,
                                                                // ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : soal == 8
                                                          ? Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 0.1
                                                                          .sw),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    width:
                                                                        0.1.sw,
                                                                    child: Text(
                                                                        "8. ",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14.sp,
                                                                            fontWeight: FontWeight.w800,
                                                                            color: Colors.black)),
                                                                  ),
                                                                  Container(
                                                                    width:
                                                                        0.7.sw,
                                                                    child: RichText(
                                                                        textAlign: TextAlign.justify,
                                                                        text: TextSpan(children: <TextSpan>[
                                                                          TextSpan(
                                                                              text: "Masjid Sunan Sendang Duwur juga disebut masyarakat sekitar dengan nama Masjid Tiban, hal tersebut di dasarkan oleh peristiwa..... yang menjadikan masyarakat desa meyakini bahwa itu adalah ",
                                                                              style: TextStyle(color: Colors.black)),
                                                                          TextSpan(
                                                                            text:
                                                                                "karamah ",
                                                                            style:
                                                                                TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
                                                                          ),
                                                                          TextSpan(
                                                                            text:
                                                                                "Sunan Sendang Duwur.",
                                                                            style:
                                                                                TextStyle(color: Colors.black),
                                                                          )
                                                                        ])),
                                                                    // Text(
                                                                    //   "Siswa dapat menjelaskan proses islamisasi di wilayah Sendang Duwur Di Kabupaten Lamongan melalui penggunaan aplikasi ",
                                                                    //   textAlign: TextAlign.justify,
                                                                    // ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          : soal == 9
                                                              ? Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: 0.1
                                                                          .sw),
                                                                  child: Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                        width: 0.1
                                                                            .sw,
                                                                        child: Text(
                                                                            "9. ",
                                                                            style: TextStyle(
                                                                                fontSize: 14.sp,
                                                                                fontWeight: FontWeight.w800,
                                                                                color: Colors.black)),
                                                                      ),
                                                                      Column(
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                0.7.sw,
                                                                            child: RichText(
                                                                                textAlign: TextAlign.justify,
                                                                                text: TextSpan(children: <TextSpan>[
                                                                                  TextSpan(text: "Cermatilah Gambar Berikut !", style: TextStyle(color: Colors.black)),
                                                                                  // TextSpan(
                                                                                  //   text: "“ANSORY MAPS” (Android studio history maps)",
                                                                                  //   style: TextStyle(
                                                                                  //       color: Colors.black, fontStyle: FontStyle.italic),
                                                                                  // ),
                                                                                  // TextSpan(
                                                                                  //   text: " dengan baik.",
                                                                                  //   style: TextStyle(color: Colors.black),
                                                                                  // )
                                                                                ])),
                                                                            // Text(
                                                                            //   "Siswa dapat menjelaskan proses islamisasi di wilayah Sendang Duwur Di Kabupaten Lamongan melalui penggunaan aplikasi ",
                                                                            //   textAlign: TextAlign.justify,
                                                                            // ),
                                                                          ),
                                                                          5.verticalSpace,
                                                                          Container(
                                                                            decoration:
                                                                                BoxDecoration(border: Border.all(style: BorderStyle.solid, width: 4)),
                                                                            child:
                                                                                Image.asset(
                                                                              fit: BoxFit.fill,
                                                                              "assets/foto_soal_no_9.jpg",
                                                                              width: 0.7.sw,
                                                                              height: 0.25.sh,
                                                                            ),
                                                                          ),
                                                                          5.verticalSpace,
                                                                          Container(
                                                                            width:
                                                                                0.7.sw,
                                                                            child: RichText(
                                                                                textAlign: TextAlign.justify,
                                                                                text: TextSpan(children: <TextSpan>[
                                                                                  TextSpan(
                                                                                    text: "Tujuan utama secara fungsi dibangunnya Sumur Giling di bagian timur Masjid Sunan Sendang Duwur sebagai, Kecuali....",
                                                                                    style: TextStyle(color: Colors.black),
                                                                                  )
                                                                                ])),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              : soal == 10
                                                                  ? Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              0.1.sw),
                                                                      child:
                                                                          Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                0.1.sw,
                                                                            child:
                                                                                Text("10. ", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w800, color: Colors.black)),
                                                                          ),
                                                                          Container(
                                                                            width:
                                                                                0.7.sw,
                                                                            child: RichText(
                                                                                textAlign: TextAlign.justify,
                                                                                text: TextSpan(children: <TextSpan>[
                                                                                  TextSpan(text: "Salah satu penyebab dipilihnya Bukit Amitunon oleh Sunan Drajat sebagai letak Masjid Sunan Sendang ialah..... ", style: TextStyle(color: Colors.black)),
                                                                                  // TextSpan(
                                                                                  //   text: "“ANSORY MAPS” (Android studio history maps)",
                                                                                  //   style: TextStyle(
                                                                                  //       color: Colors.black, fontStyle: FontStyle.italic),
                                                                                  // ),
                                                                                  // TextSpan(
                                                                                  //   text: " dengan baik.",
                                                                                  //   style: TextStyle(color: Colors.black),
                                                                                  // )
                                                                                ])),
                                                                            // Text(
                                                                            //   "Siswa dapat menjelaskan proses islamisasi di wilayah Sendang Duwur Di Kabupaten Lamongan melalui penggunaan aplikasi ",
                                                                            //   textAlign: TextAlign.justify,
                                                                            // ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  : soal == 11
                                                                      ? Padding(
                                                                          padding:
                                                                              EdgeInsets.only(left: 0.1.sw),
                                                                          child:
                                                                              Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Container(
                                                                                width: 0.1.sw,
                                                                                child: Text("11. ", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w800, color: Colors.black)),
                                                                              ),
                                                                              Container(
                                                                                width: 0.7.sw,
                                                                                child: RichText(
                                                                                    textAlign: TextAlign.justify,
                                                                                    text: TextSpan(children: <TextSpan>[
                                                                                      TextSpan(text: "Latar belakang Sunan Sendang Duwur dalam dakwahnya menggunakan prinsip ", style: TextStyle(color: Colors.black)),
                                                                                      TextSpan(
                                                                                        text: "“manut ilining banyu”  ",
                                                                                        style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
                                                                                      ),
                                                                                      TextSpan(
                                                                                        text: "ialah, kecuali.......",
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
                                                                        )
                                                                      : soal ==
                                                                              12
                                                                          ? Padding(
                                                                              padding: EdgeInsets.only(left: 0.1.sw),
                                                                              child: Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Container(
                                                                                    width: 0.1.sw,
                                                                                    child: Text("12. ", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w800, color: Colors.black)),
                                                                                  ),
                                                                                  Container(
                                                                                    width: 0.7.sw,
                                                                                    child: RichText(
                                                                                        textAlign: TextAlign.justify,
                                                                                        text: TextSpan(children: <TextSpan>[
                                                                                          TextSpan(text: "Raden Noer Rahmad Lahir di Sedayu Lawas pada tahun...... dan wafat di Sendang Duwur pada tahun......", style: TextStyle(color: Colors.black)),
                                                                                          // TextSpan(
                                                                                          //   text: "“manut ilining banyu”  ",
                                                                                          //   style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
                                                                                          // ),
                                                                                          // TextSpan(
                                                                                          //   text: "ialah, kecuali.......",
                                                                                          //   style: TextStyle(color: Colors.black),
                                                                                          // )
                                                                                        ])),
                                                                                    // Text(
                                                                                    //   "Siswa dapat menjelaskan proses islamisasi di wilayah Sendang Duwur Di Kabupaten Lamongan melalui penggunaan aplikasi ",
                                                                                    //   textAlign: TextAlign.justify,
                                                                                    // ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            )
                                                                          : soal == 13
                                                                              ? Padding(
                                                                                  padding: EdgeInsets.only(left: 0.1.sw),
                                                                                  child: Row(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 0.1.sw,
                                                                                        child: Text("13. ", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w800, color: Colors.black)),
                                                                                      ),
                                                                                      Column(
                                                                                        children: [
                                                                                          Container(
                                                                                            width: 0.7.sw,
                                                                                            child: RichText(
                                                                                                textAlign: TextAlign.justify,
                                                                                                text: TextSpan(children: <TextSpan>[
                                                                                                  TextSpan(text: "Cermatilah Gambar Berikut !", style: TextStyle(color: Colors.black)),
                                                                                                  // TextSpan(
                                                                                                  //   text: "“ANSORY MAPS” (Android studio history maps)",
                                                                                                  //   style: TextStyle(
                                                                                                  //       color: Colors.black, fontStyle: FontStyle.italic),
                                                                                                  // ),
                                                                                                  // TextSpan(
                                                                                                  //   text: " dengan baik.",
                                                                                                  //   style: TextStyle(color: Colors.black),
                                                                                                  // )
                                                                                                ])),
                                                                                            // Text(
                                                                                            //   "Siswa dapat menjelaskan proses islamisasi di wilayah Sendang Duwur Di Kabupaten Lamongan melalui penggunaan aplikasi ",
                                                                                            //   textAlign: TextAlign.justify,
                                                                                            // ),
                                                                                          ),
                                                                                          5.verticalSpace,
                                                                                          Container(
                                                                                            decoration: BoxDecoration(border: Border.all(style: BorderStyle.solid, width: 4)),
                                                                                            child: Image.asset(
                                                                                              fit: BoxFit.fill,
                                                                                              "assets/foto_soal_no_13.jpg",
                                                                                              width: 0.7.sw,
                                                                                              height: 0.25.sh,
                                                                                            ),
                                                                                          ),
                                                                                          5.verticalSpace,
                                                                                          Container(
                                                                                            width: 0.7.sw,
                                                                                            child: RichText(
                                                                                                textAlign: TextAlign.justify,
                                                                                                text: TextSpan(children: <TextSpan>[
                                                                                                  TextSpan(
                                                                                                    text: "Dalam kebudayaan Islam penggunaan gerbang paduraksa pada Kompleks Makam Sunan Sendang Duwur secara esensi fungsi ialah............",
                                                                                                    style: TextStyle(color: Colors.black),
                                                                                                  )
                                                                                                ])),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                )
                                                                              : soal == 14
                                                                                  ? Padding(
                                                                                      padding: EdgeInsets.only(left: 0.1.sw),
                                                                                      child: Row(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Container(
                                                                                            width: 0.1.sw,
                                                                                            child: Text("14. ", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w800, color: Colors.black)),
                                                                                          ),
                                                                                          Column(
                                                                                            children: [
                                                                                              Container(
                                                                                                width: 0.7.sw,
                                                                                                child: RichText(
                                                                                                    textAlign: TextAlign.justify,
                                                                                                    text: TextSpan(children: <TextSpan>[
                                                                                                      TextSpan(text: "Cermatilah Bangunan Tersebut !", style: TextStyle(color: Colors.black)),
                                                                                                      // TextSpan(
                                                                                                      //   text: "“ANSORY MAPS” (Android studio history maps)",
                                                                                                      //   style: TextStyle(
                                                                                                      //       color: Colors.black, fontStyle: FontStyle.italic),
                                                                                                      // ),
                                                                                                      // TextSpan(
                                                                                                      //   text: " dengan baik.",
                                                                                                      //   style: TextStyle(color: Colors.black),
                                                                                                      // )
                                                                                                    ])),
                                                                                                // Text(
                                                                                                //   "Siswa dapat menjelaskan proses islamisasi di wilayah Sendang Duwur Di Kabupaten Lamongan melalui penggunaan aplikasi ",
                                                                                                //   textAlign: TextAlign.justify,
                                                                                                // ),
                                                                                              ),
                                                                                              5.verticalSpace,
                                                                                              Container(
                                                                                                decoration: BoxDecoration(border: Border.all(style: BorderStyle.solid, width: 4)),
                                                                                                child: Image.asset(
                                                                                                  fit: BoxFit.fill,
                                                                                                  "assets/foto_soal_no_14.jpg",
                                                                                                  width: 0.7.sw,
                                                                                                  height: 0.25.sh,
                                                                                                ),
                                                                                              ),
                                                                                              5.verticalSpace,
                                                                                              Container(
                                                                                                width: 0.7.sw,
                                                                                                child: RichText(
                                                                                                    textAlign: TextAlign.justify,
                                                                                                    text: TextSpan(children: <TextSpan>[
                                                                                                      TextSpan(
                                                                                                        text: "Bangunan Masjid Sunan Sendang Duwur merupakan gaya masjid masa transisi antara kebudayaan Hindu – Islam.",
                                                                                                        style: TextStyle(color: Colors.black),
                                                                                                      ),
                                                                                                    ])),
                                                                                              ),
                                                                                              8.verticalSpace,
                                                                                              Container(
                                                                                                width: 0.7.sw,
                                                                                                child: RichText(
                                                                                                    textAlign: TextAlign.justify,
                                                                                                    text: TextSpan(children: <TextSpan>[
                                                                                                      TextSpan(
                                                                                                        text: "i)  Memiliki atap berbentuk tajug tumpang dengan tiga sap",
                                                                                                        style: TextStyle(color: Colors.black),
                                                                                                      ),
                                                                                                    ])),
                                                                                              ),
                                                                                              8.verticalSpace,
                                                                                              Container(
                                                                                                width: 0.7.sw,
                                                                                                child: RichText(
                                                                                                    textAlign: TextAlign.justify,
                                                                                                    text: TextSpan(children: <TextSpan>[
                                                                                                      TextSpan(
                                                                                                        text: "ii) Di Bangun di atas bukit yang tinggi",
                                                                                                        style: TextStyle(color: Colors.black),
                                                                                                      )
                                                                                                    ])),
                                                                                              ),
                                                                                              8.verticalSpace,
                                                                                              Container(
                                                                                                width: 0.7.sw,
                                                                                                child: RichText(
                                                                                                    textAlign: TextAlign.justify,
                                                                                                    text: TextSpan(children: <TextSpan>[
                                                                                                      TextSpan(
                                                                                                        text: "iii) Memiliki gapura bentar di setiap pintu masuk menuju halaman luar masjid",
                                                                                                        style: TextStyle(color: Colors.black),
                                                                                                      ),
                                                                                                    ])),
                                                                                              ),
                                                                                              8.verticalSpace,
                                                                                              Container(
                                                                                                width: 0.7.sw,
                                                                                                child: RichText(
                                                                                                    textAlign: TextAlign.justify,
                                                                                                    text: TextSpan(children: <TextSpan>[
                                                                                                      TextSpan(
                                                                                                        text: "iv) Terdapat beduk dan kentongan dengan hiasan flora dan fauna yang di stilir",
                                                                                                        style: TextStyle(color: Colors.black),
                                                                                                      )
                                                                                                    ])),
                                                                                              ),
                                                                                              8.verticalSpace,
                                                                                              Container(
                                                                                                width: 0.7.sw,
                                                                                                child: RichText(
                                                                                                    textAlign: TextAlign.justify,
                                                                                                    text: TextSpan(children: <TextSpan>[
                                                                                                      TextSpan(
                                                                                                        text: "v) Terdapat kompleks makam dilingkungan masjid",
                                                                                                        style: TextStyle(color: Colors.black),
                                                                                                      ),
                                                                                                    ])),
                                                                                              ),
                                                                                              8.verticalSpace,
                                                                                              Container(
                                                                                                width: 0.7.sw,
                                                                                                child: RichText(
                                                                                                    textAlign: TextAlign.justify,
                                                                                                    text: TextSpan(children: <TextSpan>[
                                                                                                      TextSpan(
                                                                                                        text: "Keunikan Masjid Sunan Sendang Duwur di buktikan oleh......",
                                                                                                        style: TextStyle(color: Colors.black),
                                                                                                      )
                                                                                                    ])),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    )
                                                                                  : soal == 15
                                                                                      ? Padding(
                                                                                          padding: EdgeInsets.only(left: 0.1.sw),
                                                                                          child: Row(
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              Container(
                                                                                                width: 0.1.sw,
                                                                                                child: Text("15. ", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w800, color: Colors.black)),
                                                                                              ),
                                                                                              Container(
                                                                                                width: 0.7.sw,
                                                                                                child: RichText(
                                                                                                    textAlign: TextAlign.justify,
                                                                                                    text: TextSpan(children: <TextSpan>[
                                                                                                      TextSpan(text: "Pada Bangunan Masjid dan Kompleks Makam Sunan Sendang Duwur Sangat terlihat bentuk-bentuk akulturasi kebudayaan Hindu-Islam antara lain,kecuali......... ", style: TextStyle(color: Colors.black)),
                                                                                                      // TextSpan(
                                                                                                      //   text: "“ANSORY MAPS” (Android studio history maps)",
                                                                                                      //   style: TextStyle(
                                                                                                      //       color: Colors.black, fontStyle: FontStyle.italic),
                                                                                                      // ),
                                                                                                      // TextSpan(
                                                                                                      //   text: " dengan baik.",
                                                                                                      //   style: TextStyle(color: Colors.black),
                                                                                                      // )
                                                                                                    ])),
                                                                                                // Text(
                                                                                                //   "Siswa dapat menjelaskan proses islamisasi di wilayah Sendang Duwur Di Kabupaten Lamongan melalui penggunaan aplikasi ",
                                                                                                //   textAlign: TextAlign.justify,
                                                                                                // ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        )
                                                                                      : soal == 16
                                                                                          ? Padding(
                                                                                              padding: EdgeInsets.only(left: 0.1.sw),
                                                                                              child: Row(
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                children: [
                                                                                                  Container(
                                                                                                    width: 0.1.sw,
                                                                                                    child: Text("16. ", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w800, color: Colors.black)),
                                                                                                  ),
                                                                                                  Container(
                                                                                                    width: 0.7.sw,
                                                                                                    child: RichText(
                                                                                                        textAlign: TextAlign.justify,
                                                                                                        text: TextSpan(children: <TextSpan>[
                                                                                                          TextSpan(text: "Peninggalan dakwah Sunan Sendang Duwur dalam bentuk bangunan dan ajaran tidak menghilangkan ciri kebudayaan Hindu sebagai kebudayaan yang telah ada lebih dahulu. Tetapi telah di sisipkan dengan nilai-nilai islam. Sunan Sendang Duwur mencontohkan dalam praktiknya, kecuali.....", style: TextStyle(color: Colors.black)),
                                                                                                          // TextSpan(
                                                                                                          //   text: "“ANSORY MAPS” (Android studio history maps)",
                                                                                                          //   style: TextStyle(
                                                                                                          //       color: Colors.black, fontStyle: FontStyle.italic),
                                                                                                          // ),
                                                                                                          // TextSpan(
                                                                                                          //   text: " dengan baik.",
                                                                                                          //   style: TextStyle(color: Colors.black),
                                                                                                          // )
                                                                                                        ])),
                                                                                                    // Text(
                                                                                                    //   "Siswa dapat menjelaskan proses islamisasi di wilayah Sendang Duwur Di Kabupaten Lamongan melalui penggunaan aplikasi ",
                                                                                                    //   textAlign: TextAlign.justify,
                                                                                                    // ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            )
                                                                                          : soal == 17
                                                                                              ? Padding(
                                                                                                  padding: EdgeInsets.only(left: 0.1.sw),
                                                                                                  child: Row(
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Container(
                                                                                                        width: 0.1.sw,
                                                                                                        child: Text("17. ", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w800, color: Colors.black)),
                                                                                                      ),
                                                                                                      Column(
                                                                                                        children: [
                                                                                                          Container(
                                                                                                            width: 0.7.sw,
                                                                                                            child: RichText(
                                                                                                                textAlign: TextAlign.justify,
                                                                                                                text: TextSpan(children: <TextSpan>[
                                                                                                                  TextSpan(text: "Cermatilah Gambar Berikut !", style: TextStyle(color: Colors.black)),
                                                                                                                  // TextSpan(
                                                                                                                  //   text: "“ANSORY MAPS” (Android studio history maps)",
                                                                                                                  //   style: TextStyle(
                                                                                                                  //       color: Colors.black, fontStyle: FontStyle.italic),
                                                                                                                  // ),
                                                                                                                  // TextSpan(
                                                                                                                  //   text: " dengan baik.",
                                                                                                                  //   style: TextStyle(color: Colors.black),
                                                                                                                  // )
                                                                                                                ])),
                                                                                                            // Text(
                                                                                                            //   "Siswa dapat menjelaskan proses islamisasi di wilayah Sendang Duwur Di Kabupaten Lamongan melalui penggunaan aplikasi ",
                                                                                                            //   textAlign: TextAlign.justify,
                                                                                                            // ),
                                                                                                          ),
                                                                                                          5.verticalSpace,
                                                                                                          Container(
                                                                                                            decoration: BoxDecoration(border: Border.all(style: BorderStyle.solid, width: 4)),
                                                                                                            child: Image.asset(
                                                                                                              fit: BoxFit.fill,
                                                                                                              "assets/foto_soal_no_17.jpg",
                                                                                                              width: 0.7.sw,
                                                                                                              height: 0.25.sh,
                                                                                                            ),
                                                                                                          ),
                                                                                                          5.verticalSpace,
                                                                                                          Container(
                                                                                                            width: 0.7.sw,
                                                                                                            child: RichText(
                                                                                                                textAlign: TextAlign.justify,
                                                                                                                text: TextSpan(children: <TextSpan>[
                                                                                                                  TextSpan(
                                                                                                                    text: "Ragam arsitektur pada masjid dan kompleks Makam Sunan Sendang Duwur secara esensi islam di lakukan bertujuan untuk.........",
                                                                                                                    style: TextStyle(color: Colors.black),
                                                                                                                  ),
                                                                                                                ])),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                )
                                                                                              : soal == 18
                                                                                                  ? Padding(
                                                                                                      padding: EdgeInsets.only(left: 0.1.sw),
                                                                                                      child: Row(
                                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                        children: [
                                                                                                          Container(
                                                                                                            width: 0.1.sw,
                                                                                                            child: Text("18. ", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w800, color: Colors.black)),
                                                                                                          ),
                                                                                                          Column(
                                                                                                            children: [
                                                                                                              Container(
                                                                                                                width: 0.7.sw,
                                                                                                                child: RichText(
                                                                                                                    textAlign: TextAlign.justify,
                                                                                                                    text: TextSpan(children: <TextSpan>[
                                                                                                                      TextSpan(text: "Bacalah dengan Seksama !", style: TextStyle(color: Colors.black)),
                                                                                                                    ])),
                                                                                                              ),
                                                                                                              5.verticalSpace,
                                                                                                              Container(
                                                                                                                width: 0.7.sw,
                                                                                                                child: RichText(
                                                                                                                    textAlign: TextAlign.justify,
                                                                                                                    text: TextSpan(children: <TextSpan>[
                                                                                                                      TextSpan(
                                                                                                                        text: "“ Bapak Ridho Merupakan seorang warga kelahiran Desa Sendang Duwur, beliau merantau Di Jakarta sebagai pengerajin emas. Dalam usahanya Di Jakarta Pak Ridho selalu mendapat untung yang berlebih. Kemudian Pak Ridho ingat dengan saudara-saudaranya di kampung yang masih perlu bantuan beliau. Pak Ridho pun mengirim uang untuk saudara di kampung dan untuk melakukan slamatan Di Masjid Sendang Duwur” Cuplikan cerita di atas termasuk kedalam esensi ajaran Sunan Sendang Duwur yang berbunyi.......",
                                                                                                                        style: TextStyle(color: Colors.black),
                                                                                                                      ),
                                                                                                                    ])),
                                                                                                              ),
                                                                                                            ],
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    )
                                                                                                  : soal == 19
                                                                                                      ? Padding(
                                                                                                          padding: EdgeInsets.only(left: 0.1.sw),
                                                                                                          child: Row(
                                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                            children: [
                                                                                                              Container(
                                                                                                                width: 0.1.sw,
                                                                                                                child: Text("19 . ", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w800, color: Colors.black)),
                                                                                                              ),
                                                                                                              Column(
                                                                                                                children: [
                                                                                                                  Container(
                                                                                                                    width: 0.7.sw,
                                                                                                                    child: RichText(
                                                                                                                        textAlign: TextAlign.justify,
                                                                                                                        text: TextSpan(children: <TextSpan>[
                                                                                                                          TextSpan(text: "Cermatilah Gambar Berikut !", style: TextStyle(color: Colors.black)),
                                                                                                                          // TextSpan(
                                                                                                                          //   text: "“ANSORY MAPS” (Android studio history maps)",
                                                                                                                          //   style: TextStyle(
                                                                                                                          //       color: Colors.black, fontStyle: FontStyle.italic),
                                                                                                                          // ),
                                                                                                                          // TextSpan(
                                                                                                                          //   text: " dengan baik.",
                                                                                                                          //   style: TextStyle(color: Colors.black),
                                                                                                                          // )
                                                                                                                        ])),
                                                                                                                    // Text(
                                                                                                                    //   "Siswa dapat menjelaskan proses islamisasi di wilayah Sendang Duwur Di Kabupaten Lamongan melalui penggunaan aplikasi ",
                                                                                                                    //   textAlign: TextAlign.justify,
                                                                                                                    // ),
                                                                                                                  ),
                                                                                                                  5.verticalSpace,
                                                                                                                  Container(
                                                                                                                    decoration: BoxDecoration(border: Border.all(style: BorderStyle.solid, width: 4)),
                                                                                                                    child: Image.asset(
                                                                                                                      fit: BoxFit.fill,
                                                                                                                      "assets/foto_soal_no_19.jpg",
                                                                                                                      width: 0.7.sw,
                                                                                                                      height: 0.25.sh,
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  5.verticalSpace,
                                                                                                                  Container(
                                                                                                                    width: 0.7.sw,
                                                                                                                    child: RichText(
                                                                                                                        textAlign: TextAlign.justify,
                                                                                                                        text: TextSpan(children: <TextSpan>[
                                                                                                                          TextSpan(
                                                                                                                            text: "Kebudayaan kuliner Sego Langgi yang hanya disajikan ketika Haul Akbar Sunan Sendang Duwur memiliki esensi untuk..........",
                                                                                                                            style: TextStyle(color: Colors.black),
                                                                                                                          ),
                                                                                                                        ])),
                                                                                                                  ),
                                                                                                                ],
                                                                                                              ),
                                                                                                            ],
                                                                                                          ),
                                                                                                        )
                                                                                                      : soal == 20
                                                                                                          ? Padding(
                                                                                                              padding: EdgeInsets.only(left: 0.1.sw),
                                                                                                              child: Row(
                                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                children: [
                                                                                                                  Container(
                                                                                                                    width: 0.1.sw,
                                                                                                                    child: Text("20 . ", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w800, color: Colors.black)),
                                                                                                                  ),
                                                                                                                  Column(
                                                                                                                    children: [
                                                                                                                      Container(
                                                                                                                        width: 0.7.sw,
                                                                                                                        child: RichText(
                                                                                                                            textAlign: TextAlign.justify,
                                                                                                                            text: TextSpan(children: <TextSpan>[
                                                                                                                              TextSpan(text: "Setelah kita belajar tentang jejak-jejak proses Islamisasi Sunan Sendang Duwur pada Situs Sendang Duwur secara fisik dan ajaran. ", style: TextStyle(color: Colors.black)),
                                                                                                                            ])),
                                                                                                                      ),
                                                                                                                      5.verticalSpace,
                                                                                                                      Container(
                                                                                                                        width: 0.7.sw,
                                                                                                                        child: RichText(
                                                                                                                            textAlign: TextAlign.justify,
                                                                                                                            text: TextSpan(children: <TextSpan>[
                                                                                                                              TextSpan(
                                                                                                                                text: "i) Tidak peduli dengan kondisi warga yang ada di sekitar tempat tinggal kita",
                                                                                                                                style: TextStyle(color: Colors.black),
                                                                                                                              ),
                                                                                                                            ])),
                                                                                                                      ),
                                                                                                                      8.verticalSpace,
                                                                                                                      Container(
                                                                                                                        width: 0.7.sw,
                                                                                                                        child: RichText(
                                                                                                                            textAlign: TextAlign.justify,
                                                                                                                            text: TextSpan(children: <TextSpan>[
                                                                                                                              TextSpan(
                                                                                                                                text: "ii) Membuat kegaduhan antara umat beragama",
                                                                                                                                style: TextStyle(color: Colors.black),
                                                                                                                              ),
                                                                                                                            ])),
                                                                                                                      ),
                                                                                                                      8.verticalSpace,
                                                                                                                      Container(
                                                                                                                        width: 0.7.sw,
                                                                                                                        child: RichText(
                                                                                                                            textAlign: TextAlign.justify,
                                                                                                                            text: TextSpan(children: <TextSpan>[
                                                                                                                              TextSpan(
                                                                                                                                text: "iii) Mengimplementasikan nilai-nilai ajaran Sunan Sendang Duwur pada kehidupan sehari-hari",
                                                                                                                                style: TextStyle(color: Colors.black),
                                                                                                                              ),
                                                                                                                            ])),
                                                                                                                      ),
                                                                                                                      8.verticalSpace,
                                                                                                                      Container(
                                                                                                                        width: 0.7.sw,
                                                                                                                        child: RichText(
                                                                                                                            textAlign: TextAlign.justify,
                                                                                                                            text: TextSpan(children: <TextSpan>[
                                                                                                                              TextSpan(
                                                                                                                                text: "iv) Ikut menjaga atas situs-situs peninggalan beliau sebagai bakti kita atas perjuangan dakwah beliau",
                                                                                                                                style: TextStyle(color: Colors.black),
                                                                                                                              ),
                                                                                                                            ])),
                                                                                                                      ),
                                                                                                                      8.verticalSpace,
                                                                                                                      Container(
                                                                                                                        width: 0.7.sw,
                                                                                                                        child: RichText(
                                                                                                                            textAlign: TextAlign.justify,
                                                                                                                            text: TextSpan(children: <TextSpan>[
                                                                                                                              TextSpan(
                                                                                                                                text: "v) mengikuti acara-acara kebudayaan Di Desa Sendang Duwur sebagai cara untuk melestarikan peninggalan Sunan Sendang Duwur",
                                                                                                                                style: TextStyle(color: Colors.black),
                                                                                                                              ),
                                                                                                                            ])),
                                                                                                                      ),
                                                                                                                      8.verticalSpace,
                                                                                                                      Container(
                                                                                                                        width: 0.7.sw,
                                                                                                                        child: RichText(
                                                                                                                            textAlign: TextAlign.justify,
                                                                                                                            text: TextSpan(children: <TextSpan>[
                                                                                                                              TextSpan(
                                                                                                                                text: "Cara apa yang dapat kita lakukan untuk meneladani dari peninggalan dakwah beliau....",
                                                                                                                                style: TextStyle(color: Colors.black),
                                                                                                                              ),
                                                                                                                            ])),
                                                                                                                      ),
                                                                                                                    ],
                                                                                                                  ),
                                                                                                                ],
                                                                                                              ),
                                                                                                            )
                                                                                                          : Text(""),
                          10.verticalSpace,
                          InkWell(
                            onTap: () {
                              selected[soal - 1] = 1;
                              setState(() {});
                            },
                            child: Container(
                              width: 0.8.sw,
                              height: soal == 8
                                  ? 0.25.sw
                                  : soal == 16
                                      ? 0.25.sw
                                      : 0.2.sw,
                              decoration: BoxDecoration(
                                  color: selected[soal - 1] == 1
                                      ? Color.fromRGBO(227, 205, 148, 1)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 5.0,
                                        color: Colors.black12,
                                        spreadRadius: 5.0,
                                        offset: Offset(0, 2))
                                  ]),
                              child: soal == 1
                                  ? Center(
                                      child: Text(
                                      "13-14M",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600),
                                    ))
                                  : soal == 2
                                      ? Center(
                                          child: Container(
                                          width: 0.7.sw,
                                          child: Text(
                                            "Syeh Abdul Qahar Bin Malik Al-Bagdadi dan Dewi Sukarsih",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ))
                                      : soal == 3
                                          ? Center(
                                              child: Text(
                                              "Cara pernikahan",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w600),
                                            ))
                                          : soal == 4
                                              ? Center(
                                                  child: Text(
                                                  "i,ii,iv",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ))
                                              : soal == 5
                                                  ? Center(
                                                      child: Text(
                                                      "Gurhaning Saira Tirta Hayu",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ))
                                                  : soal == 6
                                                      ? Center(
                                                          child: Text(
                                                          "Kelapa dan Karet",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ))
                                                      : soal == 7
                                                          ? Center(
                                                              child: Text(
                                                              "Sunan Bonang",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ))
                                                          : soal == 8
                                                              ? Center(
                                                                  child:
                                                                      Container(
                                                                  width: 0.7.sw,
                                                                  child: Text(
                                                                    "Memboyong salah satu masjid kembar yang berada Di Mantingan Jepara menuju ke Bukit Amitunon dalam waktu semalam tanpa bantuan orang lain.",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize: 12
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                ))
                                                              : soal == 9
                                                                  ? Center(
                                                                      child:
                                                                          Container(
                                                                      width: 0.7
                                                                          .sw,
                                                                      child:
                                                                          Text(
                                                                        "Sumber air untuk minum warga sekitar",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 12.sp,
                                                                            fontWeight: FontWeight.w600),
                                                                      ),
                                                                    ))
                                                                  : soal == 10
                                                                      ? Center(
                                                                          child:
                                                                              Container(
                                                                          width:
                                                                              0.7.sw,
                                                                          child:
                                                                              Text(
                                                                            "Karena Bukit Amitunon merupakan bukit yang keramat ",
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: 12.sp,
                                                                                fontWeight: FontWeight.w600),
                                                                          ),
                                                                        ))
                                                                      : soal ==
                                                                              11
                                                                          ? Center(
                                                                              child: Container(
                                                                              width: 0.7.sw,
                                                                              child: Text(
                                                                                "Agar nilai-nilai islami mudah difahami oleh masyarakat yang baru memeluk islam",
                                                                                style: TextStyle(color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w600),
                                                                              ),
                                                                            ))
                                                                          : soal == 12
                                                                              ? Center(
                                                                                  child: Text(
                                                                                  "1530 M dan 5 April 1560 M ",
                                                                                  style: TextStyle(color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w600),
                                                                                ))
                                                                              : soal == 13
                                                                                  ? Center(
                                                                                      child: Container(
                                                                                      width: 0.7.sw,
                                                                                      child: Text(
                                                                                        "Memperindah Komplek Makam Sunan Sendang Duwur",
                                                                                        style: TextStyle(color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w600),
                                                                                      ),
                                                                                    ))
                                                                                  : soal == 14
                                                                                      ? Center(
                                                                                          child: Text(
                                                                                          "i,iii,iv,v",
                                                                                          style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w600),
                                                                                        ))
                                                                                      : soal == 15
                                                                                          ? Center(
                                                                                              child: Container(
                                                                                                width: 0.7.sw,
                                                                                                child: RichText(
                                                                                                    textAlign: TextAlign.justify,
                                                                                                    text: TextSpan(children: <TextSpan>[
                                                                                                      TextSpan(text: "Bangunan masjid yang memiliki atap berbentuk ", style: TextStyle(color: Colors.black)),
                                                                                                      TextSpan(
                                                                                                        text: "tajug tumpang ",
                                                                                                        style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
                                                                                                      ),
                                                                                                      TextSpan(
                                                                                                        text: " dengan tiga sap dan mustoko di bagian puncaknya",
                                                                                                        style: TextStyle(color: Colors.black),
                                                                                                      )
                                                                                                    ])),
                                                                                              ),
                                                                                            )
                                                                                          : soal == 16
                                                                                              ? Center(
                                                                                                  child: Container(
                                                                                                    width: 0.7.sw,
                                                                                                    child: RichText(
                                                                                                        textAlign: TextAlign.justify,
                                                                                                        text: TextSpan(children: <TextSpan>[
                                                                                                          TextSpan(text: "Menstilir ragam hias yang berupa benda hidup yang bertentangan dengan nilai-nilai islam, sehingga masih diperbolehkan dalam Islam", style: TextStyle(color: Colors.black)),
                                                                                                        ])),
                                                                                                  ),
                                                                                                )
                                                                                              : soal == 17
                                                                                                  ? Center(
                                                                                                      child: Container(
                                                                                                        width: 0.7.sw,
                                                                                                        child: RichText(
                                                                                                            textAlign: TextAlign.justify,
                                                                                                            text: TextSpan(children: <TextSpan>[
                                                                                                              TextSpan(text: "Menyamarkan wujud asli dari benda hidup yang di ukir agar tidak bertentangan dengan nilai-nilai islami", style: TextStyle(color: Colors.black)),
                                                                                                            ])),
                                                                                                      ),
                                                                                                    )
                                                                                                  : soal == 18
                                                                                                      ? Center(
                                                                                                          child: Container(
                                                                                                            width: 0.7.sw,
                                                                                                            child: RichText(
                                                                                                                textAlign: TextAlign.justify,
                                                                                                                text: TextSpan(children: <TextSpan>[
                                                                                                                  TextSpan(text: "Tut Wuri Handayani dan Tut Wuri Hangiseni", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black)),
                                                                                                                ])),
                                                                                                          ),
                                                                                                        )
                                                                                                      : soal == 19
                                                                                                          ? Center(
                                                                                                              child: Container(
                                                                                                                width: 0.7.sw,
                                                                                                                child: RichText(
                                                                                                                    textAlign: TextAlign.justify,
                                                                                                                    text: TextSpan(children: <TextSpan>[
                                                                                                                      TextSpan(text: "Melengkapi prosesi acara Haul Akbar Sunan Sendang Duwur", style: TextStyle(color: Colors.black)),
                                                                                                                    ])),
                                                                                                              ),
                                                                                                            )
                                                                                                          : soal == 20
                                                                                                              ? Center(
                                                                                                                  child: RichText(
                                                                                                                      textAlign: TextAlign.justify,
                                                                                                                      text: TextSpan(children: <TextSpan>[
                                                                                                                        TextSpan(text: "i,ii,v", style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w600))
                                                                                                                      ])),
                                                                                                                )
                                                                                                              : Center(
                                                                                                                  child: Text(
                                                                                                                  "",
                                                                                                                  style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w600),
                                                                                                                )),
                            ),
                          ),
                          10.verticalSpace,
                          InkWell(
                            onTap: () {
                              selected[soal - 1] = 2;
                              setState(() {});
                            },
                            child: Container(
                              width: 0.8.sw,
                              height: 0.2.sw,
                              decoration: BoxDecoration(
                                  color: selected[soal - 1] == 2
                                      ? Color.fromRGBO(227, 205, 148, 1)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 5.0,
                                        color: Colors.black12,
                                        spreadRadius: 5.0,
                                        offset: Offset(0, 2))
                                  ]),
                              child: soal == 1
                                  ? Center(
                                      child: Text(
                                      "14-15M",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600),
                                    ))
                                  : soal == 2
                                      ? Center(
                                          child: Container(
                                          width: 0.7.sw,
                                          child: Text(
                                            "Syeh Maulana Al-Bagdadi dan Dewi Sri",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ))
                                      : soal == 3
                                          ? Center(
                                              child: Text(
                                              "Cara politik",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w600),
                                            ))
                                          : soal == 4
                                              ? Center(
                                                  child: Text(
                                                  "iii,iv,v",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ))
                                              : soal == 5
                                                  ? Center(
                                                      child: Text(
                                                      "Manut Ilining Banyu",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ))
                                                  : soal == 6
                                                      ? Center(
                                                          child: Text(
                                                          "Jagung dan Jati",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ))
                                                      : soal == 7
                                                          ? Center(
                                                              child: Text(
                                                              "Sunan Giri",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ))
                                                          : soal == 8
                                                              ? Center(
                                                                  child:
                                                                      Container(
                                                                  width: 0.7.sw,
                                                                  child: Text(
                                                                    "Membangun kompleks makam dengan arsitektur akulturasi Hindu dan Islam",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize: 12
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                ))
                                                              : soal == 9
                                                                  ? Center(
                                                                      child:
                                                                          Container(
                                                                      width: 0.7
                                                                          .sw,
                                                                      child:
                                                                          Text(
                                                                        "Sebagai sumber air cadangan pada saat kemarau karena tidak pernah surut",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 12.sp,
                                                                            fontWeight: FontWeight.w600),
                                                                      ),
                                                                    ))
                                                                  : soal == 10
                                                                      ? Center(
                                                                          child:
                                                                              Container(
                                                                          width:
                                                                              0.7.sw,
                                                                          child:
                                                                              Text(
                                                                            "Tempat turunnya pulung setelah melakukan acara penyembahan terhadap Roh Nenek Moyang.",
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: 12.sp,
                                                                                fontWeight: FontWeight.w600),
                                                                          ),
                                                                        ))
                                                                      : soal ==
                                                                              11
                                                                          ? Center(
                                                                              child: Container(
                                                                              width: 0.7.sw,
                                                                              child: Text(
                                                                                "Menghormati kebudayaan yang telah ada Di Wilayah Pedukuhan Amitunon",
                                                                                style: TextStyle(color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w600),
                                                                              ),
                                                                            ))
                                                                          : soal == 12
                                                                              ? Center(
                                                                                  child: Text(
                                                                                  "1510 M dan 15 Agustus 1570 M ",
                                                                                  style: TextStyle(color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w600),
                                                                                ))
                                                                              : soal == 13
                                                                                  ? Center(
                                                                                      child: Container(
                                                                                      width: 0.7.sw,
                                                                                      child: Text(
                                                                                        "Sebagai pembatas menuju halaman yang lebih suci sehingga dalam melewatinya harus membungkuk sebagai bentuk kesopanan",
                                                                                        style: TextStyle(color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w600),
                                                                                      ),
                                                                                    ))
                                                                                  : soal == 14
                                                                                      ? Center(
                                                                                          child: Text(
                                                                                          "ii,iii,iv,v",
                                                                                          style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w600),
                                                                                        ))
                                                                                      : soal == 15
                                                                                          ? Center(
                                                                                              child: Container(
                                                                                                width: 0.7.sw,
                                                                                                child: RichText(
                                                                                                    textAlign: TextAlign.justify,
                                                                                                    text: TextSpan(children: <TextSpan>[
                                                                                                      TextSpan(text: "Pintu masuk menuju kompleks masjid yang dibatasi oleh gapura bentar pada bagian utara dan timur", style: TextStyle(color: Colors.black)),
                                                                                                    ])),
                                                                                              ),
                                                                                            )
                                                                                          : soal == 16
                                                                                              ? Center(
                                                                                                  child: Container(
                                                                                                    width: 0.7.sw,
                                                                                                    child: RichText(
                                                                                                        textAlign: TextAlign.justify,
                                                                                                        text: TextSpan(children: <TextSpan>[
                                                                                                          TextSpan(text: "Menaruh sesaji di sekitar kompleks makam untuk mencari berkah dan bentuk rasa syukur", style: TextStyle(color: Colors.black)),
                                                                                                        ])),
                                                                                                  ),
                                                                                                )
                                                                                              : soal == 17
                                                                                                  ? Center(
                                                                                                      child: Container(
                                                                                                        width: 0.7.sw,
                                                                                                        child: RichText(
                                                                                                            textAlign: TextAlign.justify,
                                                                                                            text: TextSpan(children: <TextSpan>[
                                                                                                              TextSpan(text: "Menambah keindahan pola arsitektur pada masjid dan kompleks makam", style: TextStyle(color: Colors.black)),
                                                                                                            ])),
                                                                                                      ),
                                                                                                    )
                                                                                                  : soal == 18
                                                                                                      ? Center(
                                                                                                          child: RichText(
                                                                                                              textAlign: TextAlign.justify,
                                                                                                              text: TextSpan(children: <TextSpan>[
                                                                                                                TextSpan(text: "Manut Ilining Banyu", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black)),
                                                                                                              ])),
                                                                                                        )
                                                                                                      : soal == 19
                                                                                                          ? Center(
                                                                                                              child: Container(
                                                                                                                width: 0.7.sw,
                                                                                                                child: RichText(
                                                                                                                    textAlign: TextAlign.justify,
                                                                                                                    text: TextSpan(children: <TextSpan>[
                                                                                                                      TextSpan(text: "Bentuk rasa syukur bersama atas nikmat yang diberikan oleh Allah SWT", style: TextStyle(color: Colors.black)),
                                                                                                                    ])),
                                                                                                              ),
                                                                                                            )
                                                                                                          : soal == 20
                                                                                                              ? Center(
                                                                                                                  child: RichText(
                                                                                                                      textAlign: TextAlign.justify,
                                                                                                                      text: TextSpan(children: <TextSpan>[
                                                                                                                        TextSpan(text: "ii,iii,iv", style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w600))
                                                                                                                      ])),
                                                                                                                )
                                                                                                              : Center(
                                                                                                                  child: Text(
                                                                                                                  "",
                                                                                                                  style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w600),
                                                                                                                )),
                            ),
                          ),
                          10.verticalSpace,
                          InkWell(
                            onTap: () {
                              selected[soal - 1] = 3;
                              setState(() {});
                            },
                            child: Container(
                              width: 0.8.sw,
                              height: soal == 15
                                  ? 0.25.sw
                                  : soal == 16
                                      ? 0.35.sw
                                      : soal == 19
                                          ? 0.25.sw
                                          : 0.2.sw,
                              decoration: BoxDecoration(
                                  color: selected[soal - 1] == 3
                                      ? Color.fromRGBO(227, 205, 148, 1)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 5.0,
                                        color: Colors.black12,
                                        spreadRadius: 5.0,
                                        offset: Offset(0, 2))
                                  ]),
                              child: soal == 1
                                  ? Center(
                                      child: Text(
                                      "15-17M",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600),
                                    ))
                                  : soal == 2
                                      ? Center(
                                          child: Container(
                                          width: 0.7.sw,
                                          child: Text(
                                            "Syeh Abu Yazid Al-bagdadi dan Dewi Sekartadji",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ))
                                      : soal == 3
                                          ? Center(
                                              child: Text(
                                              "Cara militer",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w600),
                                            ))
                                          : soal == 4
                                              ? Center(
                                                  child: Text(
                                                  "i,ii,v",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ))
                                              : soal == 5
                                                  ? Center(
                                                      child: Text(
                                                      "Madep Mantep Marang Gusti Pengeran",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ))
                                                  : soal == 6
                                                      ? Center(
                                                          child: Text(
                                                          "Bringin dan Blimbing Madu",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ))
                                                      : soal == 7
                                                          ? Center(
                                                              child: Text(
                                                              "Sunan Ampel",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ))
                                                          : soal == 8
                                                              ? Center(
                                                                  child:
                                                                      Container(
                                                                  width: 0.7.sw,
                                                                  child: Text(
                                                                    "Mengislamkan seluruh masyarakat Pedukuhan Amitunon yang dahulu memeluk ajaran Hindu",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize: 12
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                ))
                                                              : soal == 9
                                                                  ? Center(
                                                                      child:
                                                                          Container(
                                                                      width: 0.7
                                                                          .sw,
                                                                      child:
                                                                          Text(
                                                                        "Untuk mengisi gentong yang ada Di Masjid Sunan Sendang untuk minum dan bersuci",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 12.sp,
                                                                            fontWeight: FontWeight.w600),
                                                                      ),
                                                                    ))
                                                                  : soal == 10
                                                                      ? Center(
                                                                          child:
                                                                              Container(
                                                                          width:
                                                                              0.7.sw,
                                                                          child:
                                                                              Text(
                                                                            "Tempat tertinggi sehingga ketika mengumandangkan adzan dapat di dengar oleh seluruh warga desa",
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: 12.sp,
                                                                                fontWeight: FontWeight.w600),
                                                                          ),
                                                                        ))
                                                                      : soal ==
                                                                              11
                                                                          ? Center(
                                                                              child: Container(
                                                                              width: 0.7.sw,
                                                                              child: Text(
                                                                                "Karena mendapat pulung untuk berdakwah dengan cara tersebut",
                                                                                style: TextStyle(color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w600),
                                                                              ),
                                                                            ))
                                                                          : soal == 12
                                                                              ? Center(
                                                                                  child: Text(
                                                                                  "1520 M dan 5 Agustus 1585 M ",
                                                                                  style: TextStyle(color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w600),
                                                                                ))
                                                                              : soal == 13
                                                                                  ? Center(
                                                                                      child: Container(
                                                                                      width: 0.7.sw,
                                                                                      child: Text(
                                                                                        "Mencerminkan akulturasi kebudayaan Hindu yang masih dilanjutkan pada masa islam oleh Sunan Sendang Duwur",
                                                                                        style: TextStyle(color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w600),
                                                                                      ),
                                                                                    ))
                                                                                  : soal == 14
                                                                                      ? Center(
                                                                                          child: Text(
                                                                                          "i,ii,iii,v",
                                                                                          style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w600),
                                                                                        ))
                                                                                      : soal == 15
                                                                                          ? Center(
                                                                                              child: Container(
                                                                                                width: 0.7.sw,
                                                                                                child: RichText(
                                                                                                    textAlign: TextAlign.justify,
                                                                                                    text: TextSpan(children: <TextSpan>[
                                                                                                      TextSpan(text: "Adanya Sumur Paidon di bagian halaman kedua Komplek Makam Sunan Sendang Duwur sebagai air penyembuh segala macam penyakit", style: TextStyle(color: Colors.black)),
                                                                                                    ])),
                                                                                              ),
                                                                                            )
                                                                                          : soal == 16
                                                                                              ? Center(
                                                                                                  child: Container(
                                                                                                    width: 0.7.sw,
                                                                                                    child: RichText(
                                                                                                        textAlign: TextAlign.justify,
                                                                                                        text: TextSpan(children: <TextSpan>[
                                                                                                          TextSpan(text: "Meluruskan orang-orang yang mencari ketenangan di goa-goa dan membaca mantra-mantra untuk mencari ketenangan dengan mengajak ke masjid untuk berdzikir dan berdoa agar batinnya semakin tenang dan sesuai dengan nilai-nilai islam", style: TextStyle(color: Colors.black)),
                                                                                                        ])),
                                                                                                  ),
                                                                                                )
                                                                                              : soal == 17
                                                                                                  ? Center(
                                                                                                      child: Container(
                                                                                                        width: 0.7.sw,
                                                                                                        child: RichText(
                                                                                                            textAlign: TextAlign.justify,
                                                                                                            text: TextSpan(children: <TextSpan>[
                                                                                                              TextSpan(text: "Menjadikan ciri khas arsitektur masjid dan Komplek Makam Sunan Sendang Duwur", style: TextStyle(color: Colors.black)),
                                                                                                            ])),
                                                                                                      ),
                                                                                                    )
                                                                                                  : soal == 18
                                                                                                      ? Center(
                                                                                                          child: RichText(
                                                                                                              textAlign: TextAlign.justify,
                                                                                                              text: TextSpan(children: <TextSpan>[
                                                                                                                TextSpan(text: "Becik Ketitik ala Ketara", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black)),
                                                                                                              ])),
                                                                                                        )
                                                                                                      : soal == 19
                                                                                                          ? Center(
                                                                                                              child: Container(
                                                                                                                width: 0.7.sw,
                                                                                                                child: RichText(
                                                                                                                    textAlign: TextAlign.justify,
                                                                                                                    text: TextSpan(children: <TextSpan>[
                                                                                                                      TextSpan(text: "Mengingat perjuangan Sunan Sendang Duwur dalam bertirakat semasa dakwah di wilayah Sendang Agung dan Sendang Duwur", style: TextStyle(color: Colors.black)),
                                                                                                                    ])),
                                                                                                              ),
                                                                                                            )
                                                                                                          : soal == 20
                                                                                                              ? Center(
                                                                                                                  child: RichText(
                                                                                                                      textAlign: TextAlign.justify,
                                                                                                                      text: TextSpan(children: <TextSpan>[
                                                                                                                        TextSpan(text: "iii,iv,v", style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w600))
                                                                                                                      ])),
                                                                                                                )
                                                                                                              : Center(
                                                                                                                  child: Text(
                                                                                                                  "",
                                                                                                                  style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w600),
                                                                                                                )),
                            ),
                          ),
                          10.verticalSpace,
                          InkWell(
                            onTap: () {
                              selected[soal - 1] = 4;
                              setState(() {});
                            },
                            child: Container(
                              width: 0.8.sw,
                              height: soal == 16 ? 0.25.sw : 0.2.sw,
                              decoration: BoxDecoration(
                                  color: selected[soal - 1] == 4
                                      ? Color.fromRGBO(227, 205, 148, 1)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 5.0,
                                        color: Colors.black12,
                                        spreadRadius: 5.0,
                                        offset: Offset(0, 2))
                                  ]),
                              child: soal == 1
                                  ? Center(
                                      child: Text(
                                      "17-18M",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600),
                                    ))
                                  : soal == 2
                                      ? Center(
                                          child: Container(
                                          width: 0.7.sw,
                                          child: Text(
                                            "Raden Qosim dan Sufiyah",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ))
                                      : soal == 3
                                          ? Center(
                                              child: Text(
                                              "Cara perdagangan",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w600),
                                            ))
                                          : soal == 4
                                              ? Center(
                                                  child: Text(
                                                  "ii,iii,iv",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ))
                                              : soal == 5
                                                  ? Center(
                                                      child: Text(
                                                      "Ing ngarso sung tulodho",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ))
                                                  : soal == 6
                                                      ? Center(
                                                          child: Text(
                                                          "Lontar dan Wilus",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ))
                                                      : soal == 7
                                                          ? Center(
                                                              child: Text(
                                                              "Sunan Gunung Jati",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ))
                                                          : soal == 8
                                                              ? Center(
                                                                  child:
                                                                      Container(
                                                                  width: 0.7.sw,
                                                                  child: Text(
                                                                    "Tetap melaksanakan kebudayaan-kebudayaan Hindu dan menyisipkan dengan nilai-nilai islami",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize: 12
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                ))
                                                              : soal == 9
                                                                  ? Center(
                                                                      child:
                                                                          Container(
                                                                      width: 0.7
                                                                          .sw,
                                                                      child:
                                                                          Text(
                                                                        "Untuk mandi warga sekitar dan mengisi tempat cadangan air warga",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 12.sp,
                                                                            fontWeight: FontWeight.w600),
                                                                      ),
                                                                    ))
                                                                  : soal == 10
                                                                      ? Center(
                                                                          child:
                                                                              Container(
                                                                          width:
                                                                              0.7.sw,
                                                                          child:
                                                                              Text(
                                                                            "Tempat suci berkumpulnya para dewa ",
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: 12.sp,
                                                                                fontWeight: FontWeight.w600),
                                                                          ),
                                                                        ))
                                                                      : soal ==
                                                                              11
                                                                          ? Center(
                                                                              child: Container(
                                                                              width: 0.7.sw,
                                                                              child: Text(
                                                                                "Agar keberadaan Sunan Sendang dapat lebih mudah diterima dalam sosial masyarakat Pedukuhan Amitunon",
                                                                                style: TextStyle(color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w600),
                                                                              ),
                                                                            ))
                                                                          : soal == 12
                                                                              ? Center(
                                                                                  child: Text(
                                                                                  "1525 M dan 25 November 1580 M ",
                                                                                  style: TextStyle(color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w600),
                                                                                ))
                                                                              : soal == 13
                                                                                  ? Center(
                                                                                      child: Container(
                                                                                      width: 0.7.sw,
                                                                                      child: Text(
                                                                                        "Menghargai kebudayaan terdahulu",
                                                                                        style: TextStyle(color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w600),
                                                                                      ),
                                                                                    ))
                                                                                  : soal == 14
                                                                                      ? Center(
                                                                                          child: Text(
                                                                                          "ii,iii,iv",
                                                                                          style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w600),
                                                                                        ))
                                                                                      : soal == 15
                                                                                          ? Center(
                                                                                              child: Container(
                                                                                                width: 0.7.sw,
                                                                                                child: RichText(
                                                                                                    textAlign: TextAlign.justify,
                                                                                                    text: TextSpan(children: <TextSpan>[
                                                                                                      TextSpan(text: "Pintu gapura paduraksa pertama yang dihiasi oleh flora dan fauna yang telah distilir ", style: TextStyle(color: Colors.black)),
                                                                                                      // TextSpan(
                                                                                                      //   text: "tajug tumpang ",
                                                                                                      //   style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
                                                                                                      // ),
                                                                                                      // TextSpan(
                                                                                                      //   text: " dengan tiga sap dan mustoko di bagian puncaknya",
                                                                                                      //   style: TextStyle(color: Colors.black),
                                                                                                      // )
                                                                                                    ])),
                                                                                                // Text(
                                                                                                //   "Siswa dapat menjelaskan proses islamisasi di wilayah Sendang Duwur Di Kabupaten Lamongan melalui penggunaan aplikasi ",
                                                                                                //   textAlign: TextAlign.justify,
                                                                                                // ),
                                                                                              ),
                                                                                            )
                                                                                          : soal == 16
                                                                                              ? Center(
                                                                                                  child: Container(
                                                                                                    width: 0.7.sw,
                                                                                                    child: RichText(
                                                                                                        textAlign: TextAlign.justify,
                                                                                                        text: TextSpan(children: <TextSpan>[
                                                                                                          TextSpan(text: "Bersedekah ke keluarga dan masyarakat sekitar sebagai bentuk rasa syukur atas nikmat dari pada melarung sesaji di laut untuk sedekah bumi", style: TextStyle(color: Colors.black)),
                                                                                                          // TextSpan(
                                                                                                          //   text: "tajug tumpang ",
                                                                                                          //   style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
                                                                                                          // ),
                                                                                                          // TextSpan(
                                                                                                          //   text: " dengan tiga sap dan mustoko di bagian puncaknya",
                                                                                                          //   style: TextStyle(color: Colors.black),
                                                                                                          // )
                                                                                                        ])),
                                                                                                    // Text(
                                                                                                    //   "Siswa dapat menjelaskan proses islamisasi di wilayah Sendang Duwur Di Kabupaten Lamongan melalui penggunaan aplikasi ",
                                                                                                    //   textAlign: TextAlign.justify,
                                                                                                    // ),
                                                                                                  ),
                                                                                                )
                                                                                              : soal == 17
                                                                                                  ? Center(
                                                                                                      child: Container(
                                                                                                        width: 0.7.sw,
                                                                                                        child: RichText(
                                                                                                            textAlign: TextAlign.justify,
                                                                                                            text: TextSpan(children: <TextSpan>[
                                                                                                              TextSpan(text: "Merupakan ciri unsur kebudayaan masa transisi Hindu menuju Islam", style: TextStyle(color: Colors.black)),
                                                                                                              // TextSpan(
                                                                                                              //   text: "tajug tumpang ",
                                                                                                              //   style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
                                                                                                              // ),
                                                                                                              // TextSpan(
                                                                                                              //   text: " dengan tiga sap dan mustoko di bagian puncaknya",
                                                                                                              //   style: TextStyle(color: Colors.black),
                                                                                                              // )
                                                                                                            ])),
                                                                                                        // Text(
                                                                                                        //   "Siswa dapat menjelaskan proses islamisasi di wilayah Sendang Duwur Di Kabupaten Lamongan melalui penggunaan aplikasi ",
                                                                                                        //   textAlign: TextAlign.justify,
                                                                                                        // ),
                                                                                                      ),
                                                                                                    )
                                                                                                  : soal == 18
                                                                                                      ? Center(
                                                                                                          child: Container(
                                                                                                            width: 0.7.sw,
                                                                                                            child: RichText(
                                                                                                                textAlign: TextAlign.justify,
                                                                                                                text: TextSpan(children: <TextSpan>[
                                                                                                                  TextSpan(text: "Mlakuo kang bener lan Ilingo wong kang sak mburimu", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black)),
                                                                                                                  // TextSpan(
                                                                                                                  //   text: "tajug tumpang ",
                                                                                                                  //   style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
                                                                                                                  // ),
                                                                                                                  // TextSpan(
                                                                                                                  //   text: " dengan tiga sap dan mustoko di bagian puncaknya",
                                                                                                                  //   style: TextStyle(color: Colors.black),
                                                                                                                  // )
                                                                                                                ])),
                                                                                                          ),
                                                                                                        )
                                                                                                      : soal == 19
                                                                                                          ? Center(
                                                                                                              child: Container(
                                                                                                                width: 0.7.sw,
                                                                                                                child: RichText(
                                                                                                                    textAlign: TextAlign.justify,
                                                                                                                    text: TextSpan(children: <TextSpan>[
                                                                                                                      TextSpan(text: "Menjamu para tamu yang telah datang ke acara Haul Akbar Sunan Sendang Duwur", style: TextStyle(color: Colors.black)),
                                                                                                                    ])),
                                                                                                              ),
                                                                                                            )
                                                                                                          : soal == 20
                                                                                                              ? Center(
                                                                                                                  child: RichText(
                                                                                                                      textAlign: TextAlign.justify,
                                                                                                                      text: TextSpan(children: <TextSpan>[
                                                                                                                        TextSpan(text: "i,iv,v", style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w600))
                                                                                                                      ])),
                                                                                                                )
                                                                                                              : Center(
                                                                                                                  child: Text(
                                                                                                                  "",
                                                                                                                  style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w600),
                                                                                                                )),
                            ),
                          ),
                          10.verticalSpace,
                          InkWell(
                            onTap: () {
                              selected[soal - 1] = 5;
                              setState(() {});
                            },
                            child: Container(
                              width: 0.8.sw,
                              height: 0.2.sw,
                              decoration: BoxDecoration(
                                  color: selected[soal - 1] == 5
                                      ? Color.fromRGBO(227, 205, 148, 1)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 5.0,
                                        color: Colors.black12,
                                        spreadRadius: 5.0,
                                        offset: Offset(0, 2))
                                  ]),
                              child: soal == 1
                                  ? Center(
                                      child: Text(
                                      "13-15M",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600),
                                    ))
                                  : soal == 2
                                      ? Center(
                                          child: Container(
                                          width: 0.7.sw,
                                          child: Text(
                                            "Raden Maqdum dan Nyai Ageng Manila",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ))
                                      : soal == 3
                                          ? Center(
                                              child: Text(
                                              "Cara kebudayaan",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w600),
                                            ))
                                          : soal == 4
                                              ? Center(
                                                  child: Text(
                                                  "i,iii,v",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ))
                                              : soal == 5
                                                  ? Center(
                                                      child: Text(
                                                      "Becik ketitik ala ketara",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ))
                                                  : soal == 6
                                                      ? Center(
                                                          child: Text(
                                                          "Randu dan Pinus",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ))
                                                      : soal == 7
                                                          ? Center(
                                                              child: Text(
                                                              "Sunan Drajat",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ))
                                                          : soal == 8
                                                              ? Center(
                                                                  child:
                                                                      Container(
                                                                  width: 0.7.sw,
                                                                  child: Text(
                                                                    "Di bangunnya sumur di sebelah timur Masjid Sunan Sendang Duwur",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize: 12
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                ))
                                                              : soal == 9
                                                                  ? Center(
                                                                      child:
                                                                          Container(
                                                                      width: 0.7
                                                                          .sw,
                                                                      child:
                                                                          Text(
                                                                        "Untuk di jual kepada warga sekitar yang notabennya merupakan bukit kapur yang sulit persediaan air pada musim kemarau",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 12.sp,
                                                                            fontWeight: FontWeight.w600),
                                                                      ),
                                                                    ))
                                                                  : soal == 10
                                                                      ? Center(
                                                                          child:
                                                                              Container(
                                                                          width:
                                                                              0.7.sw,
                                                                          child:
                                                                              Text(
                                                                            "Tanah warisan yang diberikan oleh Sunan Drajat karena kagum dengan kehebatan ilmu Sunan Sendang Duwur",
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: 12.sp,
                                                                                fontWeight: FontWeight.w600),
                                                                          ),
                                                                        ))
                                                                      : soal ==
                                                                              11
                                                                          ? Center(
                                                                              child: Container(
                                                                              width: 0.7.sw,
                                                                              child: Text(
                                                                                "Karena dalam dakwahnya agar terhindar dari kekerasan yang bertentangan dengan nilai-nilai proses islamisasi. ",
                                                                                style: TextStyle(color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w600),
                                                                              ),
                                                                            ))
                                                                          : soal == 12
                                                                              ? Center(
                                                                                  child: Text(
                                                                                  "1511 M dan 1 Agustus 1586 M ",
                                                                                  style: TextStyle(color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w600),
                                                                                ))
                                                                              : soal == 13
                                                                                  ? Center(
                                                                                      child: Container(
                                                                                      width: 0.7.sw,
                                                                                      child: Text(
                                                                                        "Sebagai ciri bahwasanya islam masuk tidak menghilanggan budaya yang sudah ada tetapi menggabungkan dengan nilai-nilai islami",
                                                                                        style: TextStyle(color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w600),
                                                                                      ),
                                                                                    ))
                                                                                  : soal == 14
                                                                                      ? Center(
                                                                                          child: Text(
                                                                                          "i,ii,iii,iv,v",
                                                                                          style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w600),
                                                                                        ))
                                                                                      : soal == 15
                                                                                          ? Center(
                                                                                              child: Container(
                                                                                                width: 0.7.sw,
                                                                                                child: RichText(
                                                                                                    textAlign: TextAlign.justify,
                                                                                                    text: TextSpan(children: <TextSpan>[
                                                                                                      TextSpan(text: "Mimbar lama pada Masjid Sunan Sendang Duwur yang memiliki ragam hias kepala kala dan flora yang telah distilir", style: TextStyle(color: Colors.black)),
                                                                                                      // TextSpan(
                                                                                                      //   text: "tajug tumpang ",
                                                                                                      //   style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
                                                                                                      // ),
                                                                                                      // TextSpan(
                                                                                                      //   text: " dengan tiga sap dan mustoko di bagian puncaknya",
                                                                                                      //   style: TextStyle(color: Colors.black),
                                                                                                      // )
                                                                                                    ])),
                                                                                                // Text(
                                                                                                //   "Siswa dapat menjelaskan proses islamisasi di wilayah Sendang Duwur Di Kabupaten Lamongan melalui penggunaan aplikasi ",
                                                                                                //   textAlign: TextAlign.justify,
                                                                                                // ),
                                                                                              ),
                                                                                            )
                                                                                          : soal == 16
                                                                                              ? Center(
                                                                                                  child: Container(
                                                                                                    width: 0.7.sw,
                                                                                                    child: RichText(
                                                                                                        textAlign: TextAlign.justify,
                                                                                                        text: TextSpan(children: <TextSpan>[
                                                                                                          TextSpan(text: "Menginternaisasi nilai-nilai isilam pada kebudayaan musik Terbang Jidor dengan lantunan shalawat ", style: TextStyle(color: Colors.black)),
                                                                                                          // TextSpan(
                                                                                                          //   text: "tajug tumpang ",
                                                                                                          //   style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
                                                                                                          // ),
                                                                                                          // TextSpan(
                                                                                                          //   text: " dengan tiga sap dan mustoko di bagian puncaknya",
                                                                                                          //   style: TextStyle(color: Colors.black),
                                                                                                          // )
                                                                                                        ])),
                                                                                                    // Text(
                                                                                                    //   "Siswa dapat menjelaskan proses islamisasi di wilayah Sendang Duwur Di Kabupaten Lamongan melalui penggunaan aplikasi ",
                                                                                                    //   textAlign: TextAlign.justify,
                                                                                                    // ),
                                                                                                  ),
                                                                                                )
                                                                                              : soal == 17
                                                                                                  ? Center(
                                                                                                      child: Container(
                                                                                                        width: 0.7.sw,
                                                                                                        child: RichText(
                                                                                                            textAlign: TextAlign.justify,
                                                                                                            text: TextSpan(children: <TextSpan>[
                                                                                                              TextSpan(text: "Melanjutkan kebudayaan masyarakat Hindu agar terjalin toleransi", style: TextStyle(color: Colors.black)),
                                                                                                              // TextSpan(
                                                                                                              //   text: "tajug tumpang ",
                                                                                                              //   style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
                                                                                                              // ),
                                                                                                              // TextSpan(
                                                                                                              //   text: " dengan tiga sap dan mustoko di bagian puncaknya",
                                                                                                              //   style: TextStyle(color: Colors.black),
                                                                                                              // )
                                                                                                            ])),
                                                                                                        // Text(
                                                                                                        //   "Siswa dapat menjelaskan proses islamisasi di wilayah Sendang Duwur Di Kabupaten Lamongan melalui penggunaan aplikasi ",
                                                                                                        //   textAlign: TextAlign.justify,
                                                                                                        // ),
                                                                                                      ),
                                                                                                    )
                                                                                                  : soal == 18
                                                                                                      ? Center(
                                                                                                          child: RichText(
                                                                                                              textAlign: TextAlign.justify,
                                                                                                              text: TextSpan(children: <TextSpan>[
                                                                                                                TextSpan(text: "Gurhaning Saira Tirta Hayu", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black)),
                                                                                                                // TextSpan(
                                                                                                                //   text: "tajug tumpang ",
                                                                                                                //   style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
                                                                                                                // ),
                                                                                                                // TextSpan(
                                                                                                                //   text: " dengan tiga sap dan mustoko di bagian puncaknya",
                                                                                                                //   style: TextStyle(color: Colors.black),
                                                                                                                // )
                                                                                                              ])),
                                                                                                        )
                                                                                                      : soal == 19
                                                                                                          ? Center(
                                                                                                              child: Container(
                                                                                                                width: 0.7.sw,
                                                                                                                child: RichText(
                                                                                                                    textAlign: TextAlign.justify,
                                                                                                                    text: TextSpan(children: <TextSpan>[
                                                                                                                      TextSpan(text: "Sedekah bumi karena di berikan kelimpahan nikmat dalam bentuk bahan makanan", style: TextStyle(color: Colors.black)),
                                                                                                                    ])),
                                                                                                              ),
                                                                                                            )
                                                                                                          : soal == 20
                                                                                                              ? Center(
                                                                                                                  child: RichText(
                                                                                                                      textAlign: TextAlign.justify,
                                                                                                                      text: TextSpan(children: <TextSpan>[
                                                                                                                        TextSpan(text: "i,iii,iv", style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w600))
                                                                                                                      ])),
                                                                                                                )
                                                                                                              : Center(
                                                                                                                  child: Text(
                                                                                                                  "",
                                                                                                                  style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w600),
                                                                                                                )),
                            ),
                          ),
                          20.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (soal == 1) {
                                    Fluttertoast.showToast(
                                        msg:
                                            "kamu telah berada di soal yang pertama !",
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white);
                                  } else {
                                    setState(() {
                                      soal = soal - 1;
                                    });
                                  }
                                },
                                child: Container(
                                  width: 0.15.sw,
                                  height: 0.15.sw,
                                  decoration: BoxDecoration(
                                      color: soal == 1
                                          ? Colors.grey[400]
                                          : Color.fromRGBO(197, 133, 95, 1),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 5.0,
                                            color: Colors.black12,
                                            spreadRadius: 2.0,
                                            offset: Offset(0, 2))
                                      ],
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      size: 20.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              dataUser[0].username != "admin"
                                  ? InkWell(
                                      onTap: () {
                                        showAlertDialog(context);
                                      },
                                      child: Container(
                                        width: 0.4.sw,
                                        height: 0.15.sw,
                                        decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                                227, 205, 148, 1),
                                            // color: Color.fromRGBO(197, 133, 95, 1),
                                            // color: Color.fromRGBO(54, 37, 35, 1),
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 5.0,
                                                  color: Colors.black12,
                                                  spreadRadius: 2.0,
                                                  offset: Offset(0, 2))
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                            child: Text(
                                          "Submit",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.sp,
                                              color: Colors.white
                                              // color: Color.fromRGBO(227, 205, 148, 1),
                                              // color: Color.fromRGBO(197, 133, 95, 1),
                                              // color: Color.fromRGBO(54, 37, 35, 1),
                                              ),
                                          textAlign: TextAlign.center,
                                        )),
                                      ),
                                    )
                                  : Text(""),
                              InkWell(
                                onTap: () {
                                  if (soal == 20) {
                                    Fluttertoast.showToast(
                                        msg:
                                            "kamu telah berada di soal yang terakhir !",
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white);
                                  } else {
                                    setState(() {
                                      soal = soal + 1;
                                    });
                                  }
                                },
                                child: Container(
                                  width: 0.15.sw,
                                  height: 0.15.sw,
                                  decoration: BoxDecoration(
                                      color: soal == 20
                                          ? Colors.grey[400]
                                          : Color.fromRGBO(197, 133, 95, 1),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 5.0,
                                            color: Colors.black12,
                                            spreadRadius: 2.0,
                                            offset: Offset(0, 2))
                                      ],
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 20.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          20.verticalSpace
                        ]),
        ),
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
                      "Evaluasi",
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
      ]),
    );
  }
}
