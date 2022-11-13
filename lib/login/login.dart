import 'dart:convert';

import 'package:ansory/bottombar.dart';
import 'package:ansory/data/data.dart';
import 'package:ansory/login/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var isloading = 0;
  TextEditingController uname = TextEditingController();
  TextEditingController pass = TextEditingController();

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

  Future login() async {
    try {
      print("loginnn");
      var body = {"username": uname.text, "pass": pass.text};
      http.Response cek =
          await http.post(Uri.parse(baseurl + "login"), body: body);
      // print(cek.body);
      var data = json.decode(cek.body);
      print(cek.body);
      if (data["data"] == "sukses") {
        setState(() {
          isloading = 0;
        });
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('uname');
        await prefs.remove('pass');
        await prefs.setString('uname', uname.text);
        await prefs.setString('pass', pass.text);
        dataUser.clear();
        dataUser.add(DataUser(data["nama"], data["kelas"], data["absen"],
            data["username"], data["id"]));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Bottom(1)));
      } else {
        setState(() {
          isloading = 0;
        });
        showAlertDialog(context, data["data"].toString());
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
            padding: EdgeInsets.only(top: 0.12.sh),
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
          20.verticalSpace,
          InkWell(
            onTap: () async {
              setState(() {
                isloading = 1;
              });
              await login();
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
                          "Masuk",
                          style: TextStyle(
                              color: Color.fromRGBO(227, 205, 148, 1),
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600),
                        )),
            ),
          ),
          10.verticalSpace,
          Text(
            "Belum punya akun ?",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
          ),
          10.verticalSpace,
          InkWell(
            onTap: () async {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Register()));
            },
            child: Container(
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
        ],
      )),
    );
  }
}
