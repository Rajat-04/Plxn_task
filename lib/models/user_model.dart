class UserModel {
  String? id;
  int? age;
  String? gender;
  String? email;
  String? gstNumber;
  String? phone;
  String? imageUrl;

  UserModel({
    required this.age,
    required this.gender,
    required this.email,
    required this.gstNumber,
    required this.phone,
    required this.imageUrl,
  });
}
