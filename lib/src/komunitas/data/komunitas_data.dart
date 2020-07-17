class KomunitasData{
  int id=0;
  String name= '';
  String email= '';
  String phone= '';
  String address= '';
  String password= '';
  String chief= '';
  String foto= '';
  String description= '';
  String dropout= '';
  String cronic= '';
  String orphaned= '';
  String disability= '';
  String age= '';

  KomunitasData({
    this.id,
  this.name,
  this.email,
  this.phone,
  this.address,
  this.password,
  this.chief,
  this.foto,
  this.description,
  this.dropout,
  this.cronic,
  this.orphaned,
  this.disability,
  this.age,
});

  factory KomunitasData.fromJson(Map<String, dynamic> map){
    return KomunitasData(
      id: map['id'],
      name: map['name_community'],
      email: map['email_community'],
      phone: map['phone_community'],
      address: map['address_community'],
      password: map['password'],
      chief: map['name_chief'],
      foto: map['featured_image'],
      description: map['description'],
      dropout: map['dropout'],
      cronic: map['cronic_pain'],
      orphaned: map['orphaned'],
      disability: map['disability'],
      age: map['age'],
    );
  }
}

