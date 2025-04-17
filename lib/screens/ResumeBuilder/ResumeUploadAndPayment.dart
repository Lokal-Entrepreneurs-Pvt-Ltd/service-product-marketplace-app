
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'dart:typed_data';
import '../../utils/payments/PaymentService.dart';
import 'resumeDataModel.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// Updated imports for the new implementation

import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfwebcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


enum SubmissionState {
  loading,
  success,
  error,
}

class ResumeUploadAndPayment extends StatefulWidget {
  final ResumeData resumeData;

  const ResumeUploadAndPayment({Key? key, required this.resumeData}) : super(key: key);

  @override
  State<ResumeUploadAndPayment> createState() => _ResumeUploadAndPaymentState();
}

class _ResumeUploadAndPaymentState extends State<ResumeUploadAndPayment>  with WidgetsBindingObserver{
  SubmissionState _state = SubmissionState.loading;
  String? _pdfUrl;
  String? _errorMessage;
  int? _resumeId;

  // Timer to handle API timeouts
  Timer? _timeoutTimer;

  // Initialize Cashfree Payment Gateway Service
  var cfPaymentGatewayService = CFPaymentGatewayService();
  String? _currentOrderId;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // App has come back to foreground, check if we need to verify payment
      if (_currentOrderId != null) {
        print("App resumed with pending order: $_currentOrderId");
        // Manual verification since we might have missed the callback
        _verifyPayment(_currentOrderId!);
        _currentOrderId = null; // Clear it after verification
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    PaymentService().setup();

    PaymentService().onPaymentSuccess = (orderId) {
      if (!mounted) return;
      _verifyPayment(orderId);
    };

    PaymentService().onPaymentFailure = (error, orderId) {
      if (!mounted) return;
      _showErrorDialogWithRetry(
          'Payment Failed',
          'Error: ${error.getMessage()}',
          _initiatePayment
      );
    };

    _submitResume();
    _setupTimeout();
  }


  void _setupTimeout() {
    // Clear any existing timer
    _timeoutTimer?.cancel();

    // Set a timeout for 30 seconds (adjust as needed)
    _timeoutTimer = Timer(const Duration(seconds: 30), () {
      // If we're still in loading state after the timeout
      if (_state == SubmissionState.loading && mounted) {
        setState(() {
          _state = SubmissionState.error;
          _errorMessage = "Request timed out. Please try again.";
        });
      }
    });
  }

  @override
  void dispose() {
    // Unregister from lifecycle events
    WidgetsBinding.instance.removeObserver(this);

    // Existing dispose code
    _timeoutTimer?.cancel();
    super.dispose();
  }

  bool _isLoading = false;

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
          'Resume Builder',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SafeArea(child: _buildContent()),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.1),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFFFD833), // Yellow
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (_state) {
      case SubmissionState.loading:
        return _buildLoadingScreen();
      case SubmissionState.success:
        return _buildSuccessScreen();
      case SubmissionState.error:
        return _buildErrorScreen();
    }
  }

  Widget _buildLoadingScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  strokeWidth: 8,
                  color: Colors.amberAccent,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade300),
                  backgroundColor: Colors.green.shade100,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Saving your details',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'We have more than 100 Jobs matching your resume.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSuccessScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.green.shade400,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 48,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Congratulations',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          const Text(
            'We have built your Resume',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                // Resume Preview button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: OutlinedButton(
                    onPressed: () {
                      // Open the generated PDF preview
                      _openPdfPreview();
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFFFD833)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Preview your Resume',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Pay to Download button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle payment and download
                      _initiatePayment();
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
                      'Pay Rs 10 to Download',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Error message
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.red.shade700),
                    const SizedBox(width: 8),
                    Text(
                      'Failed to generate resume',
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                if (_errorMessage != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red.shade700),
                  ),
                ],
              ],
            ),
          ),

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
                  _buildInfoItem('Name', widget.resumeData.name),
                  _buildInfoItem('Phone', widget.resumeData.phone),
                  _buildInfoItem('Email', widget.resumeData.email),
                  _buildInfoItem('City', widget.resumeData.city),

                  const SizedBox(height: 24),

                  // Work Experience Section
                  _buildSectionTitle('Work Experience'),
                  ...widget.resumeData.work.map((exp) => _buildWorkItem(exp)),

                  const SizedBox(height: 24),

                  // Education Section
                  _buildSectionTitle('Education'),
                  ...widget.resumeData.education.map((edu) => _buildEducationItem(edu)),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Retry button with better styling and more visible
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed: _submitResume,
              icon: const Icon(Icons.refresh),
              label: const Text(
                'Try Again',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFD833),
                foregroundColor: Colors.black,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  void _submitResume() async {
    setState(() {
      _isLoading = false;
      _state = SubmissionState.loading;
      _errorMessage = null;
    });

    try {
      final response = await ApiRepository.generateResumePdf(widget.resumeData.toJson());
      _timeoutTimer?.cancel();

      if (!mounted) return;
      setState(() {
        _isLoading = false;
        if (response.isSuccess!) {
          _pdfUrl = response.data?['pdfUrl'];
          _resumeId = response.data?['resumeId'];
          _state = SubmissionState.success;
        } else {
          _state = SubmissionState.error;
          _errorMessage = "Failed to generate resume PDF";
        }
      });
    } catch (e) {
      _timeoutTimer?.cancel();
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _state = SubmissionState.error;
        _errorMessage = "An error occurred: $e";
      });
    }
  }


  void _openPdfPreview() async {
    setState(() => _isLoading = true);
    try {
      final response = await ApiRepository.previewResume({});
      if (!mounted) return;
      setState(() => _isLoading = false);

      if (response.isSuccess! && response.data != null) {
        final responseData = response.data;
        if (responseData['type'] == 'Buffer' && responseData['data'] != null) {
          final List<dynamic> bufferData = responseData['data'];
          final Uint8List pdfBytes = Uint8List.fromList(List<int>.from(bufferData));
          await _showPdfPreviewDialog(pdfBytes);
        } else {
          await _showErrorDialogWithRetry('Preview Error', 'Invalid buffer format in response', _openPdfPreview);
        }
      } else {
        await _showErrorDialogWithRetry('Preview Error', 'Failed to load resume preview.', _openPdfPreview);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      await _showErrorDialogWithRetry('Error', 'An error occurred while loading the preview: $e', _openPdfPreview);
    }
  }

  Future<void> _showPdfPreviewDialog(Uint8List pdfBytes) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
              maxWidth: MediaQuery.of(context).size.width * 0.9,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Custom app bar with close button and title
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(dialogContext).pop();
                        },
                        child: const Icon(Icons.close, color: Colors.black, size: 28),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'Resume Preview',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // White divider
                const Divider(height: 1, thickness: 1, color: Colors.white),

                // Syncfusion PDF viewer - displays the actual PDF content from memory
                Expanded(
                  child: SfPdfViewer.memory(
                    pdfBytes,
                    canShowScrollHead: false,
                    enableDoubleTapZooming: true,
                    enableTextSelection: false,
                    pageSpacing: 4.0,
                    controller: PdfViewerController(),
                  ),
                ),

                // Close button at the bottom
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFD833),
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Close',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showErrorDialogWithRetry(String title, String message, VoidCallback retryCallback) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext errorContext) => AlertDialog(
        title: Text(
          title,
          style: TextStyle(
            color: Colors.red.shade700,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message),
            const SizedBox(height: 16),
            const Text(
              'Would you like to try again?',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(errorContext).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(errorContext).pop();
              // Add a small delay before retrying to prevent immediate recursive calls
              Future.delayed(const Duration(milliseconds: 300), () {
                retryCallback();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFD833),
              foregroundColor: Colors.black,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }


  void _initiatePayment() async {
    setState(() => _isLoading = true);
    try {
      final initiateResponse = await ApiRepository.initiatePaymentResume({"amount": 10});

      if (!initiateResponse.isSuccess! || initiateResponse.data == null) {
        if (!mounted) return;
        setState(() => _isLoading = false);
        _showErrorDialogWithRetry('Payment Error', 'Failed to initiate payment. Please try again.', _initiatePayment);
        return;
      }

      final responseData = initiateResponse.data;
      final String? orderId = responseData['orderId'];
      final providerData = responseData['providerData'];
      final String? paymentSessionId = providerData['payment_session_id'];

      if (orderId == null || paymentSessionId == null) {
        if (!mounted) return;
        setState(() => _isLoading = false);
        _showErrorDialogWithRetry('Payment Error', 'Invalid response data. Please try again.', _initiatePayment);
        return;
      }

      await PaymentService().startPayment(
        orderId: orderId,
        paymentSessionId: paymentSessionId,
        isProduction: false,
      );

      if (mounted) setState(() => _isLoading = false);
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
      _showErrorDialogWithRetry('Payment Error', 'An error occurred while processing payment: $e', _initiatePayment);
    }
  }


  void _showPaymentSuccessDialog(VoidCallback onDownload) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Payment Successful',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 48,
            ),
            SizedBox(height: 16),
            Text(
              'Your payment has been successfully processed. You can now download your resume.',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onDownload();
            },
            child: const Text('Download Now'),
          ),
        ],
      ),
    );
  }

  void _verifyPayment(String orderId) async {
    setState(() => _isLoading = true);
    try {
      final verifyResponse = await ApiRepository.verifyPaymentResume({
        "orderId": orderId,
        "expectedAmount": 10,
        "resumeId": _resumeId ?? 0,
      });

      if (!mounted) return;
      setState(() => _isLoading = false);

      if (!verifyResponse.isSuccess!) {
        _showErrorDialogWithRetry(
          'Verification Failed',
          'Payment verification failed. Please try again.',
              () => _verifyPayment(orderId),
        );
        return;
      }

      _showPaymentSuccessDialog(() {
        _downloadResume();
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      _showErrorDialogWithRetry('Verification Error', 'An error occurred while verifying payment: $e', () => _verifyPayment(orderId));
    }
  }



  void _downloadResume() async {
    setState(() => _isLoading = true);
    try {
      final response = await ApiRepository.downLoadResume({});
      if (!mounted) return;
      setState(() => _isLoading = false);

      if (!response.isSuccess!) {
        _showErrorDialogWithRetry('Download Error', 'Failed to download resume. Please try again.', _downloadResume);
        return;
      }

      final resumeUrl = response.data?['resumeUrl'];
      if (resumeUrl != null) {
        // First check if we have permission
        var status = await Permission.storage.status;
        if (!status.isGranted) {
          // If not granted, request permission with better explanation
          status = await Permission.storage.request();
          // If still not granted after request, show app settings dialog
          if (!status.isGranted) {
            if (!await _requestStoragePermission()) {
              _showPermissionSettingsDialog();
              return;
            }
          }
        }

        // Continue with download if permission granted
        final uri = Uri.parse(resumeUrl);
        final responseFile = await http.get(uri);
        final bytes = responseFile.bodyBytes;

        // Use getApplicationDocumentsDirectory for better compatibility
        final directory = await getApplicationDocumentsDirectory();
        final fileName = 'resume_${DateTime.now().millisecondsSinceEpoch}.pdf';
        final filePath = '${directory.path}/$fileName';
        final file = File(filePath);
        await file.writeAsBytes(bytes);

        _showInfoDialog('Download Successful', 'Your resume has been saved successfully.');
      } else {
        _showErrorDialogWithRetry('Download Error', 'No resume URL found in response.', _downloadResume);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      _showErrorDialogWithRetry('Download Error', 'An error occurred while downloading the resume: $e', _downloadResume);
    }
  }

  Future<bool> _requestStoragePermission() async {
    final status = await Permission.storage.status;

    if (status.isGranted) {
      return true;
    }

    final result = await Permission.storage.request();

    if (result.isGranted) {
      return true;
    } else if (result.isPermanentlyDenied) {
      await openAppSettings(); // optional: guide user to manually enable
    }

    return false;
  }

// Add this new method to show permission settings dialog
  void _showPermissionSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Storage Permission Required'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'To download your resume, the app needs permission to access your device storage. Please enable this permission in your device settings.',
            ),
            SizedBox(height: 16),
            Text(
              'Would you like to open settings now?',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              openAppSettings();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFD833),
              foregroundColor: Colors.black,
            ),
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  void _showInfoDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
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
}

class PaymentResult {
  final bool success;
  final bool cancelled;
  final String orderId;

  PaymentResult({
    required this.success,
    required this.cancelled,
    required this.orderId,
  });


}
