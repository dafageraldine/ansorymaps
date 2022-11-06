var baseurl = "https://ansoryapi.herokuapp.com/";

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

List<DataUser> dataUser = <DataUser>[];
