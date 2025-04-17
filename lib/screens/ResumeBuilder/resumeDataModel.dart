// resume_data_model.dart

class Education {
  final String schoolName;
  final String percentage;
  final String subjects;
  final String startDate;
  final String endDate;

  Education({
    required this.schoolName,
    required this.percentage,
    required this.subjects,
    required this.startDate,
    required this.endDate,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'schoolName': schoolName,
      'percentage': percentage,
      'subjects': subjects,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  // Create from JSON
  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      schoolName: json['schoolName'] ?? '',
      percentage: json['percentage'] ?? '',
      subjects: json['subjects'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
    );
  }
}

class WorkExperience {
  final String jobTitle;
  final String employer;
  final String city;
  final String startDate;
  final String endDate;

  WorkExperience({
    required this.jobTitle,
    required this.employer,
    required this.city,
    required this.startDate,
    required this.endDate,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'jobTitle': jobTitle,
      'employer': employer,
      'city': city,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  // Create from JSON
  factory WorkExperience.fromJson(Map<String, dynamic> json) {
    return WorkExperience(
      jobTitle: json['jobTitle'] ?? '',
      employer: json['employer'] ?? '',
      city: json['city'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
    );
  }

  // Display date in UI format (Jan/22-Dec/23)
  String get displayDate {
    try {
      final startDateTime = DateTime.parse(startDate);
      final endDateTime = DateTime.parse(endDate);
      return '${_formatDate(startDateTime)}-${_formatDate(endDateTime)}';
    } catch (e) {
      return '$startDate-$endDate';
    }
  }

  String _formatDate(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final month = months[date.month - 1];
    final year = date.year.toString().substring(2); // Get last 2 digits
    return '$month/$year';
  }
}

class ResumeData {
  String name;
  String phone;
  String email;
  String city;
  List<Education> education;
  List<WorkExperience> work;

  ResumeData({
    this.name = '',
    this.phone = '',
    this.email = '',
    this.city = '',
    List<Education>? education,
    List<WorkExperience>? work,
  }) :
        education = education ?? [],
        work = work ?? [];

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'city': city,
      'education': education.map((e) => e.toJson()).toList(),
      'work': work.map((w) => w.toJson()).toList(),
    };
  }

  // Create from JSON
  factory ResumeData.fromJson(Map<String, dynamic> json) {
    final List<dynamic> eduList = json['education'] ?? [];
    final List<dynamic> workList = json['work'] ?? [];

    return ResumeData(
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      city: json['city'] ?? '',
      education: eduList.map((e) => Education.fromJson(e)).toList(),
      work: workList.map((w) => WorkExperience.fromJson(w)).toList(),
    );
  }

  // Get final JSON string
  String getFinalJson() {
    final jsonMap = toJson();
    return jsonMap.toString();
  }
}