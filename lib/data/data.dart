var baseurl = "https://syihabuddin.pythonanywhere.com/";

String Build = "1";
String Major = "0";
String Minor = "0";

class DataUser {
  String nama;
  String kelas;
  String absen;
  String username;
  DataUser(this.nama, this.kelas, this.absen, this.username);
}

class Datasiswa {
  String nama;
  String kelas;
  String absen;
  String nilai;
  String id;
  String username;
  Datasiswa(
      this.nama, this.kelas, this.absen, this.nilai, this.id, this.username);
}

final album_makam = [
  "km_1.jpg",
  "km_2.jpg",
  "km_3.jpg",
  "km_4.jpg",
  "foto_soal_no_17.jpg",
  "km_6.jpg",
  "km_7.jpg",
  "km_8.jpg",
  "km_9.jpg",
  "km_10.jpg",
  "km_11.jpg",
  "km_12.jpg",
  "km_13.jpg",
  "km_14.jpg",
  "km_15.jpg",
  "km_16.jpg",
  "km_17.jpg",
  "km_18.jpg",
];

final album_masjid = [
  "am_1.jpg",
  "foto_soal_no_14.jpg",
  "am_3.jpg",
  "am_4.jpg",
  "am_5.jpg",
  "am_6.jpg",
  "am_7.jpg",
  "am_8.jpg",
  "am_9.jpg"
];

final album_sumur = ["foto_soal_no_9.jpg", "s_2.jpg", "s_3.jpg", "s_4.jpg"];

final album_keterampilan = ["k_2.jpg", "k_1.jpg"];
final album_psa = ["psa_1.jpg", "psa_2.jpg", "psa_3.jpg"];

final deskripsi_masjid = [
  "Bangunan masjid lama dengan bangunan masjid baru",
  "Bangunan masjid lama dengan bangunan masjid baru",
  "Denah Masjid Sunan Sendang Duwur",
  "Gentong penampung air wudlu dan minum",
  "Beduk dan kentongan",
  "Pintu masuk sebelah timur",
  "Bagian loteng, tangga dan tiang soko guru",
  "Bagian haram, mimbar dan mihrab",
  "Mimbar lama peninggalan Sunan Sendang Duwur"
];

final deskripsi_makam = [
  "Denah makam Sunan Sendang Duwur",
  "Gapura bentar pertama",
  "Gapura paduraksa bersayap pertama",
  "Gapura paduraksa bersayap pertama",
  "Ragam hias burung merak pada gapura paduraksa bersayap pertama",
  "Ragam hias singa pada gapura paduraksa bersayap pertama",
  "Ragam hias tumbuhan lontar dan wilus pada gapura paduraksa bersayap pertama",
  "Gapura paduraksa bersayap kedua",
  "Ragam hias kepala naga pada gapura paduraksa bersayap kedua",
  "Ragam hias kepala rusa bertubuh ular pada gapura paduraksa bersayap kedua",
  "Ragam hias bangunan bersayap pada gapura paduraksa bersayap kedua",
  "Ragam hias kepala kala pada gapura paduraksa bersayap kedua",
  "Motif tumpal pada langit-langit lorong gapura paduraksa bersayap Kedua",
  "Cungkup luar dan cungkup utama pada halaman kedua dan ketiga",
  "Makam dengan aksen nisan Surya Majapahit",
  "Anak tangga menuju cungkup utama pada halaman ketiga",
  "Gebyok pada cungkup utama",
  "Ragam arsitektur flora pada pondasi gebyok"
];

final deskripsi_sumur = [
  "Bangunan Sumur Giling",
  "Bangunan Sumur Leng Songo",
  "Bangunan Sumur Paidon",
  "Bangunan Sumur Jangkang"
];

final deskripsi_keterampilan = [
  "Batik tulis khas Sendang Duwur",
  "Pengerajin emas khas Sendang Duwur"
];

final deskripsi_psa = [
  "Tradisi Sego Langgi",
  "Tradisi Terbang Jidor",
  "Tradisi Haul Akbar Sunan Sendang Duwur"
];

final index_masjid = [0, 1, 2, 3, 4, 5, 6, 7, 8];
final index_makam = [
  0,
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17
];
final index_sumur = [0, 1, 2, 3];
final index_keterampilan = [0, 1];
final index_psa = [0, 1, 2];

List<DataUser> dataUser = <DataUser>[];
List<Datasiswa> listDataSiswa = <Datasiswa>[];
