import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DaftarPustaka extends StatefulWidget {
  const DaftarPustaka({Key? key}) : super(key: key);

  @override
  State<DaftarPustaka> createState() => _DaftarPustakaState();
}

class _DaftarPustakaState extends State<DaftarPustaka> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(children: [
            0.12.sh.verticalSpace,
            Padding(
              padding: EdgeInsets.only(left: 0.05.sw),
              child: Column(
                children: [
                  Container(
                    width: 0.85.sw,
                    child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Chambali, A. 1996. ",
                              style: TextStyle(color: Colors.black)),
                          TextSpan(
                            text: "“Perjuangan Wali Songo.",
                            style: TextStyle(
                                color: Colors.black,
                                fontStyle: FontStyle.italic),
                          ),
                          TextSpan(
                            text: " Surabaya: Kalindo Citra Selaras.",
                            style: TextStyle(color: Colors.black),
                          )
                        ])),
                  ),
                  10.verticalSpace,
                  Container(
                    width: 0.85.sw,
                    child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Mariana. 2020. ",
                              style: TextStyle(color: Colors.black)),
                          TextSpan(
                            text:
                                "Modul Pembelajaran Sejarah Indonesia Kelas X. Kementrian Pendidikan dan Kebudayaan",
                            style: TextStyle(color: Colors.black),
                          )
                        ])),
                  ),
                  10.verticalSpace,
                  Container(
                    width: 0.85.sw,
                    child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Mustopo, M. H. 2001 ",
                              style: TextStyle(color: Colors.black)),
                          TextSpan(
                            text:
                                "KEBUDAYAAN ISLAM DI JAWA TIMUR : Kajian Beberapa Unsur Budaya Masa Peralihan. Yogyakarta: Jendela Grafitka Yogyakarta.",
                            style: TextStyle(color: Colors.black),
                          )
                        ])),
                  ),
                  10.verticalSpace,
                  Container(
                    width: 0.85.sw,
                    child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Sari, N. 2018. ",
                              style: TextStyle(color: Colors.black)),
                          TextSpan(
                            text:
                                "Analisir Pras-Islam Pada Kompleks Makam Sendang Duwur Paciran Lamongan. Skripsi Tidak diterbitkan. Jurusan Sejarah Fakultas Ilmu Sosial Universitas Negeri Malang.",
                            style: TextStyle(color: Colors.black),
                          )
                        ])),
                  ),
                  10.verticalSpace,
                  Container(
                    width: 0.85.sw,
                    child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Sedyawati, E. 1997. ",
                              style: TextStyle(color: Colors.black)),
                          TextSpan(
                            text:
                                "TUBAN: Kota Pelabuhan di Jalan Sutra. Jakarta: CV. Putra Sejati Raya.",
                            style: TextStyle(color: Colors.black),
                          )
                        ])),
                  ),
                  10.verticalSpace,
                  Container(
                    width: 0.85.sw,
                    child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Siswayanti, N. 2015. ",
                              style: TextStyle(color: Colors.black)),
                          TextSpan(
                              text: "Jurnal Al-Turas ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic)),
                          TextSpan(
                            text:
                                "UIN Syarif Hidayatullah Jakarta Vol.21 No.1. 1-16. Dakwah Kultural Sunan Sendang Duwur.",
                            style: TextStyle(color: Colors.black),
                          )
                        ])),
                  ),
                  10.verticalSpace,
                  Container(
                    width: 0.85.sw,
                    child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Syafrizal, Achmad. 2015. ",
                              style: TextStyle(color: Colors.black)),
                          TextSpan(
                            text:
                                "Jurnal Islamuna IAIN Mandura Vol. 2. No.. 236-253. http://ejournal.iainmadura.ac.id/index.php/islamuna/article/view/664/6177. Sejarah Islam Nusantara.",
                            style: TextStyle(color: Colors.black),
                          )
                        ])),
                  ),
                  10.verticalSpace,
                  Container(
                    width: 0.85.sw,
                    child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Uka Tjandrasasmita. 1975. ",
                              style: TextStyle(color: Colors.black)),
                          TextSpan(
                              text: "Islamic Antiquities of Sendang Duwur ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic)),
                          TextSpan(
                            text:
                                "(terjemahan ke dalam Bahasa Inggris oleh Setyawati Suleiman). Jakarta: PT. Guruh Kemarau Sakti.",
                            style: TextStyle(color: Colors.black),
                          )
                        ])),
                  ),
                  10.verticalSpace,
                  Container(
                    width: 0.85.sw,
                    child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Wiandik & Kasdi. 2014. ",
                              style: TextStyle(color: Colors.black)),
                          TextSpan(
                              text: "Jurnal Pendidikan Sejarah, ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic)),
                          TextSpan(
                            text:
                                "2(3).75-89. Aspek-Aspek Akulturasi pada Kepurbakalaan Sendang Duwur di Paciran-Lamongan.",
                            style: TextStyle(color: Colors.black),
                          )
                        ])),
                  ),
                  10.verticalSpace,
                  Padding(
                    padding: EdgeInsets.only(left: 0.05.sw),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Sumber Wawancara : ")),
                  ),
                  5.verticalSpace,
                  Container(
                    width: 0.85.sw,
                    child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                            text:
                                "R. Ach. Fakhruddin (35) Sebagai juru kunci dan pemelihara Kompleks Masjid dan Makam Sunan Sendang Duwur. Wawancara di lakukan pada hari rabu 26 januari 2022.",
                            style: TextStyle(color: Colors.black),
                          )
                        ])),
                  ),
                  10.verticalSpace,
                  Container(
                    width: 0.85.sw,
                    child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                            text:
                                "Zamroni S. Pd. (32) Sebagai Ketua Kelompok Sadar Wisata Desa Sendan Duwur. Wawancara di lakukan pada hari senin 24 januari 2022. ",
                            style: TextStyle(color: Colors.black),
                          )
                        ])),
                  ),
                  15.verticalSpace,
                ],
              ),
            ),
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
                      "Daftar Pustaka",
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
