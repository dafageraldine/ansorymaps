import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'bottombar.dart';
import 'data/data.dart';
import 'login/login.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future login() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? uname_ = prefs.getString('uname');
      final String? pass_ = prefs.getString('pass');
      if (uname_ != null && uname_ != "") {
        print("loginnn");
        var body = {"username": uname_, "pass": pass_};
        http.Response cek =
            await http.post(Uri.parse(baseurl + "login"), body: body);
        // print(cek.body);
        var data = json.decode(cek.body);
        print(cek.body);
        if (data["data"] == "sukses") {
          await prefs.remove('uname');
          await prefs.remove('pass');
          await prefs.setString('uname', uname_);
          await prefs.setString('pass', pass_!);
          dataUser.clear();
          dataUser.add(DataUser(
              data["nama"], data["kelas"], data["absen"], data["username"]));
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Bottom()));
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login()));
        }
      } else {
        Timer(const Duration(seconds: 2), () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login()));
        });
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: Colors.black,
          textColor: Colors.white);
      Timer(const Duration(seconds: 2), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      });
    }
  }

  @override
  void initState() {
    login();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              "assets/logo.png",
              width: 0.6.sw,
              height: 0.6.sw,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Ansory Maps v" + Build + "." + Major + "." + Minor,
                  style: TextStyle(fontWeight: FontWeight.w700),
                )),
          ),
        ],
      ),
    );
  }
}
