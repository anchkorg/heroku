import 'dart:convert';
import 'dart:typed_data';

import 'division.dart';
import 'paragraph_model.dart';

class AnchkMission implements Division {
  @override
  String? name;

  @override
  final List<Paragraph>? message;

  @override
  String? photo;

  Uint8List? photoFile;

  AnchkMission({this.name, this.message, this.photo, this.photoFile});

  factory AnchkMission.fromMap(Map<String, dynamic> map) => AnchkMission(
        name: map['name'],
        message: List<Paragraph>.from(
            map["message"].map((x) => Paragraph.fromMap(x))),
        photo: map['photo'],
      );

  factory AnchkMission.fromJson(String source) =>
      AnchkMission.fromMap(json.decode(source));

  AnchkMission copyWith({
    String? name,
    List<Paragraph>? message,
    String? photo,
    Uint8List? photoFile,
  }) {
    return AnchkMission(
        name: name ?? this.name,
        message: message ?? this.message,
        photo: photo ?? this.photo,
        photoFile: photoFile ?? this.photoFile);
  }

  @override
  String toJson() {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toMap() {
    throw UnimplementedError();
  }
}
