class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  String? phoneNumber;

  UserModel({
    this.uid,
    this.email,
    this.phoneNumber,
    this.firstName,
    this.lastName,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    firstName = json['firstName'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['uid'] = uid;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;

    return data;
  }
}
