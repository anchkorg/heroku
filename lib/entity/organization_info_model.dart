class OrganizationInfo {
  final String name;
  final String telephone;
  final String url;
  final String email;
  final String facebook;
  final String whatsapp;
  final String whatsappGreeting;
  OrganizationInfo(this.name, this.telephone, this.url, this.email,
      this.facebook, this.whatsapp, this.whatsappGreeting);

  factory OrganizationInfo.fromMap(Map<String, dynamic> map) {
    String whatsapp = map['whatsapp'] ?? "";
    String whatsappGreeting = map['whatsappGreeting'] ?? "";
    return OrganizationInfo(
      map['name'],
      map['telephone'],
      map['url'],
      map['email'],
      map['facebook'],
      whatsapp,
      whatsappGreeting,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'telephone': telephone,
      'url': url,
      'email': email,
      'facebook': facebook,
      'whatsapp': whatsapp,
      'whatsappGreeting': whatsappGreeting,
    };
  }
}
