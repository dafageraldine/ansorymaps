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
  final regexnama = RegExp(r'^[a-zA-Z ]+$');
  final regexnomor = RegExp(r'^[0-9 ]+$');
  final regexkelas = RegExp(r'^[a-zA-Z0-9 ]+$');
  var isloading = 0;
  TextEditingController name = TextEditingController();
  TextEditingController kelas = TextEditingController();
  TextEditingController absen = TextEditingController();

  showAlertDialog(BuildContext context, String info) {
    // set up the buttons

    Widget continueButton = TextButton(
      child: Text(
        "ok",
        style: TextStyle(color: Color.fromRGBO(187, 121, 91, 1)),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        // await delete();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Warning"),
      content: Text(info),
      actions: [
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

  Future register() async {
    try {
      print(regexnama.hasMatch(name.text));
      if (name.text == "" || kelas.text == "" || absen.text == "") {
        setState(() {
          isloading = 0;
        });
        showAlertDialog(context, "tidak boleh ada data yang kosong !");
        return;
      }
      if (name.text.length < 5) {
        setState(() {
          isloading = 0;
        });
        showAlertDialog(context, "nama harus 5 karakter atau lebih !");
        return;
      } else if (kelas.text.length < 2) {
        setState(() {
          isloading = 0;
        });
        showAlertDialog(context, "kelas harus 2 karakter atau lebih !");
        return;
      } else if (absen.text.length < 2) {
        setState(() {
          isloading = 0;
        });

        showAlertDialog(context, "absen harus 2 karakter atau lebih !");
        return;
      }
      if (name.text.toString().trim().length > 25 ||
          kelas.text.toString().trim().length > 25 ||
          absen.text.toString().trim().length > 25) {
        setState(() {
          isloading = 0;
        });
        showAlertDialog(context, "panjang karakter  maksimal 25 huruf !");
        return;
      } else if (!regexnama.hasMatch(name.text)) {
        setState(() {
          isloading = 0;
        });
        print("here");
        showAlertDialog(context, "hanya boleh menggunakan huruf !");
        return;
      } else if (!regexnomor.hasMatch(absen.text)) {
        setState(() {
          isloading = 0;
        });
        showAlertDialog(context, "hanya boleh menggunakan angka !");
        return;
      } else if (!regexkelas.hasMatch(kelas.text)) {
        setState(() {
          isloading = 0;
        });

        showAlertDialog(context, "hanya boleh menggunakan angka dan huruf !");
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      var body = {
        "absen": absen.text,
        "kelas": kelas.text,
        "nama siswa": name.text,
        "username": dataUser[0].username,
        "pass": prefs.getString('pass')
      };
      http.Response cek =
          await http.post(Uri.parse(baseurl + "register"), body: body);
      // print(cek.body);
      var data = json.decode(cek.body);
      print(cek.body);
      setState(() {
        isloading = 0;
      });
      if (data["data"] == "sukses") {
        dataUser.clear();
        dataUser.add(DataUser(name.text, kelas.text, absen.text,
            prefs.getString('uname').toString(), data["id"]));
        name.text = dataUser[0].nama;
        kelas.text = dataUser[0].kelas;
        absen.text = dataUser[0].absen;
        setState(() {
          isloading = 0;
        });
        showAlertDialog(context, "berhasil edit profile !");
      } else {
        setState(() {
          isloading = 0;
        });
        showAlertDialog(context, "gagal edit profile !");
        return;
      }
    } catch (e) {
      setState(() {
        isloading = 0;
      });
      Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: Colors.black,
          textColor: Colors.white);
    }
  }

  Future<void> deletedata() async {
    try {
      setState(() {
        isloading = 1;
      });
      // print("ini id " + ids.toString());
      var body = {
        "username": dataUser[0].username.toString(),
        "id": dataUser[0].id.toString()
      };
      http.Response cek =
          await http.post(Uri.parse(baseurl + "deletesiswa"), body: body);
      // print(cek.body);
      var data = json.decode(cek.body);
      // print(cek.body);
      if (data["data"] == "berhasil dihapus") {
        await register();
      } else {
        setState(() {
          isloading = 0;
        });
        showAlertDialog(context, "gagal edit profile !");
        return;
      }
    } catch (e) {
      setState(() {
        isloading = 0;
      });
      Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: Colors.black,
          textColor: Colors.white);
    }
  }

  showAlerteditDialog(BuildContext context, String info) {
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
        await deletedata();
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
  void initState() {
    name.text = dataUser[0].nama;
    kelas.text = dataUser[0].kelas;
    absen.text = dataUser[0].absen;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Bottom(2)));

        return true;
      },
      child: Scaffold(
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
                      "Nama Siswa : ",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15.sp),
                    ),
                  ),
                ),
                15.verticalSpace,
                Padding(
                  padding: EdgeInsets.only(left: 0.15.sw),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 0.7.sw,
                      height: 0.07.sh,
                      child: TextFormField(
                          controller: name,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Nama Siswa")),
                    ),
                  ),
                ),
                15.verticalSpace,
                Padding(
                  padding: EdgeInsets.only(left: 0.1.sw),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Kelas : ",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14.sp),
                    ),
                  ),
                ),
                15.verticalSpace,
                Padding(
                  padding: EdgeInsets.only(left: 0.15.sw),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 0.7.sw,
                      height: 0.07.sh,
                      child: TextFormField(
                          controller: kelas,
                          // obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), hintText: "Kelas")),
                    ),
                  ),
                ),
                15.verticalSpace,
                Padding(
                  padding: EdgeInsets.only(left: 0.1.sw),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Absen : ",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14.sp),
                    ),
                  ),
                ),
                15.verticalSpace,
                Padding(
                  padding: EdgeInsets.only(left: 0.15.sw),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 0.7.sw,
                      height: 0.07.sh,
                      child: TextFormField(
                          controller: absen,
                          // obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Nomor Absen")),
                    ),
                  ),
                ),
                20.verticalSpace,
                InkWell(
                  onTap: () async {
                    setState(() {
                      isloading = 1;
                    });
                    showAlerteditDialog(
                        context, "apakah anda ingin simpan perubahan ?");
                    // await login();
                  },
                  child: Container(
                    width: 0.7.sw,
                    height: 0.07.sh,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(54, 37, 35, 1),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                        child: isloading == 1
                            ? CircularProgressIndicator(
                                color: Color.fromRGBO(227, 205, 148, 1),
                              )
                            : Text(
                                "Simpan",
                                style: TextStyle(
                                    color: Color.fromRGBO(227, 205, 148, 1),
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600),
                              )),
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Bottom(2)));
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
      ),
    );
  }
}
