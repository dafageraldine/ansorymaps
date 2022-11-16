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

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final regexnama = RegExp(r'^[a-zA-Z ]+$');
  final regexnomor = RegExp(r'^[0-9 ]+$');
  final regexkelas = RegExp(r'^[a-zA-Z0-9 ]+$');
  TextEditingController name = TextEditingController();
  TextEditingController kelas = TextEditingController();
  TextEditingController absen = TextEditingController();
  TextEditingController uname = TextEditingController();
  TextEditingController pass = TextEditingController();
  var isloading = 0;

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
      setState(() {
        isloading = 1;
      });
      // print("daftar");
      if (name.text == "" ||
          kelas.text == "" ||
          absen.text == "" ||
          uname.text == "" ||
          pass.text == "") {
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
      } else if (uname.text.length < 8) {
        setState(() {
          isloading = 0;
        });
        showAlertDialog(context, "username harus 8 karakter atau lebih !");
        return;
      } else if (pass.text.length < 8) {
        setState(() {
          isloading = 0;
        });
        showAlertDialog(context, "password harus 8 karakter atau lebih !");
        return;
      }
      if (name.text.toString().trim().length > 25 ||
          kelas.text.toString().trim().length > 25 ||
          absen.text.toString().trim().length > 25 ||
          uname.text.toString().trim().length > 25 ||
          pass.text.toString().trim().length > 25) {
        setState(() {
          isloading = 0;
        });
        showAlertDialog(context, "panjang karakter  maksimal 25 huruf !");
        return;
      } else if (!regexnama.hasMatch(name.text)) {
        setState(() {
          isloading = 0;
        });
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

      var body = {
        "absen": absen.text,
        "kelas": kelas.text,
        "nama siswa": name.text,
        "username": uname.text,
        "pass": pass.text
      };
      http.Response cek =
          await http.post(Uri.parse(baseurl + "register"), body: body);
      // print(cek.body);
      var data = json.decode(cek.body);
      // print(cek.body);
      setState(() {
        isloading = 0;
      });
      if (data["data"] == "sukses") {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('uname');
        await prefs.remove('pass');
        await prefs.setString('uname', uname.text);
        await prefs.setString('pass', pass.text);
        dataUser.clear();
        dataUser.add(DataUser(
            name.text, kelas.text, absen.text, uname.text, data["id"]));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Bottom(1)));
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

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 0.05.sh),
            child: Align(
              alignment: Alignment.center,
              child: Image.asset(
                fit: BoxFit.fill,
                "assets/logo.png",
                width: 0.4.sw,
                height: 0.4.sw,
              ),
            ),
          ),
          20.verticalSpace,
          Container(
            width: 0.7.sw,
            height: 0.07.sh,
            child: TextFormField(
                controller: name,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Nama Siswa")),
          ),
          20.verticalSpace,
          Container(
            width: 0.7.sw,
            height: 0.07.sh,
            child: TextFormField(
                controller: kelas,
                // obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Kelas")),
          ),
          20.verticalSpace,
          Container(
            width: 0.7.sw,
            height: 0.07.sh,
            child: TextFormField(
                controller: absen,
                // obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Nomor Absen")),
          ),
          20.verticalSpace,
          Container(
            width: 0.7.sw,
            height: 0.07.sh,
            child: TextFormField(
                controller: uname,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Username")),
          ),
          20.verticalSpace,
          Container(
            width: 0.7.sw,
            height: 0.07.sh,
            child: TextFormField(
                controller: pass,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Password")),
          ),
          15.verticalSpace,
          InkWell(
            onTap: () async {
              if (isloading == 0) {
                await register();
              }
            },
            child: isloading == 1
                ? Center(
                    child: CircularProgressIndicator(
                      color: Color.fromRGBO(54, 37, 35, 1),
                    ),
                  )
                : Container(
                    width: 0.7.sw,
                    height: 0.07.sh,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 207, 146, 1),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                        child: Text(
                      "Daftar",
                      style: TextStyle(
                          color: Color.fromRGBO(54, 37, 35, 1),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600),
                    )),
                  ),
          ),
          10.verticalSpace,
          Text(
            "Sudah punya akun ?",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
          ),
          10.verticalSpace,
          InkWell(
            onTap: () async {
              if (isloading == 0) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              }
            },
            child: Container(
              width: 0.7.sw,
              height: 0.07.sh,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(54, 37, 35, 1),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                  child: Text(
                "Masuk",
                style: TextStyle(
                    color: Color.fromRGBO(227, 205, 148, 1),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600),
              )),
            ),
          ),
        ],
      )),
    );
  }
}
