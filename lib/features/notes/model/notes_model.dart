// To parse this JSON data, do
//
//     final notesModel = notesModelFromMap(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

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
        timestamp: json["timestamp"] != null
            ? (json["timestamp"] as Timestamp)
                .toDate() // Convert Timestamp to DateTime
            : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "userId": userId,
        "title": title,
        "content": content,
        "timestamp": timestamp != null ? Timestamp.fromDate(timestamp!) : null,
      };
}
