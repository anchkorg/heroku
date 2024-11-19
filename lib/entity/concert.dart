import 'dart:convert';
import 'dart:typed_data';

import 'person.dart';

class Concert implements Person {
  @override
  String? name;

  @override
  String? message;

  String? location;

  String? date;

  String? time;

  @override
  String? photo;

  Uint8List? photoFile;

  Concert(
      {this.name,
      this.message,
      this.photo,
      this.photoFile,
      this.location,
      this.date,
      this.time});

  Concert copyWith({
    String? name,
    String? message,
    String? photo,
    Uint8List? photoFile,
    String? location,
    String? date,
    String? time,
  }) {
    return Concert(
      name: name ?? this.name,
      message: message ?? this.message,
      photo: photo ?? this.photo,
      photoFile: photoFile ?? this.photoFile,
      location: location ?? this.location,
      date: date ?? this.date,
      time: time ?? this.time,
    );
  }

  factory Concert.fromMap(Map<String, dynamic> map) {
    return Concert(
      name: map['name'],
      message: map['message'],
      photo: map['photo'],
      location: map['location'],
      date: map['date'],
      time: map['time'],
    );
  }

  factory Concert.fromJson(String source) =>
      Concert.fromMap(json.decode(source));

  @override
  String toJson() {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toMap() {
    throw UnimplementedError();
  }
}
