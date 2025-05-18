import 'package:flutter/material.dart';
import 'resumeDataModel.dart';
import 'ResumeUploadAndPayment.dart';

class ResumeFinal extends StatelessWidget {
  final ResumeData resumeData;

  const ResumeFinal({Key? key, required this.resumeData}) : super(key: key);

  Widget _section(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }

  Widget _info(String label, String value) {
    print("////////////////////_--------------");
    print(resumeData.name);
    print(resumeData.fatherName);
    print(resumeData.phone);
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text('$label: $value', style: const TextStyle(fontSize: 15)),
    );
  }

  Widget _list(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((e) => Text('• $e')).toList(),
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
          onPressed: () => Navigator.pop(context),
        ),
        title: const Column(
          children: [
            Text('Build your Resume',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
            Text('4 of 4', style: TextStyle(color: Colors.grey, fontSize: 14)),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _section('Personal Details', [
                        _info('Name', resumeData.name),
                        _info('Father\'s Name', resumeData.fatherName),
                        _info('Phone', resumeData.phone),
                        _info('Address', resumeData.address),
                      ]),
                      _section(
                          'Education',
                          resumeData.education
                              .map((e) => Text(
                                  '${e.year} - ${e.qualification} at ${e.school} (${e.status})'))
                              .toList()),
                      _section('Skills', [_list(resumeData.skills)]),
                      _section('Work Preference',
                          [_list(resumeData.workPreference)]),
                      _section('Documents Available',
                          [_list(resumeData.documentsAvailable)]),
                      _section('Declaration', [Text(resumeData.declaration)]),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ResumeUploadAndPayment(resumeData: resumeData),
                      ),
                    );
                  },
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
