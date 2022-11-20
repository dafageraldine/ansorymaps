// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:ansory/galeri/galeridetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailMateri extends StatefulWidget {
  final String materi;
  const DetailMateri(this.materi, {Key? key}) : super(key: key);

  @override
  State<DetailMateri> createState() => _DetailMateriState();
}

class _DetailMateriState extends State<DetailMateri> {
  late YoutubePlayerController _controller;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  bool isFullScreen = false;
  int vidselected = 1;
  int page = 1;

  final List<String> _ids = [
    'ETHImecKEsI',
    'kn3RWHQRXEM',
    'pUtlkUUt-FE',
    'mEjbDqxmMF0'
  ];

  void runvid() {
    _controller = YoutubePlayerController(
      initialVideoId: _ids[3],
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  @override
  void initState() {
    // print(1.sw);
    // print(1.sh);
    if (widget.materi == "Biografi Raden Noer Rahmat") {
      _controller = YoutubePlayerController(
        initialVideoId: _ids[0],
        flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
        ),
      )..addListener(listener);
      _videoMetaData = const YoutubeMetaData();
      _playerState = PlayerState.unknown;
    } else if (widget.materi ==
        "Bentuk Dakwah Akulturasi dan Peninggalan Secara Fisik") {
      _controller = YoutubePlayerController(
        initialVideoId: _ids[1],
        flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
        ),
      )..addListener(listener);
      _videoMetaData = const YoutubeMetaData();
      _playerState = PlayerState.unknown;

      // _controller2.pause();
    }
    super.initState();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    if (widget.materi == "Biografi Raden Noer Rahmat") {
      _controller.pause();
    }
    if (widget.materi ==
        "Bentuk Dakwah Akulturasi dan Peninggalan Secara Fisik") {
      if (page == 2 || page == 1) {
        _controller.pause();
      }
    }
    super.deactivate();
  }

  @override
  void dispose() {
    if (widget.materi == "Biografi Raden Noer Rahmat") {
      _controller.dispose();
    }
    if (widget.materi ==
        "Bentuk Dakwah Akulturasi dan Peninggalan Secara Fisik") {
      if (page == 2 || page == 1) {
        _controller.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
              child: Column(
            children: [
              widget.materi == "Biografi Raden Noer Rahmat"
                  ? YoutubePlayerBuilder(
                      onEnterFullScreen: () {
                        setState(() {
                          isFullScreen = true;
                        });
                      },
                      onExitFullScreen: () {
                        setState(() {
                          isFullScreen = false;
                        });
                        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
                        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                            overlays: [
                              SystemUiOverlay.top,
                              SystemUiOverlay.bottom
                            ]);
                        // SystemChrome.setPreferredOrientations(
                        //     [DeviceOrientation.portraitUp]);
                      },
                      player: YoutubePlayer(
                        controller: _controller,
                        width: 1.sw,
                        aspectRatio: (height / 120) / (width / 120),
                        showVideoProgressIndicator: true,
                        progressColors: ProgressBarColors(
                            bufferedColor: Colors.white,
                            backgroundColor: Colors.black,
                            handleColor: Color.fromRGBO(197, 133, 95, 1),
                            playedColor: Color.fromRGBO(197, 133, 95, 1)),
                        progressIndicatorColor: Color.fromRGBO(197, 133, 95, 1),
                      ),
                      builder: (context, player) {
                        return Column(
                          children: [
                            // some widgets
                            isFullScreen
                                ? 0.0.verticalSpace
                                : Container(
                                    width: 1.sw,
                                    height: 0.12.sh,
                                    color: Color.fromRGBO(197, 133, 95, 1),
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 0.025.sh),
                                      child: Row(
                                        children: [
                                          // Padding(
                                          //   padding: EdgeInsets.only(top: 0.05.sh, left: 0.1.sw),
                                          //   child:
                                          // ),
                                          0.08.sw.horizontalSpace,
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                              width: 0.12.sw,
                                              height: 0.1.sw,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Icon(
                                                Icons.arrow_back_ios_rounded,
                                                size: 20.sp,
                                                color: Color.fromRGBO(
                                                    197, 133, 95, 1),
                                              ),
                                            ),
                                          ),
                                          0.05.sw.horizontalSpace,
                                          Container(
                                            width: 0.7.sw,
                                            child: Text(
                                              widget.materi,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.sp,
                                                  // fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                            player,
                            isFullScreen
                                ? 0.0.verticalSpace
                                : 0.02.sh.verticalSpace,
                            isFullScreen
                                ? 0.0.verticalSpace
                                : Text(
                                    "Selanjutnya kita akan belajar tentang biografi Raden Noer Rahmat.",
                                    textAlign: TextAlign.center,
                                  )
                            //some other widgets
                          ],
                        );
                      })
                  : 0.0.verticalSpace,
              widget.materi ==
                      "Bentuk Dakwah Akulturasi dan Peninggalan Secara Fisik"
                  ? page == 1
                      ? YoutubePlayerBuilder(
                          onEnterFullScreen: () {
                            setState(() {
                              isFullScreen = true;
                            });
                          },
                          onExitFullScreen: () {
                            setState(() {
                              isFullScreen = false;
                            });
                            // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
                            SystemChrome.setEnabledSystemUIMode(
                                SystemUiMode.manual,
                                overlays: [
                                  SystemUiOverlay.top,
                                  SystemUiOverlay.bottom
                                ]);
                            // SystemChrome.setPreferredOrientations(
                            //     [DeviceOrientation.portraitUp]);
                          },
                          player: YoutubePlayer(
                            controller: _controller,
                            width: 1.sw,
                            aspectRatio: (height / 120) / (width / 120),
                            showVideoProgressIndicator: true,
                            progressColors: ProgressBarColors(
                                bufferedColor: Colors.white,
                                backgroundColor: Colors.black,
                                handleColor: Color.fromRGBO(197, 133, 95, 1),
                                playedColor: Color.fromRGBO(197, 133, 95, 1)),
                            progressIndicatorColor:
                                Color.fromRGBO(197, 133, 95, 1),
                          ),
                          builder: (context, player) {
                            return Column(
                              children: [
                                // some widgets
                                isFullScreen
                                    ? 0.0.verticalSpace
                                    : 0.12.sh.verticalSpace,
                                isFullScreen
                                    ? 0.0.verticalSpace
                                    : Padding(
                                        padding:
                                            EdgeInsets.only(bottom: 0.02.sh),
                                        child: Container(
                                          width: 0.9.sw,
                                          child: RichText(
                                              textAlign: TextAlign.justify,
                                              text:
                                                  TextSpan(children: <TextSpan>[
                                                TextSpan(
                                                    text:
                                                        "Sunan Sendang Duwur dalam dakwahnya memegang Prinsip dakwah ",
                                                    style: TextStyle(
                                                        color: Colors.black)),
                                                TextSpan(
                                                  text: "“Manut Ilining banyu”",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                                TextSpan(
                                                  text: " yang berarti ",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                TextSpan(
                                                    text:
                                                        "“membiarkan adat istiadat tetap hidup dalam masyarakat, tetapi diberi nilai-nilai keislaman”. Prinsip dakwah tersebut terlihat dalam bentuk-bentuk peninggalan dakwah secara fisik meliputi masjid, komplek makam, sumur, batik & kerajinan emas. Yang masih dapat dapat kita lihat bentuk peninggalannya sampai sekarang :",
                                                    style: TextStyle(
                                                        color: Colors.black)),
                                              ])),
                                        ),
                                      ),
                                isFullScreen
                                    ? 0.0.verticalSpace
                                    : Padding(
                                        padding: EdgeInsets.only(
                                            left: 0.05.sw, bottom: 0.01.sh),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text("1.Masjid")),
                                      ),
                                isFullScreen
                                    ? 0.0.verticalSpace
                                    : Padding(
                                        padding: EdgeInsets.only(
                                            left: 0.05.sw, bottom: 0.01.sh),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child:
                                                Text("Peristiwa Masjid Tiban")),
                                      ),
                                player,
                                isFullScreen
                                    ? 0.0.verticalSpace
                                    : 0.02.sh.verticalSpace,
                                isFullScreen
                                    ? 0.0.verticalSpace
                                    : Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 0.02.sh, left: 0.05.sw),
                                        child: Row(
                                          children: [
                                            Text("Pilih video : "),
                                            0.05.sw.horizontalSpace,
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _controller.load(_ids[1]);
                                                  vidselected = 1;
                                                });
                                              },
                                              child: Container(
                                                  width: 0.12.sw,
                                                  height: 0.1.sw,
                                                  decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                            blurRadius: 5.0,
                                                            color:
                                                                Colors.black12,
                                                            spreadRadius: 5.0,
                                                            offset:
                                                                Offset(0, 2))
                                                      ],
                                                      color: vidselected == 1
                                                          ? Color.fromRGBO(
                                                              197, 133, 95, 1)
                                                          : Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Center(
                                                      child: Text(
                                                    "1",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: vidselected == 1
                                                          ? Colors.white
                                                          : Color.fromRGBO(
                                                              197, 133, 95, 1),
                                                    ),
                                                  ))),
                                            ),
                                            0.05.sw.horizontalSpace,
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _controller.load(_ids[2]);
                                                  vidselected = 2;
                                                });
                                              },
                                              child: Container(
                                                  width: 0.12.sw,
                                                  height: 0.1.sw,
                                                  decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                            blurRadius: 5.0,
                                                            color:
                                                                Colors.black12,
                                                            spreadRadius: 5.0,
                                                            offset:
                                                                Offset(0, 2))
                                                      ],
                                                      color: vidselected == 2
                                                          ? Color.fromRGBO(
                                                              197, 133, 95, 1)
                                                          : Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Center(
                                                      child: Text(
                                                    "2",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: vidselected == 2
                                                          ? Colors.white
                                                          : Color.fromRGBO(
                                                              197, 133, 95, 1),
                                                    ),
                                                  ))),
                                            )
                                          ],
                                        ),
                                      ),
                                isFullScreen
                                    ? 0.0.verticalSpace
                                    : Padding(
                                        padding:
                                            EdgeInsets.only(bottom: 0.02.sh),
                                        // ignore: sized_box_for_whitespace
                                        child: Container(
                                          width: 0.9.sw,
                                          child: RichText(
                                              textAlign: TextAlign.justify,
                                              // ignore: prefer_const_literals_to_create_immutables
                                              text:
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  TextSpan(children: <TextSpan>[
                                                TextSpan(
                                                    text:
                                                        "Masjid Sunan Sendang Duwur yang berada Di Bukit Amitunon di perkirakan di bangun pada abad ke-16. Berdasarkan ",
                                                    style: TextStyle(
                                                        color: Colors.black)),
                                                TextSpan(
                                                  text: "Candrasengkalan",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                                TextSpan(
                                                  text:
                                                      " yang terdapat di bagian atas serambi masjid yang berbunyi ",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                TextSpan(
                                                    text:
                                                        "“Gurhaning Saira Tirta Hayu” ",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontStyle:
                                                            FontStyle.italic)),
                                                TextSpan(
                                                  text:
                                                      "menunjukkan angka 1483 S sama dengan 1561 M, ",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                TextSpan(
                                                  text: "Candrasengkalan",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "ini juga terdapat pada masjid yang ada di mantingan yang berbunyi ",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "“Rupa Brahmana Warna Sari” ",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "menunjukkan angka 1481 S sama dengan 1559. Hal tersebut membuktikan Masjid Sunan Sendang Duwur secara angka tahun masih satu zaman dengan Masjid yang ada Di Mantingan Jepara.",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ])),
                                        ),
                                      ),
                                //some other widgets
                              ],
                            );
                          })
                      : page == 2
                          ? YoutubePlayerBuilder(
                              onEnterFullScreen: () {
                                setState(() {
                                  isFullScreen = true;
                                });
                              },
                              onExitFullScreen: () {
                                setState(() {
                                  isFullScreen = false;
                                });
                                // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
                                SystemChrome.setEnabledSystemUIMode(
                                    SystemUiMode.manual,
                                    overlays: [
                                      SystemUiOverlay.top,
                                      SystemUiOverlay.bottom
                                    ]);
                                // SystemChrome.setPreferredOrientations(
                                //     [DeviceOrientation.portraitUp]);
                              },
                              player: YoutubePlayer(
                                controller: _controller,
                                width: 1.sw,
                                aspectRatio: (height / 120) / (width / 120),
                                showVideoProgressIndicator: true,
                                progressColors: ProgressBarColors(
                                    bufferedColor: Colors.white,
                                    backgroundColor: Colors.black,
                                    handleColor:
                                        Color.fromRGBO(197, 133, 95, 1),
                                    playedColor:
                                        Color.fromRGBO(197, 133, 95, 1)),
                                progressIndicatorColor:
                                    Color.fromRGBO(197, 133, 95, 1),
                              ),
                              builder: (context, player) {
                                return Column(
                                  children: [
                                    // some widgets
                                    isFullScreen
                                        ? 0.0.verticalSpace
                                        : 0.12.sh.verticalSpace,
                                    isFullScreen
                                        ? 0.0.verticalSpace
                                        : Padding(
                                            padding: EdgeInsets.only(
                                                left: 0.05.sw, bottom: 0.01.sh),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text("2.Komplek Makam")),
                                          ),
                                    isFullScreen
                                        ? 0.0.verticalSpace
                                        : Padding(
                                            padding: EdgeInsets.only(
                                                left: 0.05.sw, bottom: 0.01.sh),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                    "Komplek Makam Sunan Sendang Duwur di bangun bersebelahan dengan Masjid Tiban Sunan Sendang Duwur.")),
                                          ),
                                    player,
                                    isFullScreen
                                        ? 0.0.verticalSpace
                                        : 0.02.sh.verticalSpace,
                                    isFullScreen
                                        ? 0.0.verticalSpace
                                        : Padding(
                                            padding: EdgeInsets.only(
                                                left: 0.05.sw, bottom: 0.01.sh),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text("3.Sumur")),
                                          ),
                                    isFullScreen
                                        ? 0.0.verticalSpace
                                        : Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 0.02.sh),
                                            // ignore: sized_box_for_whitespace
                                            child: Container(
                                              width: 0.9.sw,
                                              child: RichText(
                                                  textAlign: TextAlign.justify,
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  text:
                                                      // ignore: prefer_const_literals_to_create_immutables
                                                      TextSpan(
                                                          children: <TextSpan>[
                                                        TextSpan(
                                                            text:
                                                                "Tidak hanya Masjid Sendang Duwur saja dalam proses dakwahnya Sunan Sendang Duwur juga membangun beberapa sumur atau sumber mata air. Sumur atau sumber air ini antara lain Sumur Giling, Sumur Paidon, Sumur leng songo, dan Sumur Jangkang. Sumur Giling merupakan bangunan yang di bangun hampir bersamaan dengan berdirinya Masjid Sunan Sendang Duwur.",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black)),
                                                      ])),
                                            ),
                                          ),
                                    isFullScreen
                                        ? 0.0.verticalSpace
                                        : Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    style: BorderStyle.solid,
                                                    width: 4)),
                                            child: Image.asset(
                                              fit: BoxFit.fill,
                                              "assets/foto_soal_no_9.jpg",
                                              width: 0.7.sw,
                                              height: 0.25.sh,
                                            ),
                                          ),
                                    isFullScreen
                                        ? 0.0.verticalSpace
                                        : 0.01.sh.verticalSpace,
                                    isFullScreen
                                        ? 0.0.verticalSpace
                                        : Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 0.02.sh),
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 0.8.sw,
                                                  child: Text(
                                                    "Gambar 5. Sumur Giling (Dokumetasi Syihabuddin 2022)",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w800),
                                                  ),
                                                ),
                                                0.02.sh.verticalSpace,
                                                Container(
                                                  width: 0.85.sw,
                                                  child: Text(
                                                    "       Sumur ini di bangun karena pada waktu itu belum ada sumber mata air disekitar masjid yang digunakan untuk masyarakat bersuci. Sehingga dalam keresahan tersebut beliau berdoa dan meminta petunjuk kepada Allah SWT. Pada malam harinya beliau di berikan mimpi akan ada kepulan asap di dekat Masjid Sendang dan bangunlah sebuah sumur. Setelah terbangun dari mimpi dan melihat ada kepulan asap di sebelah timur masjid setelah beliau dekati ternyata ada keris yang menancap setelah keris itu di cabut ternyata keluar sebuah sumber air yang dinamakan Sumur Giling. di gunakan untuk mengisi gentong untuk wudlu dan minum para jamaah masjid",
                                                    textAlign:
                                                        TextAlign.justify,
                                                  ),
                                                ),
                                                0.02.sh.verticalSpace,
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 0.02.sh),
                                                  child: Container(
                                                    width: 0.85.sw,
                                                    child: Text(
                                                      "       Terdapat pula Sumur Paidon yang ada di tengah Kompleks Makam Sunan Sendang Duwur. Bentuknya kecil tetapi meiliki mata air yang keluar dari celah-celah batu kapur yang tidak pernah surut.",
                                                      textAlign:
                                                          TextAlign.justify,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          style:
                                                              BorderStyle.solid,
                                                          width: 4)),
                                                  child: Image.asset(
                                                    fit: BoxFit.fill,
                                                    "assets/s_3.jpg",
                                                    width: 0.7.sw,
                                                    height: 0.25.sh,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 0.02.sh),
                                                  child: Container(
                                                    width: 0.8.sw,
                                                    child: Text(
                                                      "Gambar 6. Sumur Paidon (Dokumetasi Syihabuddin 2022)",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    ),
                                                  ),
                                                ),
                                                0.02.sh.verticalSpace,
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 0.02.sh),
                                                  child: Container(
                                                    width: 0.85.sw,
                                                    child: Text(
                                                      "Ada juga Sumur Leng songo yang terdapat di perbatasan Sendang Agung dan Sendang Duwur yang merupakan saksi pertemuan antara Sunan Sendang Duwur dan Sunan Drajat.",
                                                      textAlign:
                                                          TextAlign.justify,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          style:
                                                              BorderStyle.solid,
                                                          width: 4)),
                                                  child: Image.asset(
                                                    fit: BoxFit.fill,
                                                    "assets/s_2.jpg",
                                                    width: 0.7.sw,
                                                    height: 0.25.sh,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 0.02.sh),
                                                  child: Container(
                                                    width: 0.8.sw,
                                                    child: Text(
                                                      "Gambar 7. Sumur Leng Songo (Dokumetasi Syihabuddin 2022)",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    ),
                                                  ),
                                                ),
                                                0.02.sh.verticalSpace,
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 0.02.sh),
                                                  child: Container(
                                                    width: 0.85.sw,
                                                    child: Text(
                                                      "Terdapat juga Sumur Jangkang merupakan sumur yang ada di perbatasan Sendang Agung dan Sendang Duwur.",
                                                      textAlign:
                                                          TextAlign.justify,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          style:
                                                              BorderStyle.solid,
                                                          width: 4)),
                                                  child: Image.asset(
                                                    fit: BoxFit.fill,
                                                    "assets/s_4.jpg",
                                                    width: 0.7.sw,
                                                    height: 0.25.sh,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 0.02.sh),
                                                  child: Container(
                                                    width: 0.8.sw,
                                                    child: Text(
                                                      "Gambar 8. Sumur Jangkang (Dokumetasi Syihabuddin 2022",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    ),
                                                  ),
                                                ),
                                                0.02.sh.verticalSpace,
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 0.02.sh),
                                                  child: Container(
                                                    width: 0.85.sw,
                                                    child: Text(
                                                      "Memiliki ciri khas ketika diminum oleh hewan ternak maka hewan ternak tersebut tidak mempan untuk di sembelih. Bahkan gayung airnya yang terbuat dari anyaman daun lontar tidak bisa dirobek. Atas dasar itulah Sunan Sendang Duwur menutup sumur tersebut dan menanaminya dengan pohon jangkang demi kemaslakhatan masyarakat.",
                                                      textAlign:
                                                          TextAlign.justify,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 0.02.sh),
                                                  child: Container(
                                                    width: 0.85.sw,
                                                    child: Text(
                                                      "         Dalam dakwahnya Sunan Sendang Duwur tidak hanya membangun infrastrukur dakwah saja tetapi beliau juga menyematkan nilai-nilai keterampulan kepada Masyarakat Desa Sendang Duwur dan Sendang Agung dalam bentuk batik tulis dan kerajinan emas yang masih dapat kita lihat sampai sekarang.",
                                                      textAlign:
                                                          TextAlign.justify,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                    //some other widgets
                                  ],
                                );
                              })
                          : page == 3
                              ? Column(
                                  children: [
                                    isFullScreen
                                        ? 0.0.verticalSpace
                                        : 0.12.sh.verticalSpace,
                                    isFullScreen
                                        ? 0.0.verticalSpace
                                        : Padding(
                                            padding: EdgeInsets.only(
                                                left: 0.05.sw, bottom: 0.01.sh),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                    "4.Batik & Kerajinan Emas")),
                                          ),
                                    isFullScreen
                                        ? 0.0.verticalSpace
                                        : Padding(
                                            padding: EdgeInsets.only(
                                                left: 0.05.sw, bottom: 0.01.sh),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                  width: 0.9.sw,
                                                  child: Text(
                                                    "Di sisi lain Sunan Sendang Duwur juga memberikan bekal-bekal keterampilan. Keterampilan membatik yang di berinama Batik Sendang Duwur. Batik Sendang Duwur yang memiliki ciri khas berwarna merah dan hitam yang memiliki ragam motif ikan bandeng dan lele. Tentunya dalam motif fauna yang ada telah distilir dengan motif flora agar tidak menyalahi nilai-nilai islami.",
                                                    textAlign:
                                                        TextAlign.justify,
                                                  ),
                                                )),
                                          ),
                                    isFullScreen
                                        ? 0.0.verticalSpace
                                        : 0.02.sh.verticalSpace,
                                    isFullScreen
                                        ? 0.0.verticalSpace
                                        : Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    style: BorderStyle.solid,
                                                    width: 4)),
                                            child: Image.asset(
                                              fit: BoxFit.fill,
                                              "assets/k_2.jpg",
                                              width: 0.7.sw,
                                              height: 0.25.sh,
                                            ),
                                          ),
                                    isFullScreen
                                        ? 0.0.verticalSpace
                                        : 0.01.sh.verticalSpace,
                                    isFullScreen
                                        ? 0.0.verticalSpace
                                        : Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 0.02.sh),
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 0.8.sw,
                                                  child: Text(
                                                    "Gambar 9. Batik tulis Sunan Sendang Duwur (Dokumetasi Syihabuddin 2022)",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w800),
                                                  ),
                                                ),
                                                0.02.sh.verticalSpace,
                                                Container(
                                                  width: 0.85.sw,
                                                  child: Text(
                                                    "       Terdapat juga bekal keterampilan membuat kerajinan dari emas. kerajinan ini memang sudah ada sejak dahulu dan terus dilestarikan oleh masyarakat secara turun-temurun. Bekal keterampilan ini sudah menjadi bagian dari peninggalan Sunan Sendang Duwur dalam bentuk fisik dan menjadi mata pencarian Penduduk Sendang Duwur pada masa kini.",
                                                    textAlign:
                                                        TextAlign.justify,
                                                  ),
                                                ),
                                                0.02.sh.verticalSpace,
                                                Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          style:
                                                              BorderStyle.solid,
                                                          width: 4)),
                                                  child: Image.asset(
                                                    fit: BoxFit.fill,
                                                    "assets/k_1.jpg",
                                                    width: 0.7.sw,
                                                    height: 0.25.sh,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 0.02.sh),
                                                  child: Container(
                                                    width: 0.8.sw,
                                                    child: Text(
                                                      "Gambar 10. Pengerajin emas (Dokumetasi Syihabuddin 2022)",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    ),
                                                  ),
                                                ),
                                                0.02.sh.verticalSpace,
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 0.02.sh),
                                                  child: Container(
                                                    width: 0.85.sw,
                                                    child: Text(
                                                      "Tidak hanya dakwah melalui pembangunan fisik saja tetapi beliau juga berdakwah dan meninggalkan konsepsi ajaran yang juga masih dipegang erat oleh masyarakat Sendang Duwur.",
                                                      textAlign:
                                                          TextAlign.justify,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                  ],
                                )
                              : 0.0.verticalSpace
                  : 0.0.verticalSpace,
              widget.materi ==
                      "Bentuk Dakwah Akulturasi dan Peninggalan Secara Fisik"
                  ? isFullScreen
                      ? 0.0.verticalSpace
                      : Padding(
                          padding:
                              EdgeInsets.only(bottom: 0.02.sh, left: 0.05.sw),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  if (page == 2) {
                                    setState(() {
                                      page = 1;
                                      _controller.load(_ids[1]);
                                      vidselected = 1;
                                    });
                                  } else if (page == 3) {
                                    setState(() {
                                      page = 2;
                                      runvid();
                                    });
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                            "kamu telah berada di halaman yang terakhir !",
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white);
                                  }
                                },
                                child: Container(
                                  width: 0.15.sw,
                                  height: 0.15.sw,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(197, 133, 95, 1),
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
                                      Icons.arrow_back_ios_rounded,
                                      size: 20.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              0.55.sw.horizontalSpace,
                              InkWell(
                                onTap: () {
                                  if (page == 1) {
                                    setState(() {
                                      page = 2;
                                      _controller.load(_ids[3]);
                                    });
                                  } else if (page == 2) {
                                    setState(() {
                                      _controller.pause();
                                      _controller.dispose();
                                      page = 3;
                                    });
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                            "kamu telah berada di halaman yang terakhir !",
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white);
                                  }
                                },
                                child: Container(
                                  width: 0.15.sw,
                                  height: 0.15.sw,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(197, 133, 95, 1),
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
                        )
                  : 0.0.verticalSpace,
              widget.materi ==
                      "Bentuk Dakwah Akulturasi dan Peninggalan Secara Ajaran"
                  ? Padding(
                      padding: EdgeInsets.only(
                          top: 0.12.sh, bottom: 0.02.sh, left: 0.05.sw),
                      child: Column(
                        children: [
                          Container(
                            width: 0.9.sw,
                            child: RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          "         Mayoritas masyarakat Wilayah Sendang Duwur dan Sendang Agung yang semakin banyak memeluk ajaran islam membuat Sunan Sendang Duwur menerapkan prinsip-prinsip keagamaan dalam proses pembelajarannya agar nilai-nilai islami dengan mudah diterima oleh masyarakat yang masih awam tentang ajaran islam. Prinsip tersebut antara lain:",
                                      style: TextStyle(color: Colors.black)),
                                ])),
                          ),
                          0.02.sh.verticalSpace,
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    style: BorderStyle.solid, width: 4)),
                            child: Image.asset(
                              fit: BoxFit.cover,
                              "assets/g11.png",
                              width: 0.65.sw,
                              height: 0.21.sh,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0.02.sh),
                            child: Container(
                              width: 0.8.sw,
                              child: Text(
                                "Gambar 11. Prinsip ajaran Sunan Sendang Duwur (Dokumetasi Syihabuddin 2022)",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                          0.02.sh.verticalSpace,
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    style: BorderStyle.solid, width: 4)),
                            child: Image.asset(
                              fit: BoxFit.cover,
                              "assets/g12.png",
                              width: 0.65.sw,
                              height: 0.21.sh,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0.02.sh),
                            child: Container(
                              width: 0.8.sw,
                              child: Text(
                                "Gambar 12. Prinsip ajaran Sunan Sendang Duwur (Dokumetasi Syihabuddin 2022)",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                          0.02.sh.verticalSpace,
                          Container(
                            width: 0.9.sw,
                            child: RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          "-	Sunan Sendang Duwur dalam dakwahnya juga kerap menjumpai pemberian dupa di tempat-tempat yang dianggap memiliki kekuatan magis. Pemberian sesaji di sudut-sudut rumah atau di jalan-jalan lingkungan Sendang Duwur dan Sendang Agung. Masyarakat meyakini sebagai cara untuk menolak bala atau mengharap berkah baik dari Tuhan Yang Maha Esa.",
                                      style: TextStyle(color: Colors.black)),
                                ])),
                          ),
                          0.02.sh.verticalSpace,
                          Container(
                            width: 0.9.sw,
                            child: RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          "-	Dalam praktinya Sunan Sendang Sendang tidak serta-merta melarang prilaku masyarakat tersebut tetapi beliau memberikan arahan untuk mengadakan selamatan atau sedekah yang dibagikan kepada sanak famili mereka. Secara esensi dengan melakukan selamatan dan membagikan hantaran ke sanak famili sebagai bentuk sedekah yang akan menjadi amal baik untuk mereka.",
                                      style: TextStyle(color: Colors.black)),
                                ])),
                          ),
                          0.02.sh.verticalSpace,
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    style: BorderStyle.solid, width: 4)),
                            child: Image.asset(
                              fit: BoxFit.cover,
                              "assets/g13.png",
                              width: 0.65.sw,
                              height: 0.21.sh,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0.02.sh),
                            child: Container(
                              width: 0.8.sw,
                              child: Text(
                                "Gambar 13. Prinsip ajaran Sunan Sendang Duwur (Dokumetasi Syihabuddin 2022)",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                          0.02.sh.verticalSpace,
                          Container(
                            width: 0.9.sw,
                            child: RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          "- Pesan Sunan Sendang Duwur ialah berjalanlah dengan benar sesuai dengan syariat islam dan bersedekahlah kepada orang-orang di sekitar ketika mendapatkan nikmat.",
                                      style: TextStyle(color: Colors.black)),
                                ])),
                          ),
                          0.02.sh.verticalSpace,
                          Container(
                            width: 0.9.sw,
                            child: RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          "       Dalam praktinya Ajaran dakwah beliau telah melebur membentuk kebudayaan yang tercermin dalam pelaksanaan Haul Sunan Sendang duwur yang diiringi oleh musik Terbang Jidor dengan Lantunan Shalawat.",
                                      style: TextStyle(color: Colors.black)),
                                ])),
                          ),
                          0.02.sh.verticalSpace,
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    style: BorderStyle.solid, width: 4)),
                            child: Image.asset(
                              fit: BoxFit.cover,
                              "assets/psa_2.jpg",
                              width: 0.65.sw,
                              height: 0.21.sh,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0.02.sh),
                            child: Container(
                              width: 0.8.sw,
                              child: Text(
                                "Gambar 14. Perkusi Terbang Jidor (Dokumetasi Syihabuddin 2022)",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                          0.02.sh.verticalSpace,
                          Container(
                            width: 0.9.sw,
                            child: RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          "Serta ditutup dengan prosesi makan bersama dengan menu khusus yang benama Sego Langgi.",
                                      style: TextStyle(color: Colors.black)),
                                ])),
                          ),
                          0.02.sh.verticalSpace,
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    style: BorderStyle.solid, width: 4)),
                            child: Image.asset(
                              fit: BoxFit.cover,
                              "assets/foto_soal_no_19.jpg",
                              width: 0.65.sw,
                              height: 0.21.sh,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0.02.sh),
                            child: Container(
                              width: 0.8.sw,
                              child: Text(
                                "Gambar 15. Tradisi Sego Langgi (Dokumetasi Syihabuddin 2022)",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                          0.02.sh.verticalSpace,
                          Container(
                            width: 0.9.sw,
                            child: RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          "       Sego Langgi ialah menu khusus yang ada diperayaan Haul Sunan Sendang Duwur. Terdiri dari nasi yang dikepal-kepal dan memiliki lauk berupa potongan sayuran-sayuran hijau yang diberi sambal kelapa. Secara esensi Sego Langgi sebagai bentuk pengingat perjuangan Sunan Sendang Duwur dalam melakukan dakwah.",
                                      style: TextStyle(color: Colors.black)),
                                ])),
                          ),
                          0.02.sh.verticalSpace,
                          Container(
                            width: 0.9.sw,
                            child: RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          "       Pengingat atas peranan Sunan Sendang Duwur dalam proses islamisasi wilayah Sendang Duwur dan Sendang Agung kini setiap tahun diperingati dengan acara yang bernama Haul Akbar Sunan Sendang Duwur. Dilakukan pada komplek masjid yang didatangi oleh masyarakat sekitar dan luar kota. Menjadikan tradisi yang dilakukan secara turun-temurun disetiap tahun.",
                                      style: TextStyle(color: Colors.black)),
                                ])),
                          ),
                          0.02.sh.verticalSpace,
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    style: BorderStyle.solid, width: 4)),
                            child: Image.asset(
                              fit: BoxFit.cover,
                              "assets/psa_3.jpg",
                              width: 0.65.sw,
                              height: 0.21.sh,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0.02.sh),
                            child: Container(
                              width: 0.8.sw,
                              child: Text(
                                "Gambar 16. Haul Akbar Sunan Sendang Duwur (Dokumetasi Syihabuddin 2022)",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                          0.02.sh.verticalSpace,
                          Container(
                            width: 0.9.sw,
                            child: RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          "Selanjutnya peserta didik diharuskan mengejakan soal-soal yang telah ada dimenu evaluasi.",
                                      style: TextStyle(color: Colors.black)),
                                ])),
                          ),
                        ],
                      ),
                    )
                  : 0.0.verticalSpace,
              widget.materi == "Latar Belakang Proses Islamisasi"
                  ? Padding(
                      padding: EdgeInsets.only(
                          top: 0.12.sh, bottom: 0.02.sh, left: 0.05.sw),
                      child: Column(
                        children: [
                          Container(
                            width: 0.9.sw,
                            child: RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          "         Sejak abad ke-15 hingga abad ke-17 pesisir laut utara jawa timur memiliki peran yang masih sangat dominan sebagai sebuah perairan yang aktif dilewati oleh kapal-kapal asing ",
                                      style: TextStyle(color: Colors.black)),
                                  TextSpan(
                                      text: "(Jung).",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontStyle: FontStyle.italic)),
                                ])),
                          ),
                          0.02.sh.verticalSpace,
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    style: BorderStyle.solid, width: 4)),
                            child: Image.asset(
                              fit: BoxFit.cover,
                              "assets/peta_soal_no_4.jpg",
                              width: 0.65.sw,
                              height: 0.21.sh,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0.02.sh),
                            child: Container(
                              width: 0.8.sw,
                              child: Text(
                                "Gambar 1. Peta Jalur Besar Perdagangan Laut Nusantara (Sumber: Sedyawati, E. 1997: 70)",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                          0.02.sh.verticalSpace,
                          Container(
                            width: 0.9.sw,
                            child: RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          "Kapal-kapal ini biasanya hanya bersandar untuk transit ataupun menetap dalam waktu yang relatif lama untuk mempersiapkan cadangan perbekalan dan bahan yang akan di bawa dalam rute pelayaran selanjutnya atau sekedar menunggu cuaca membaik untuk melanjukan pelayaran. Pada zaman itu teknologi pelayaran yang digunakan masih menitik beratkan kepada kondisi alam. Sehingga dalam rutinitasnya pelabuhan di pesisir utara jawa ini selalu ramai dengan hiruk-pikuk mobilitas manusia dari berbagai wilayah asing yang saling berinteraksi.",
                                      style: TextStyle(color: Colors.black)),
                                ])),
                          ),
                          0.02.sh.verticalSpace,
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    style: BorderStyle.solid, width: 4)),
                            child: Image.asset(
                              fit: BoxFit.fill,
                              "assets/g2.png",
                              width: 0.65.sw,
                              height: 0.3.sh,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0.02.sh),
                            child: Container(
                              width: 0.8.sw,
                              child: Text(
                                "Gambar 2. Keunggulan Pesisir Laut Utara Jawa Timur (Dokumetasi Syihabuddin 2022)",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                          0.02.sh.verticalSpace,
                          Container(
                            width: 0.9.sw,
                            child: RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          "       Proses islamisasi di wilayah Pesisir Utara Jawa Timur tidak terlepas dari peranan para ulama yang di kenal dengan Walisongo. Walisongo ialah para ulama pilihan yang berjumlah sembilan yang memiliki bekal ilmu agama islam yang sangat baik dan memiliki karamah.",
                                      style: TextStyle(color: Colors.black)),
                                ])),
                          ),
                          0.02.sh.verticalSpace,
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    style: BorderStyle.solid, width: 4)),
                            child: Image.asset(
                              fit: BoxFit.fill,
                              "assets/g3.png",
                              width: 0.65.sw,
                              height: 0.3.sh,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0.02.sh),
                            child: Container(
                              width: 0.8.sw,
                              child: Text(
                                "Gambar 3. Peran Walisongo (Dokumetasi Syihabuddin 2022)",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                          0.02.sh.verticalSpace,
                          Container(
                            width: 0.9.sw,
                            child: RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          "Para sunan dalam proses islamisasi beliau selalu berdakwah dengan kebijaksanaan, menyesuaikan diri dengan pola pikir masyarakat sekitar serta kebiasaan yang berlaku di setiap wilayah dakwah sehingga dapat mengakulturasikan antara nilai-nilai islam dan budaya setempat.",
                                      style: TextStyle(color: Colors.black)),
                                ])),
                          ),
                          0.02.sh.verticalSpace,
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    style: BorderStyle.solid, width: 4)),
                            child: Image.asset(
                              fit: BoxFit.fill,
                              "assets/m_0_3.png",
                              width: 0.65.sw,
                              height: 0.3.sh,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0.02.sh),
                            child: Container(
                              width: 0.8.sw,
                              child: Text(
                                "Gambar 4. Strategi Dakwah (Dokumetasi Syihabuddin 2022)",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                          0.02.sh.verticalSpace,
                          Container(
                            width: 0.9.sw,
                            child: RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          "Hal tersebut yang membuat proses islamisasi yang dilakukan oleh para sunan ini lebih mudah diterima oleh masyarakat yang mayoritas masih menganut ajaran Hindu.",
                                      style: TextStyle(color: Colors.black)),
                                ])),
                          ),
                          0.02.sh.verticalSpace,
                          Container(
                            width: 0.9.sw,
                            child: RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          "       Peran aktif Walisongo dalam proses menyebarkan islam di tanah jawa tentunya tidak hanya dilakukan oleh sembilan sunan. Ternyata masih banyak para alim-ulama yang juga ikut menyebarkan islam di setiap wilayah. Salah satunya ialah Raden Noer Rahmat, merupakan alim-ulama yang satu zaman dengan Sunan Drajat dan wilayah dakwah beliau berdekatan dengan Sunan Drajat.",
                                      style: TextStyle(color: Colors.black)),
                                ])),
                          ),
                          0.02.sh.verticalSpace,
                          Container(
                            width: 0.9.sw,
                            child: RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          "       Raden Noer Rahmat atau Sunan Sendang Duwur dalam berdakwah juga melebur dengan pola pikir dan kebudayaan masyarakat yang mayoritas beragama Hindu. Sehingga banyak orang yang akhirnya menerima ajaran yang beliau syiarkan. Sunan Sendang Duwur juga membangun fasilitas keagamaan seperti masjid dan kompleks makam. Memiliki ciri khas yang mencontohkan kebudayaan masa transisi dari Hindu menuju Islam yang bukti situsnya masih bisa dikunjungi dan dijadikan pengingat pembelajaran sejarah sampai sekarang.",
                                      style: TextStyle(color: Colors.black)),
                                ])),
                          ),
                        ],
                      ),
                    )
                  : 0.0.verticalSpace
            ],
          )),
          widget.materi == "Biografi Raden Noer Rahmat"
              ? 0.0.verticalSpace
              : isFullScreen
                  ? 0.0.verticalSpace
                  : Container(
                      width: 1.sw,
                      height: 0.12.sh,
                      color: Color.fromRGBO(197, 133, 95, 1),
                      child: Padding(
                        padding: EdgeInsets.only(top: 0.025.sh),
                        child: Row(
                          children: [
                            0.08.sw.horizontalSpace,
                            InkWell(
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
                            0.05.sw.horizontalSpace,
                            Container(
                              width: 0.7.sw,
                              child: Text(
                                widget.materi,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    // fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
        ],
      ),
    );
  }
}
