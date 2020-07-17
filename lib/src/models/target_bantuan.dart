class TargetBantuan{
  int id;
  String namauser = '';
  String nama = '';
  String deskripsi = '';
  String alamat = '';
  String foto = '';
  String usia;
  String dropout= '';
  String cronic= '';
  String orphaned= '';
  String disability= '';
  String job = '';


  TargetBantuan({
    this.id = 0,
    this.nama,
    this.deskripsi,
    this.alamat,
    this.foto,
    this.usia,
    this.dropout,
    this.cronic,
    this.orphaned,
    this.disability,
    this.namauser,
    this.job,
  });

  
  
  factory TargetBantuan.fromJson(Map<String, dynamic> map) {
    return TargetBantuan(
      id: map['id'],
      nama: map['name'],
      usia: map['age'],
      alamat: map['address'],
      deskripsi: map['description'],
      dropout: map['dropout'],
      cronic: map['cronic_pain'],
      orphaned: map['orphaned'],
      disability: map['disability'],
      foto: map['featured_image'],
      job: map['job'],
      namauser: map['user']['name'],
    );
  }

  
}