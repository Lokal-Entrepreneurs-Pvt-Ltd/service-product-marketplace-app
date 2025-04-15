// resume_education.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lokal/screens/ResumeBuilder/ResumeUploadAndPayment.dart';
import 'resumeDataModel.dart';


class ResumeEducation extends StatefulWidget {
  final ResumeData resumeData;

  const ResumeEducation({
    Key? key,
    required this.resumeData,
  }) : super(key: key);

  @override
  State<ResumeEducation> createState() => _ResumeEducationState();
}

class _ResumeEducationState extends State<ResumeEducation> {
  late List<Education> _educations;

  @override
  void initState() {
    super.initState();
    // Use education from resumeData or initialize with empty list
    _educations = widget.resumeData.education;
  }

  void _addEducation() {
    // Navigate to the add education screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEducationScreen(
          onSave: (education) {
            setState(() {
              _educations.add(education);
              // Update the resume data
              widget.resumeData.education = _educations;
            });
          },
        ),
      ),
    );
  }

  void _continueToFinal() {
    // Save education data and navigate to final screen
    widget.resumeData.education = _educations;

    // Go to final screen or submit the resume
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResumeFinal(resumeData: widget.resumeData),
      ),
    );

    // Print JSON data to console for debugging
    print('Final Resume JSON:');
    print(widget.resumeData.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              'Build your Resume',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            Text(
              '3 of 4',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Education',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // List of existing educations
              Expanded(
                child: _educations.isEmpty
                    ? Center(
                  child: Text(
                    'Add your education',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                )
                    : ListView.builder(
                  itemCount: _educations.length,
                  itemBuilder: (context, index) {
                    final education = _educations[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${education.schoolName} - ${education.percentage}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _formatDateDisplay(education.startDate, education.endDate),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit_outlined),
                            onPressed: () {
                              // Edit education
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddEducationScreen(
                                    educationToEdit: education,
                                    onSave: (updatedEducation) {
                                      setState(() {
                                        _educations[index] = updatedEducation;
                                        widget.resumeData.education = _educations;
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Add Education button
              GestureDetector(
                onTap: _addEducation,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFFFD833),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'Add Study Experience',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Continue button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _continueToFinal,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD833),
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDateDisplay(String startDate, String endDate) {
    try {
      final start = DateTime.parse(startDate);
      final end = DateTime.parse(endDate);
      return '${DateFormat('MMM/yy').format(start)}-${DateFormat('MMM/yy').format(end)}';
    } catch (e) {
      return '$startDate-$endDate';
    }
  }
}

// Screen to add or edit education
class AddEducationScreen extends StatefulWidget {
  final Function(Education) onSave;
  final Education? educationToEdit;

  const AddEducationScreen({
    Key? key,
    required this.onSave,
    this.educationToEdit,
  }) : super(key: key);

  @override
  State<AddEducationScreen> createState() => _AddEducationScreenState();
}

class _AddEducationScreenState extends State<AddEducationScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text editing controllers
  final TextEditingController _schoolNameController = TextEditingController();
  final TextEditingController _percentageController = TextEditingController();
  final TextEditingController _subjectsController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  // Date values for picker
  DateTime? _startDatePicker;
  DateTime? _endDatePicker;

  @override
  void initState() {
    super.initState();

    // If editing an existing education, populate the fields
    if (widget.educationToEdit != null) {
      final edu = widget.educationToEdit!;
      _schoolNameController.text = edu.schoolName;
      _percentageController.text = edu.percentage;
      _subjectsController.text = edu.subjects;

      try {
        // Parse the ISO dates for the date picker
        _startDatePicker = DateTime.parse(edu.startDate);
        _endDatePicker = DateTime.parse(edu.endDate);

        // Format dates for display
        _startDateController.text = DateFormat('MMM/yy').format(_startDatePicker!);
        _endDateController.text = DateFormat('MMM/yy').format(_endDatePicker!);
      } catch (e) {
        // Handle parsing errors
        print('Error parsing dates: $e');
      }
    }
  }

  @override
  void dispose() {
    _schoolNameController.dispose();
    _percentageController.dispose();
    _subjectsController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDatePicker ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _startDatePicker) {
      setState(() {
        _startDatePicker = picked;
        // Format the date for display
        _startDateController.text = DateFormat('MMM/yy').format(picked);
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDatePicker ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)), // Allow future end dates
    );

    if (picked != null && picked != _endDatePicker) {
      setState(() {
        _endDatePicker = picked;
        // Format the date for display
        _endDateController.text = DateFormat('MMM/yy').format(picked);
      });
    }
  }

  void _saveEducation() {
    if (_formKey.currentState!.validate() && _startDatePicker != null && _endDatePicker != null) {
      final education = Education(
        schoolName: _schoolNameController.text,
        percentage: _percentageController.text,
        subjects: _subjectsController.text,
        startDate: _startDatePicker!.toIso8601String().split('T')[0], // Format: "YYYY-MM-DD"
        endDate: _endDatePicker!.toIso8601String().split('T')[0],     // Format: "YYYY-MM-DD"
      );

      widget.onSave(education);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Add Education',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // School name field
                _buildInputField(
                  label: 'School Name',
                  controller: _schoolNameController,
                  hint: 'Enter school or institution name',
                ),
                const SizedBox(height: 16),

                // Percentage field
                _buildInputField(
                  label: 'High School Percentage',
                  controller: _percentageController,
                  hint: 'Enter percentage (e.g., 87%)',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),

                // Subjects field
                _buildInputField(
                  label: 'Subjects',
                  controller: _subjectsController,
                  hint: 'Enter subjects (e.g., PCM)',
                ),
                const SizedBox(height: 16),

                // Start date field
                GestureDetector(
                  onTap: () => _selectStartDate(context),
                  child: _buildInputField(
                    label: 'Start Date',
                    controller: _startDateController,
                    hint: 'Select start date',
                    enabled: false,
                  ),
                ),
                const SizedBox(height: 16),

                // End date field
                GestureDetector(
                  onTap: () => _selectEndDate(context),
                  child: _buildInputField(
                    label: 'End Date',
                    controller: _endDateController,
                    hint: 'Select end date',
                    enabled: false,
                  ),
                ),

                const Spacer(),

                // Save button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _saveEducation,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFD833),
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    bool enabled = true,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            enabled: enabled,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              hintText: hint,
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $label';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

// Final screen for resume review and submission
class ResumeFinal extends StatelessWidget {
  final ResumeData resumeData;

  const ResumeFinal({Key? key, required this.resumeData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              'Build your Resume',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            Text(
              '4 of 4',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Resume Preview',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // Resume preview section
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Personal Details Section
                      _buildSectionTitle('Personal Details'),
                      _buildInfoItem('Name', resumeData.name),
                      _buildInfoItem('Phone', resumeData.phone),
                      _buildInfoItem('Email', resumeData.email),
                      _buildInfoItem('City', resumeData.city),

                      const SizedBox(height: 24),

                      // Work Experience Section
                      _buildSectionTitle('Work Experience'),
                      ...resumeData.work.map((exp) => _buildWorkItem(exp)),

                      const SizedBox(height: 24),

                      // Education Section
                      _buildSectionTitle('Education'),
                      ...resumeData.education.map((edu) => _buildEducationItem(edu)),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Submit Resume button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => _submitResume(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD833),
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Submit Resume',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkItem(WorkExperience exp) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            exp.jobTitle,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            exp.employer,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${exp.city} • ${exp.displayDate}',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationItem(Education edu) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            edu.schoolName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Percentage: ${edu.percentage} • Subjects: ${edu.subjects}',
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _formatDateDisplay(edu.startDate, edu.endDate),
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateDisplay(String startDate, String endDate) {
    try {
      final start = DateTime.parse(startDate);
      final end = DateTime.parse(endDate);
      return '${DateFormat('MMM/yy').format(start)}-${DateFormat('MMM/yy').format(end)}';
    } catch (e) {
      return '$startDate-$endDate';
    }
  }

  void _submitResume(BuildContext context) {
    // Convert ResumeData to JSON
   // final jsonData = resumeData.toJson();
    // print('Submitting Resume:');
    // print(jsonData);
    //
    // widget.resumeData.education = _educations;

    // Navigate to final screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResumeUploadAndPayment(
            resumeData: resumeData),
      ),
    );

    // // Here you would make an API call to submit the data
    // // For now, just show a dialog
    // showDialog(
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     title: const Text('Resume Submitted'),
    //     content: const Text('Your resume has been successfully submitted.'),
    //     actions: [
    //       TextButton(
    //         onPressed: () {
    //           Navigator.of(context).pop();
    //           // Navigate back to the main screen
    //           Navigator.of(context).popUntil((route) => route.isFirst);
    //         },
    //         child: const Text('OK'),
    //       ),
    //     ],
    //   ),
    // );
  }
}