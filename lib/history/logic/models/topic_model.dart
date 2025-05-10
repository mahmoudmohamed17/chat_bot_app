import 'package:equatable/equatable.dart';

class TopicModel extends Equatable {
  final String? id;
  final String? createdAt;
  final String? forChat;

  const TopicModel({this.id, this.createdAt, this.forChat});

  factory TopicModel.fromJson(Map<String, dynamic> json) => TopicModel(
    id: json['id'] as String?,
    createdAt: json['created_at'] as String?,
    forChat: json['for_chat'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'created_at': createdAt,
    'for_chat': forChat,
  };

  TopicModel copyWith({String? id, String? createdAt, String? forChat}) {
    return TopicModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      forChat: forChat ?? this.forChat,
    );
  }

  @override
  List<Object?> get props => [id, createdAt, forChat];
}
