import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? userId;
  final String? createdAt;
  final String? fullName;
  final String? phoneNumber;
  final String? profilePicture;
  final String? dateOfBirth;
  final String? gender;

  const UserModel({
    this.userId,
    this.createdAt,
    this.fullName,
    this.phoneNumber,
    this.profilePicture,
    this.dateOfBirth,
    this.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userId: json['user_id'] as String?,
    createdAt: json['created_at'] as String?,
    fullName: json['full_name'] as String?,
    phoneNumber: json['phone_number'] as String?,
    profilePicture: json['profile_picture'] as String?,
    dateOfBirth: json['date_of_birth'] as String?,
    gender: json['gender'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'created_at': createdAt,
    'full_name': fullName,
    'phone_number': phoneNumber,
    'profile_picture': profilePicture,
    'date_of_birth': dateOfBirth,
    'gender': gender,
  };

  UserModel copyWith({
    String? userId,
    String? createdAt,
    String? fullName,
    String? phoneNumber,
    String? profilePicture,
    String? dateOfBirth,
    String? gender,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
    );
  }

  @override
  List<Object?> get props {
    return [
      userId,
      createdAt,
      fullName,
      phoneNumber,
      profilePicture,
      dateOfBirth,
      gender,
    ];
  }
}
