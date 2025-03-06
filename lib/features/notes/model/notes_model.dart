// To parse this JSON data, do
//
//     final notesModel = notesModelFromMap(jsonString);

import 'dart:convert';

NotesModel notesModelFromMap(String str) =>
    NotesModel.fromMap(json.decode(str));

String notesModelToMap(NotesModel data) => json.encode(data.toMap());

class NotesModel {
  String? id;
  String? userId;
  String? title;
  String? content;
  DateTime? timestamp;

  NotesModel({
    this.id,
    this.userId,
    this.title,
    this.content,
    this.timestamp,
  });

  factory NotesModel.fromMap(Map<String, dynamic> json) => NotesModel(
        id: json["id"],
        userId: json["userId"],
        title: json["title"],
        content: json["content"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "userId": userId,
        "title": title,
        "content": content,
        "timestamp": timestamp,
      };
}
