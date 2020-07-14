import 'package:emphaty/src/models/user_model.dart';

class TargetBantuan extends UserModel{
  int id;
  String namauser = '';
  String nama = '';
  String deskripsi = '';
  String alamat = '';
  String foto = '';
  int usia;
  String penyakitKronis = '';
  String putusSekolah = '';
  String yatimPiatu= '';


  TargetBantuan({
    this.id = 0,
    this.nama,
    this.deskripsi,
    this.alamat,
    this.foto,
    this.usia,
    this.penyakitKronis,
    this.putusSekolah,
    this.yatimPiatu,
    this.namauser,
  });

  
  
  factory TargetBantuan.fromJson(Map<String, dynamic> map) {
    return TargetBantuan(
      id: map['id'],
      nama: map['name'],
      usia: map['age'],
      alamat: map['address'],
      putusSekolah: map['last_education'],
      penyakitKronis: map['history_disease'],
      deskripsi: map['description'],
      yatimPiatu: map['job'],
      foto: map['featured_image'],
      namauser: map['user']['name'],
    );
  }

  
}