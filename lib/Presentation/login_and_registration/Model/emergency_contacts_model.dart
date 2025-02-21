class EmergencyContact {
  String name;
  String relation;
  String mobile;

  EmergencyContact({
    required this.name,
    required this.relation,
    required this.mobile,
  });

  // Factory method to create an instance from JSON
  factory EmergencyContact.fromJson(Map<String, dynamic> json) {
    return EmergencyContact(
      name: json['name'] as String,
      relation: json['relation'] as String,
      mobile: json['mobile'] as String,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'relation': relation,
      'mobile': mobile,
    };
  }
}
