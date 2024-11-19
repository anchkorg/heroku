import 'dart:convert';

/*
                "name": nameController.text.toString(),
                "phone": phoneController.text.toString(),
                "email": emailController.text.toString(),
                "gender": genderController.text.toString(),
                "church": churchController.text.toString(),
                "yearInHIM": yearInHIMController.text.toString(),
                "yearInBaptist": yearInBaptistController.text.toString(),
                "churchService": churchServiceController.text.toString(),
                "yearInChurchChoir":
                    yearInChurchChoirController.text.toString(),
                "otherChoir": otherChoirController.text.toString(),
                "yearInOtherChoir": yearInOtherChoirController.text.toString(),
                "part": partController.text.toString(),
                "musicTalent": musicTalentController.text.toString(),
                "otherTalent": otherTalentController.text.toString(),
*/
class ApplicationInfo {
  String? name;

  String? phone;

  String? email;

  String? gender;

  String? church;

  String? yearInHIM;

  String? yearInBaptist;

  String? churchService;

  String? yearInChurchChoir;

  String? otherChoir;

  String? yearInOtherChoir;

  String? part;

  String? musicTalent;

  String? otherTalent;

  ApplicationInfo({
    this.name,
    this.phone,
    this.email,
    this.gender,
    this.church,
    this.yearInHIM,
    this.yearInBaptist,
    this.churchService,
    this.yearInChurchChoir,
    this.otherChoir,
    this.yearInOtherChoir,
    this.part,
    this.musicTalent,
    this.otherTalent,
  });

  ApplicationInfo copyWith({
    String? name,
    String? phone,
    String? email,
    String? gender,
    String? church,
    String? yearInHIM,
    String? yearInBaptist,
    String? churchService,
    String? yearInChurchChoir,
    String? otherChoir,
    String? yearInOtherChoir,
    String? part,
    String? musicTalent,
    String? otherTalent,
  }) {
    return ApplicationInfo(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      church: church ?? this.church,
      yearInHIM: yearInHIM ?? this.yearInHIM,
      yearInBaptist: yearInBaptist ?? this.yearInBaptist,
      churchService: churchService ?? this.churchService,
      yearInChurchChoir: yearInChurchChoir ?? this.yearInChurchChoir,
      otherChoir: otherChoir ?? this.otherChoir,
      yearInOtherChoir: yearInOtherChoir ?? this.yearInOtherChoir,
      part: part ?? this.part,
      musicTalent: musicTalent ?? this.musicTalent,
      otherTalent: otherTalent ?? this.otherTalent,
    );
  }

  factory ApplicationInfo.fromMap(Map<dynamic, dynamic> map) {
    return ApplicationInfo(
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
      gender: map['gender'],
      church: map['church'],
      yearInHIM: map['yearInHIM'],
      yearInBaptist: map['yearInBaptist'],
      churchService: map['churchService'],
      yearInChurchChoir: map['yearInChurchChoir'],
      otherChoir: map['otherChoir'],
      yearInOtherChoir: map['yearInOtherChoir'],
      part: map['part'],
      musicTalent: map['musicTalent'],
      otherTalent: map['otherTalent'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'gender': gender,
      'church': church,
      'yearInHIM': yearInHIM,
      'yearInBaptist': yearInBaptist,
      'churchService': churchService,
      'yearInChurchChoir': yearInChurchChoir,
      'otherChoir': otherChoir,
      'yearInOtherChoir': yearInOtherChoir,
      'part': part,
      'musicTalent': musicTalent,
      'otherTalent': otherTalent,
    };
  }

  factory ApplicationInfo.fromJson(String source) =>
      ApplicationInfo.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ApplicationInfo(name: $name, phone: $phone, email: $email, gender: $gender, church: $church, yearInHIM: $yearInHIM, yearInBaptist: $yearInBaptist, churchService: $churchService, yearInChurchChoir: $yearInChurchChoir, otherChoir: $otherChoir, yearInOtherChoir: $yearInOtherChoir, part: $part, musicTalent: $musicTalent, otherTalent: $otherTalent)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApplicationInfo &&
        other.name == name &&
        other.phone == phone &&
        other.email == email &&
        other.gender == gender &&
        other.church == church &&
        other.yearInHIM == yearInHIM &&
        other.yearInBaptist == yearInBaptist &&
        other.churchService == churchService &&
        other.yearInChurchChoir == yearInChurchChoir &&
        other.otherChoir == otherChoir &&
        other.yearInOtherChoir == yearInOtherChoir &&
        other.part == part &&
        other.musicTalent == musicTalent &&
        other.otherTalent == otherTalent;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        gender.hashCode ^
        church.hashCode ^
        yearInHIM.hashCode ^
        yearInBaptist.hashCode ^
        churchService.hashCode ^
        yearInChurchChoir.hashCode ^
        otherChoir.hashCode ^
        yearInOtherChoir.hashCode ^
        part.hashCode ^
        musicTalent.hashCode ^
        otherTalent.hashCode;
  }
}
