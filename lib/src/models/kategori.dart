class Kategori{
  static const String KategoriYatim = 'yatim piatu';
  static const String KategoriPutusSekolah = 'putus sekolah';
  static const String KategoriSakit = 'penyakitkronis';
  static const String KategoriDisability = 'disabilitas';

  Map categories = {
    KategoriYatim: false,
    KategoriPutusSekolah: false,
    KategoriSakit: false,
    KategoriDisability: false,
  };

  save(){
    print('menyimpan value');
  }
}