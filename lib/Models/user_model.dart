
class UserModel {
  String? name;
  String? email;
  String? image;
  UserModel({
    required this.name,
    required this.email,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'image': image,
    };
  }

   
}
