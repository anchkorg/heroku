import 'dart:convert';

class ProjectInfo {

  String? name;

  String? appwriteServer;

  ProjectInfo({ this.name, this.appwriteServer});

  factory ProjectInfo.fromMap(Map<String, dynamic> map) => ProjectInfo(
        name: map['name'],
        appwriteServer: map['appwriteServer'],
      );

  factory ProjectInfo.fromJson(String source) =>
      ProjectInfo.fromMap(json.decode(source));

  ProjectInfo copyWith({
    String? name,
    String? appwriteServer,
  }) {
    return ProjectInfo(
        name: name ?? this.name,
        appwriteServer: appwriteServer ?? this.appwriteServer);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'appwriteServer': appwriteServer,
    };
  }

  String toJson() => json.encode(toMap());
}
