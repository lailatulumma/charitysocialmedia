class TargetBantuan{
  int id;
  String nama = '';
  String deskripsi = '';
  String alamat = '';
  String foto = '';
  int usia;
  String disabilitas = '';
  String ekonomiRendah = '';
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
    this.disabilitas,
    this.ekonomiRendah,
    this.penyakitKronis,
    this.putusSekolah,
    this.yatimPiatu,
  });
  factory TargetBantuan.fromJson(Map<String, dynamic> map) {
    return TargetBantuan(
      id: map['id'],
      nama: map['name'],
      usia: map['age'],
      alamat: map['address'],
      ekonomiRendah: map['condition_economy'],
      putusSekolah: map['last_education'],
      penyakitKronis: map['history_disease'],
      deskripsi: map['description'],
      yatimPiatu: map['job'],
      foto: map['featured_image'],
    );
  }
  
}