class User {
  final String firstName;
  final String lastName;
  final bool available;
  final String phone;
  final String? image;

  User({required this.firstName, required this.lastName, required this.available, required this.phone, this.image});

  User.fromJson(dynamic json)
      : firstName = json['firstName'] as String,
        lastName = json['lastName'] as String,
        available = json['available'] as bool,
        phone = json['phone'] as String,
        image = json['image'] == null ? null : json['image'] as String;

  User copyWith({
    String? firstName,
    String? lastName,
    bool? available,
    String? phone,
    String? image,
  }) {
    return User(
      firstName: firstName ?? this.firstName,
      phone: phone ?? this.phone,
      available: available ?? this.available,
      lastName: lastName ?? this.lastName,
      image: image ?? this.image,
    );
  }

  @override
  String toString() {
    return 'User{firstName: $firstName, lastName: $lastName, available: $available, phone: $phone, image: $image}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          available == other.available &&
          phone == other.phone &&
          image == other.image;

  @override
  int get hashCode => firstName.hashCode ^ lastName.hashCode ^ available.hashCode ^ phone.hashCode ^ image.hashCode;
}
