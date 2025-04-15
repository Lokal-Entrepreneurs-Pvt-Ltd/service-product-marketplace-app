// resume_work_history.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'ResumeEducation.dart';
import 'resumeDataModel.dart';


class ResumeWorkHistory extends StatefulWidget {
  final ResumeData resumeData;

  const ResumeWorkHistory({
    Key? key,
    required this.resumeData,
  }) : super(key: key);

  @override
  State<ResumeWorkHistory> createState() => _ResumeWorkHistoryState();
}

class _ResumeWorkHistoryState extends State<ResumeWorkHistory> {
  late List<WorkExperience> _experiences;

  @override
  void initState() {
    super.initState();
    // Use work experiences from resumeData or initialize with empty list
    _experiences = widget.resumeData.work;
  }

  void _addExperience() {
    // Navigate to the add experience screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddExperienceScreen(
          onSave: (experience) {
            setState(() {
              _experiences.add(experience);
              // Update the resume data
              widget.resumeData.work = _experiences;
            });
          },
        ),
      ),
    );
  }

  void _continueToEducation() {
    // Save work experience data and navigate to education screen
    widget.resumeData.work = _experiences;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResumeEducation(resumeData: widget.resumeData),
      ),
    );
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
              '2 of 4',
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
                'Work history',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // List of existing work experiences
              Expanded(
                child: _experiences.isEmpty
                    ? Center(
                  child: Text(
                    'Add your work experience',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                )
                    : ListView.builder(
                  itemCount: _experiences.length,
                  itemBuilder: (context, index) {
                    final experience = _experiences[index];
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
                                  experience.employer,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  experience.displayDate,
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
                              // Edit experience
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddExperienceScreen(
                                    experienceToEdit: experience,
                                    onSave: (updatedExperience) {
                                      setState(() {
                                        _experiences[index] = updatedExperience;
                                        widget.resumeData.work = _experiences;
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

              // Add Experience button
              GestureDetector(
                onTap: _addExperience,
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
                      'Add Experience',
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
                  onPressed: _continueToEducation,
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
}

// Screen to add or edit a work experience
class AddExperienceScreen extends StatefulWidget {
  final Function(WorkExperience) onSave;
  final WorkExperience? experienceToEdit;

  const AddExperienceScreen({
    Key? key,
    required this.onSave,
    this.experienceToEdit,
  }) : super(key: key);

  @override
  State<AddExperienceScreen> createState() => _AddExperienceScreenState();
}

class _AddExperienceScreenState extends State<AddExperienceScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text editing controllers
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _employerController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  // Date values for picker
  DateTime? _startDatePicker;
  DateTime? _endDatePicker;

  @override
  void initState() {
    super.initState();

    // If editing an existing experience, populate the fields
    if (widget.experienceToEdit != null) {
      final exp = widget.experienceToEdit!;
      _jobTitleController.text = exp.jobTitle;
      _employerController.text = exp.employer;
      _cityController.text = exp.city;

      try {
        // Parse the ISO dates for the date picker
        _startDatePicker = DateTime.parse(exp.startDate);
        _endDatePicker = DateTime.parse(exp.endDate);

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
    _jobTitleController.dispose();
    _employerController.dispose();
    _cityController.dispose();
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

  void _saveExperience() {
    if (_formKey.currentState!.validate() && _startDatePicker != null && _endDatePicker != null) {
      final experience = WorkExperience(
        jobTitle: _jobTitleController.text,
        employer: _employerController.text,
        city: _cityController.text,
        startDate: _startDatePicker!.toIso8601String().split('T')[0], // Format: "YYYY-MM-DD"
        endDate: _endDatePicker!.toIso8601String().split('T')[0],     // Format: "YYYY-MM-DD"
      );

      widget.onSave(experience);
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
          'Add Experience',
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
                // Job title field
                _buildInputField(
                  label: 'Job title',
                  controller: _jobTitleController,
                  hint: 'Enter your job title',
                ),
                const SizedBox(height: 16),

                // Employer field
                _buildInputField(
                  label: 'Employer',
                  controller: _employerController,
                  hint: 'Enter company name',
                ),
                const SizedBox(height: 16),

                // City field
                _buildInputField(
                  label: 'City',
                  controller: _cityController,
                  hint: 'Enter city',
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
                    onPressed: _saveExperience,
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