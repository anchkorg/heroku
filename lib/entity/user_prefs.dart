import 'dart:convert';
import 'dart:typed_data';

import 'package:logger/logger.dart';

class UserPrefs {
//  final int? buildNumber;
//  final bool? introSeen;
//  final DateTime? lastLoggedIn;
//  final String? deviceId;

  final String? voicePart;
  final String? description;
  final String? chineseName;
  Uint8List? photoFile;

  final logger = Logger(
    printer: PrettyPrinter(
        methodCount: 1,
        lineLength: 50,
        errorMethodCount: 3,
        colors: true,
        printEmojis: true),
  );

  UserPrefs({
    //this.buildNumber = 0,
    //this.introSeen = false,
    //  this.lastLoggedIn,
    //this.deviceId = '',
    this.voicePart = "NA",
    this.chineseName = "NA",
    this.description = "NA",
    this.photoFile,
  });

  UserPrefs copyWith({
//    int buildNumber = 0,
//    bool introSeen = false,
//    required DateTime lastLoggedIn,
//    String deviceId = '',
    String? voicePart,
    String? chineseName,
    String? description,
    Uint8List? photoFile,
  }) {
    return UserPrefs(
      //buildNumber: buildNumber,
      //introSeen: introSeen,
      //  lastLoggedIn: lastLoggedIn,
      //deviceId: deviceId,
      voicePart: voicePart ?? this.voicePart,
      chineseName: chineseName ?? this.chineseName,
      description: description ?? this.description,
      photoFile: photoFile ?? this.photoFile,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      //'buildNumber': buildNumber,
      //'introSeen': introSeen,
      //  'lastLoggedIn': lastLoggedIn!.millisecondsSinceEpoch,
      //'deviceId': deviceId,
      'voicePart': voicePart,
      'chineseName': chineseName,
      'description': description,
    };
  }

  factory UserPrefs.fromMap(Map<String, dynamic> map) {
//    logger.i('map is ' + map.isEmpty.toString());
//    UserPrefs __userPrefs;
    return UserPrefs(
      //buildNumber: map['buildNumber'],
      //introSeen: map['introSeen'],
      //lastLoggedIn: DateTime.fromMillisecondsSinceEpoch(map['lastLoggedIn']),
      //deviceId: map['deviceId'],
      voicePart: map['voicePart'],
      chineseName: map['chineseName'],
      description: map['description'],
    );
//    return __userPrefs;
  }

  String toJson() => json.encode(toMap());

  factory UserPrefs.fromJson(String source) =>
      UserPrefs.fromMap(json.decode(source));

  @override
  String toString() {
    // return 'UserPrefs(buildNumber: $buildNumber, introSeen: $introSeen,  deviceId: $deviceId)';
    return 'UserPrefs(voicePart: $voicePart, chineseName: $chineseName, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserPrefs &&
        other.voicePart == voicePart &&
        other.chineseName == chineseName &&
        other.description == description;
    //&&
    //other.buildNumber == buildNumber &&
    //other.introSeen == introSeen &&
    //other.lastLoggedIn == lastLoggedIn &&
    //other.deviceId == deviceId;
  }

  @override
  int get hashCode {
    return voicePart.hashCode ^ chineseName.hashCode ^ description.hashCode;
    /**
        buildNumber.hashCode ^
        introSeen.hashCode ^
        // lastLoggedIn.hashCode ^
        deviceId.hashCode; */
  }
}
