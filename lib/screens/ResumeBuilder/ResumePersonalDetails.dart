// resume_personal_details.dart

import 'package:flutter/material.dart';
import 'package:lokal/screens/ResumeBuilder/ResumeEducation.dart';
import 'resumeDataModel.dart';

class ResumePersonalDetails extends StatefulWidget {
  final ResumeData resumeData;

  const ResumePersonalDetails({
    Key? key,
    required this.resumeData,
  }) : super(key: key);

  @override
  State<ResumePersonalDetails> createState() => _ResumePersonalDetailsState();
}

class _ResumePersonalDetailsState extends State<ResumePersonalDetails> {
  final _formKey = GlobalKey<FormState>();

  // Text editing controllers
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _fatherNameController;
  late final TextEditingController _addressController;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with existing data if available
    _nameController = TextEditingController(text: widget.resumeData.name);
    _phoneController = TextEditingController(text: widget.resumeData.phone);
    _fatherNameController =
        TextEditingController(text: widget.resumeData.fatherName);
    _addressController = TextEditingController(text: widget.resumeData.address);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _fatherNameController.dispose();
    _addressController.dispose();

    super.dispose();
  }

  void _continueToWorkHistory() {
    if (_formKey.currentState!.validate()) {
      // Update resume data with personal details
      widget.resumeData.name = _nameController.text;
      widget.resumeData.phone = _phoneController.text;
      widget.resumeData.fatherName = _fatherNameController.text;
      widget.resumeData.address = _addressController.text;

      print(widget.resumeData.name);
      // Navigate to work history page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              (ResumeEducation(resumeData: widget.resumeData)),
        ),
      );
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
              '1 of 4',
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
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Personal Details',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildInputField(
                    label: 'Full name',
                    controller: _nameController,
                    hint: 'Enter your full name (e.g., Ram Sagar)',
                  ),
                  const SizedBox(height: 16),
                  _buildInputField(
                    label: 'Father\'s Name',
                    controller: _fatherNameController,
                    hint: 'Enter your father\'s full name',
                  ),
                  const SizedBox(height: 16),
                  _buildInputField(
                    label: 'Phone',
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    hint: 'Enter your phone number',
                  ),
                  const SizedBox(height: 16),
                  _buildInputField(
                    label: 'Address',
                    controller: _addressController,
                    hint: 'Enter your full address',
                  ),
                  const SizedBox(height: 170),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _continueToWorkHistory,
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
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    required String hint,
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
                return 'Please enter your $label';
              }

              // Additional validation for email
              if (label == 'Email' && !value.contains('@')) {
                return 'Please enter a valid email address';
              }

              // Additional validation for phone
              if (label == 'Phone' && value.length < 10) {
                return 'Please enter a valid phone number';
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}
