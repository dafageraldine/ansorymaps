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

List<DataUser> dataUser = <DataUser>[];
List<Datasiswa> listDataSiswa = <Datasiswa>[];
