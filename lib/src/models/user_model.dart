class UserModel{
  int id;
  String name='';
  String phone='';
  String avatar='';
  String address='';
  String city='';
  String email='';
  
  UserModel({
    this.id=0,
    this.name,
    this.phone,
    this.avatar,
    this.address,
    this.city,
    this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      avatar: map['avatar'],
      address: map['address'],
      city: map['city'],
      email: map['email']
    );
  }
}