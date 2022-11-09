import 'dart:convert';

import 'package:ansory/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ReportSiswa extends StatefulWidget {
  const ReportSiswa({Key? key}) : super(key: key);

  @override
  State<ReportSiswa> createState() => _ReportSiswaState();
}

class _ReportSiswaState extends State<ReportSiswa> {
  TextEditingController likes = TextEditingController();
  var iserror = 0;
  var isloading = 0;
  var selected_filter = 0;
  var text_like = "";
  List<Datasiswa> listTampil = <Datasiswa>[];

  filter(String type) async {
    if (type == "nilai") {
      if (likes.text != "") {
        listTampil.sort((a, b) => a.nilai.compareTo(b.nilai));
        setState(() {
          selected_filter = 1;
        });
      } else {
        listTampil.clear();
        for (var i = 0; i < listDataSiswa.length; i++) {
          if (listDataSiswa[i].nilai != "belum tes") {
            listTampil.add(listDataSiswa[i]);
          }
        }
        listTampil.sort((a, b) => b.nilai.compareTo(a.nilai));
        for (var i = 0; i < listDataSiswa.length; i++) {
          if (listDataSiswa[i].nilai == "belum tes") {
            listTampil.add(listDataSiswa[i]);
          }
        }
        setState(() {
          selected_filter = 1;
        });
      }
    } else if (type == "nama") {
      if (likes.text != "") {
        listTampil.sort(((a, b) => a.nama.compareTo(b.nama)));
        setState(() {
          selected_filter = 2;
        });
      } else {
        listTampil.clear();
        listTampil.addAll(listDataSiswa);
        listTampil.sort(((a, b) => a.nama.compareTo(b.nama)));
        setState(() {
          selected_filter = 2;
        });
      }
    } else if (type == "absen") {
      if (likes.text != "") {
        listTampil.sort(((a, b) => double.parse(a.absen)
            .round()
            .compareTo(double.parse(b.absen))
            .round()));
        setState(() {
          selected_filter = 3;
        });
      } else {
        listTampil.clear();
        listTampil.addAll(listDataSiswa);
        listTampil.sort(((a, b) => double.parse(a.absen)
            .round()
            .compareTo(double.parse(b.absen))
            .round()));
        setState(() {
          selected_filter = 3;
        });
      }
    } else if (type == "kelas") {
      if (likes.text != "") {
        listTampil.sort(((a, b) => double.parse(a.absen)
            .round()
            .compareTo(double.parse(b.absen))
            .round()));
        setState(() {
          selected_filter = 4;
        });
      } else {
        listTampil.clear();
        listTampil.addAll(listDataSiswa);
        listTampil.sort(((a, b) => a.kelas.compareTo(b.kelas)));
        setState(() {
          selected_filter = 4;
        });
      }
    } else {
      await isidata();
      listTampil.clear();
      for (var i = 0; i < listDataSiswa.length; i++) {
        if (listDataSiswa[i].nama.contains(type)) {
          listTampil.add(listDataSiswa[i]);
        } else if (listDataSiswa[i].kelas.contains(type)) {
          listTampil.add(listDataSiswa[i]);
        }
      }
      if (selected_filter == 1) {
        listTampil.sort((a, b) => a.nilai.compareTo(b.nilai));
      } else if (selected_filter == 2) {
        listTampil.sort(((a, b) => a.nama.compareTo(b.nama)));
        // filter("nama");
      } else if (selected_filter == 3) {
        // filter("absen");
        listTampil.sort(((a, b) => double.parse(a.absen)
            .round()
            .compareTo(double.parse(b.absen))
            .round()));
      } else if (selected_filter == 4) {
        // filter("kelas");
        listTampil.sort(((a, b) => a.kelas.compareTo(b.kelas)));
      }
      setState(() {});
      // else {
      //   filter("nama");
      // }
    }
  }

  Future<void> isidata() async {
    listTampil.clear();
    listDataSiswa.clear();
    setState(() {
      isloading = 1;
      iserror = 0;
    });
    // listDataSiswa.add(Datasiswa(
    //     "dafa geraldine", "12 ipa 1", "20", "belum tes", "xuygyfde", "dafa99"));
    try {
      // print("loginnn");
      http.Response cek = await http.get(Uri.parse(baseurl + "getdatasiswa"));
      print(cek.body);
      var data = json.decode(cek.body);
      // print(cek.body);
      if (data["data"].length > 0) {
        for (var i = 0; i < data["data"].length; i++) {
          if (data["data"][i]["username"] != "admin") {
            listDataSiswa.add(Datasiswa(
                data["data"][i]["nama"],
                data["data"][i]["kelas"],
                data["data"][i]["absen"].toString(),
                data["data"][i]["nilai"].toString(),
                data["data"][i]["id"],
                data["data"][i]["username"]));
          }
        }
        listTampil.addAll(listDataSiswa);
        // filter("nama");
        setState(() {
          isloading = 0;
          iserror = 0;
        });
      } else {
        setState(() {
          iserror = 0;
          isloading = 0;
        });
        // showAlertDialog(context, data["data"].toString());
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: Colors.black,
          textColor: Colors.white);
      setState(() {
        iserror = 1;
        isloading = 0;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    isidata();
    super.initState();
  }

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
          child: Container(
            width: 0.85.sw,
            height: 0.62.sh,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 0.1.sw, top: 0.02.sh),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Filter pencarian",
                        style: TextStyle(
                            color: Color.fromRGBO(82, 82, 82, 1),
                            fontSize: 14.sp,
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
                        "Urutkan Berdasarkan",
                        style: TextStyle(
                            color: Color.fromRGBO(82, 82, 82, 1),
                            fontSize: 12.sp,
                            // fontFamily: 'Inter',
                            fontWeight: FontWeight.w400),
                      )),
                ),
                5.verticalSpace,
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    filter("nama");
                  },
                  child: Container(
                      width: 0.5.sw,
                      height: 0.05.sh,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 2.0,
                              color: Colors.black12,
                              spreadRadius: 2.0,
                              offset: Offset(0, 2))
                        ],
                        color: selected_filter == 2
                            ? Colors.grey[600]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: Text(
                        "nama",
                        style: TextStyle(
                            color: selected_filter == 2
                                ? Colors.white
                                : Colors.grey[600],
                            fontWeight: FontWeight.w600),
                      ))),
                ),
                5.verticalSpace,
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    filter("nilai");
                  },
                  child: Container(
                      width: 0.5.sw,
                      height: 0.05.sh,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 2.0,
                              color: Colors.black12,
                              spreadRadius: 2.0,
                              offset: Offset(0, 2))
                        ],
                        color: selected_filter == 1
                            ? Colors.grey[600]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: Text(
                        "nilai",
                        style: TextStyle(
                            color: selected_filter == 1
                                ? Colors.white
                                : Colors.grey[600],
                            fontWeight: FontWeight.w600),
                      ))),
                ),
                5.verticalSpace,
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    filter("kelas");
                  },
                  child: Container(
                      width: 0.5.sw,
                      height: 0.05.sh,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 2.0,
                              color: Colors.black12,
                              spreadRadius: 2.0,
                              offset: Offset(0, 2))
                        ],
                        color: selected_filter == 4
                            ? Colors.grey[600]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: Text(
                        "kelas",
                        style: TextStyle(
                            color: selected_filter == 4
                                ? Colors.white
                                : Colors.grey[600],
                            fontWeight: FontWeight.w600),
                      ))),
                ),
                5.verticalSpace,
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    filter("absen");
                  },
                  child: Container(
                      width: 0.5.sw,
                      height: 0.05.sh,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 2.0,
                              color: Colors.black12,
                              spreadRadius: 2.0,
                              offset: Offset(0, 2))
                        ],
                        color: selected_filter == 3
                            ? Colors.grey[600]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: Text(
                        "absen",
                        style: TextStyle(
                            color: selected_filter == 3
                                ? Colors.white
                                : Colors.grey[600],
                            fontWeight: FontWeight.w600),
                      ))),
                ),
                10.verticalSpace,
                Padding(
                  padding: EdgeInsets.only(
                    left: 0.1.sw,
                  ),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Cari Berdasarkan nama / kelas",
                        style: TextStyle(
                            color: Color.fromRGBO(82, 82, 82, 1),
                            fontSize: 12.sp,
                            // fontFamily: 'Inter',
                            fontWeight: FontWeight.w400),
                      )),
                ),
                5.verticalSpace,
                Container(
                  width: 0.5.sw,
                  height: 0.05.sh,
                  child: Center(
                    child: TextFormField(
                        controller: likes,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "contoh : budi")),
                  ),
                ),
                10.verticalSpace,
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    filter(likes.text);
                  },
                  child: Container(
                    width: 0.7.sw,
                    height: 0.07.sh,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(227, 205, 148, 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      "Cari",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    )),
                  ),
                ),
                10.verticalSpace,
                InkWell(
                  onTap: () async {
                    Navigator.of(context).pop();
                    selected_filter = 0;
                    likes.clear();
                    await isidata();
                  },
                  child: Container(
                    width: 0.7.sw,
                    height: 0.07.sh,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(54, 37, 35, 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      "Reset",
                      style: TextStyle(
                          color: Color.fromRGBO(227, 205, 148, 1),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    )),
                  ),
                ),
                15.verticalSpace,
              ],
            ),
          ),
        );
      },
    );
  }

  final columns = ['Action', 'Nama Siswa', 'Kelas', 'Absen', 'Nilai'];

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget(columns[0], 0.23.sw),
      _getTitleItemWidget(columns[1], 0.52.sw),
      _getTitleItemWidget(columns[2], 0.23.sw),
      _getTitleItemWidget(columns[3], 0.23.sw),
      _getTitleItemWidget(columns[4], 0.2.sw)
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      child: Center(
          child: Text(label, style: TextStyle(fontWeight: FontWeight.bold))),
      width: width,
      height: 0.06.sh,
      color: Colors.grey,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        if (listTampil[index].nilai != "belum tes") {}
      },
      child: Container(
        width: 0.23.sw,
        height: 0.05.sh,
        child: Center(
          child: Container(
            // ignore: sort_child_properties_last
            decoration: BoxDecoration(
                color: listTampil[index].nilai == "belum tes"
                    ? Colors.lightBlue
                    : Color.fromRGBO(54, 37, 35, 1),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: listTampil[index].nilai == "belum tes"
                  ? Text("Belum tes",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          fontSize: 11.sp))
                  : Text("Delete",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            width: 0.2.sw,
            height: 0.035.sh,
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          ),
        ),
      ),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          child: Center(
            child: Text(
              listTampil[index].nama,
              style: TextStyle(fontSize: 12.sp),
            ),
          ),
          width: 0.52.sw,
          height: 0.05.sh,
          decoration: BoxDecoration(
              color: index % 2 == 1 ? Colors.grey[300] : Colors.white,
              border: Border(left: BorderSide(width: 2, color: Colors.grey))),
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        InkWell(
          onTap: () async {
            // if (getdata == "1") {
            //   Fluttertoast.showToast(
            //       msg: "getting report on process, please wait !",
            //       backgroundColor: Colors.black,
            //       textColor: Colors.white);
            // } else {
            //   print("selected index ==> " +
            //       index.toString() +
            //       " " +
            //       listReportAtRo[index].NOO);
            //   await get_noo_this_year_detail_(index);
            // }
          },
          child: Container(
            child: Center(child: Text(listTampil[index].kelas)),
            width: 0.23.sw,
            height: 0.05.sh,
            decoration: BoxDecoration(
                color: index % 2 == 1 ? Colors.grey[300] : Colors.white,
                border: Border(left: BorderSide(width: 2, color: Colors.grey))),
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          ),
        ),
        InkWell(
          onTap: () async {
            // if (getdata == "1") {
            //   Fluttertoast.showToast(
            //       msg: "getting report on process, please wait !",
            //       backgroundColor: Colors.black,
            //       textColor: Colors.white);
            // } else {
            //   await get_noo_brand_detail_(index);
            // }
          },
          child: Container(
            child: Center(child: Text(listTampil[index].absen)),
            width: 0.23.sw,
            height: 0.05.sh,
            decoration: BoxDecoration(
                color: index % 2 == 1 ? Colors.grey[300] : Colors.white,
                border: Border(left: BorderSide(width: 2, color: Colors.grey))),
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          ),
        ),
        InkWell(
          onTap: () async {
            // if (getdata == "1") {
            //   Fluttertoast.showToast(
            //       msg: "getting report on process, please wait !",
            //       backgroundColor: Colors.black,
            //       textColor: Colors.white);
            // } else {
            //   print("GET RO DETAIL");
            //   await get_ro_detail_(index);
            // }
          },
          child: Container(
            child: Center(
                child: listTampil[index].nilai == "belum tes"
                    ? Text(listTampil[index].nilai)
                    : Text(double.parse(listTampil[index].nilai)
                        .round()
                        .toString())),
            width: 0.2.sw,
            height: 0.05.sh,
            decoration: BoxDecoration(
                color: index % 2 == 1 ? Colors.grey[300] : Colors.white,
                border: Border(left: BorderSide(width: 2, color: Colors.grey))),
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Stack(children: [
        Column(children: [
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
                Padding(
                  padding: EdgeInsets.only(top: 0.028.sh, right: 0.1.sw),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        _showDialogfilter("Search Report", "");
                      },
                      child: Container(
                        width: 0.12.sw,
                        height: 0.12.sw,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Icon(
                          Icons.filter_list_rounded,
                          size: 20.sp,
                          color: Color.fromRGBO(82, 82, 82, 1),
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    45.verticalSpace,
                    Center(
                      child: Text(
                        "Report Nilai Siswa",
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
          iserror == 1
              ? Column(
                  children: [
                    0.12.sh.verticalSpace,
                    Container(
                      width: 0.8.sw,
                      child: Text(
                        "Gagal mendapatkan data silahkan cek koneksi internet mu !",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14.sp),
                      ),
                    ),
                    20.verticalSpace,
                    InkWell(
                      onTap: () async {
                        await isidata();
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
                    )
                  ],
                )
              : isloading == 1
                  ? Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 0.0.sw, top: 0.2.sh),
                          child: LoadingAnimationWidget.threeArchedCircle(
                            color: Color.fromRGBO(233, 207, 146, 1),
                            size: 0.1.sh,
                          ),
                        )
                      ],
                    )
                  : listTampil.isEmpty
                      ? Column(
                          children: [
                            0.12.sh.verticalSpace,
                            Container(
                              width: 0.8.sw,
                              child: Text(
                                "Datasiswa tidak ditemukan !",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp),
                              ),
                            ),
                          ],
                        )
                      : Expanded(
                          child: HorizontalDataTable(
                            headerWidgets: _getTitleWidget(),
                            leftHandSideColumnWidth: 0.23.sw,
                            rightHandSideColumnWidth: 1.18.sw,
                            leftSideItemBuilder: _generateFirstColumnRow,
                            rightSideItemBuilder:
                                _generateRightHandSideColumnRow,
                            isFixedHeader: true,
                            itemCount: listTampil.length == null ||
                                    listTampil.length == 0
                                ? 0
                                : listTampil.length,
                            rowSeparatorWidget: const Divider(
                              color: Colors.black54,
                              height: 1.0,
                              thickness: 0.0,
                            ),
                          ),
                        )
        ]),
      ]),
    );
  }
}
