// resume_data_model.dart

class Education {
  final String year;
  final String qualification;
  final String school;
  final String status;

  Education({
    required this.year,
    required this.qualification,
    required this.school,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'qualification': qualification,
      'school': school,
      'status': status,
    };
  }

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      year: json['year'] ?? '',
      qualification: json['qualification'] ?? '',
      school: json['school'] ?? '',
      status: json['status'] ?? '',
    );
  }
}

class ResumeData {
  String name;
  String fatherName;
  String phone;
  String address;
  List<Education> education;
  List<String> skills;
  List<String> workPreference;
  List<String> documentsAvailable;
  String declaration;

  ResumeData({
    this.name = '',
    this.fatherName = '',
    this.phone = '',
    this.address = '',
    List<Education>? education,
    List<String>? skills,
    List<String>? workPreference,
    List<String>? documentsAvailable,
    this.declaration = '',
  })  : education = education ?? [],
        skills = skills ?? [],
        workPreference = workPreference ?? [],
        documentsAvailable = documentsAvailable ?? [];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'fatherName': fatherName,
      'phone': phone,
      'address': address,
      'education': education.map((e) => e.toJson()).toList(),
      'skills': skills,
      'workPreference': workPreference,
      'documentsAvailable': documentsAvailable,
      'declaration': declaration,
    };
  }

  factory ResumeData.fromJson(Map<String, dynamic> json) {
    return ResumeData(
      name: json['name'] ?? '',
      fatherName: json['fatherName'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      education: (json['education'] as List<dynamic>? ?? [])
          .map((e) => Education.fromJson(e))
          .toList(),
      skills: List<String>.from(json['skills'] ?? []),
      workPreference: List<String>.from(json['workPreference'] ?? []),
      documentsAvailable: List<String>.from(json['documentsAvailable'] ?? []),
      declaration: json['declaration'] ?? '',
    );
  }

  String getFinalJson() {
    final jsonMap = toJson();
    return jsonMap.toString();
  }
}
