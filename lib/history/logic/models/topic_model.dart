import 'package:equatable/equatable.dart';

class TopicModel extends Equatable {
  final String? id;
  final String? createdAt;
  final String? forChat;
  final String? forUser;
  final String? title;

  const TopicModel({
    this.id,
    this.createdAt,
    this.forChat,
    this.forUser,
    this.title,
  });

  factory TopicModel.fromJson(Map<String, dynamic> json) => TopicModel(
    id: json['id'] as String?,
    createdAt: json['created_at'] as String?,
    forChat: json['for_chat'] as String?,
    forUser: json['for_user'] as String?,
    title: json['title'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'created_at': createdAt,
    'for_chat': forChat,
    'for_user': forUser,
    'title': title,
  };

  TopicModel copyWith({
    String? id,
    String? createdAt,
    String? forChat,
    String? forUser,
    String? title,
  }) {
    return TopicModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      forChat: forChat ?? this.forChat,
      forUser: forUser ?? this.forUser,
      title: title ?? this.title,
    );
  }

  @override
  List<Object?> get props => [id, createdAt, forChat, forUser, title];
}
