class UserModel {
  String? id;
  String? age;
  String? gender;
  String? email;
  String? gstNumber;
  String? phone;
  String? imageUrl;

  UserModel({
    required this.id,
    required this.age,
    required this.gender,
    required this.email,
    required this.gstNumber,
    required this.phone,
    required this.imageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      age: json['age'],
      gender: json['gender'],
      email: json['email'],
      gstNumber: json['gstNumber'],
      phone: json['phone'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson(String? img) {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['age'] = age;
    data['gender'] = gender;
    data['email'] = email;
    data['gstNumber'] = gstNumber;
    data['phone'] = phone;
    data['imageUrl'] = img;
    return data;
  }
}
