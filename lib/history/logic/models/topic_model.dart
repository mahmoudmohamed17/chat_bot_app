import 'package:equatable/equatable.dart';

class TopicModel extends Equatable {
  final String? id;
  final String? createdAt;
  final String? forChat;
  final String? title;

  const TopicModel({this.id, this.createdAt, this.forChat, this.title});

  factory TopicModel.fromJson(Map<String, dynamic> json) => TopicModel(
    id: json['id'] as String?,
    createdAt: json['created_at'] as String?,
    forChat: json['for_chat'] as String?,
    title: json['title'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'created_at': createdAt,
    'for_chat': forChat,
    'title': title,
  };

  TopicModel copyWith({String? id, String? createdAt, String? forChat, String? title}) {
    return TopicModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      forChat: forChat ?? this.forChat,
      title: title ?? this.title,
    );
  }

  @override
  List<Object?> get props => [id, createdAt, forChat, title];
}
