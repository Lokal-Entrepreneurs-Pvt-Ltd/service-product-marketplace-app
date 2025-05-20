import 'package:flutter/material.dart';
import 'package:lokal/screens/ResumeBuilder/resumeFinal.dart';
import 'resumeDataModel.dart';
import 'ResumeUploadAndPayment.dart';

class ResumeSkillsAndPreference extends StatefulWidget {
  final ResumeData resumeData;

  const ResumeSkillsAndPreference({Key? key, required this.resumeData})
      : super(key: key);

  @override
  State<ResumeSkillsAndPreference> createState() =>
      _ResumeSkillsAndPreferenceState();
}

class _ResumeSkillsAndPreferenceState extends State<ResumeSkillsAndPreference> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _skillsController = TextEditingController();

  final List<String> _workOptions = [
    'Part-time',
    'Full-time',
  ];
  final List<String> _documentOptions = ['Aadhar Card', 'PAN Card '];

  List<String> _selectedWorkPreferences = [];
  List<String> _selectedDocuments = [];
  bool _declarationChecked = false;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      if (_selectedWorkPreferences.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Please select at least one work preference.'),
            backgroundColor: Colors.red.shade700,
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }
      if (_selectedDocuments.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Please select at least one document.'),
            backgroundColor: Colors.red.shade700,
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }
      if (!_declarationChecked) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Please confirm the declaration.'),
            backgroundColor: Colors.red.shade700,
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      widget.resumeData.skills = _skillsController.text
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();
      widget.resumeData.workPreference = _selectedWorkPreferences;
      widget.resumeData.documentsAvailable = _selectedDocuments;
      widget.resumeData.declaration =
          'I hereby declare that all the information provided is true and correct to the best of my knowledge.';

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ResumeUploadAndPayment(resumeData: widget.resumeData),
      //   ),
      // );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResumeFinal(resumeData: widget.resumeData),
        ),
      );
    }
  }

  Widget _buildCheckboxList(
      String title, List<String> options, List<String> selectedList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Column(
          children: options.map((item) {
            return CheckboxListTile(
              value: selectedList.contains(item),
              onChanged: (val) {
                setState(() {
                  if (val == true) {
                    selectedList.add(item);
                  } else {
                    selectedList.remove(item);
                  }
                });
              },
              title: Text(item),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            );
          }).toList(),
        ),
      ],
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
                  fontSize: 18),
            ),
            Text(
              '3 of 4',
              style: TextStyle(color: Colors.grey, fontSize: 14),
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
                    'Skills (comma separated)',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      controller: _skillsController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'e.g. Node.js,C/C++',
                      ),
                      validator: (val) => val == null || val.isEmpty
                          ? 'Please enter skills'
                          : null,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildCheckboxList('Work Preference', _workOptions,
                      _selectedWorkPreferences),
                  const SizedBox(height: 24),
                  _buildCheckboxList('Documents Available', _documentOptions,
                      _selectedDocuments),
                  const SizedBox(height: 130),
                  CheckboxListTile(
                    value: _declarationChecked,
                    onChanged: (val) {
                      setState(() => _declarationChecked = val ?? false);
                    },
                    title: const Text(
                      'I hereby declare that all the information provided is true and correct to the best of my knowledge.',
                      style: TextStyle(fontSize: 14),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFD833),
                        foregroundColor: Colors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
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
}
