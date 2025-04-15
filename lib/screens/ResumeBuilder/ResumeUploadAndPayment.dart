// resume_final.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'dart:typed_data';
import 'resumeDataModel.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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

class _ResumeUploadAndPaymentState extends State<ResumeUploadAndPayment> {
  SubmissionState _state = SubmissionState.loading;
  String? _pdfUrl;
  String? _errorMessage;
  int? _resumeId; // Add resumeId to store it

  // Timer to handle API timeouts
  Timer? _timeoutTimer;

  @override
  void initState() {
    super.initState();
    // Call API immediately when screen opens
    _submitResume();

    // Set up a timeout to handle cases where the API might hang
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
    // Cancel the timer when the widget is disposed
    _timeoutTimer?.cancel();
    super.dispose();
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
          'Resume Builder',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.blue),
            onPressed: () {
              // Show info about the service
            },
          ),
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: _buildContent(),
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
          const Text(
            'We have more than 100 Jobs matching your resume.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          // "Taking too long" cancel button has been removed
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
    // Cancel any existing timeout timer and set up a new one
    _setupTimeout();

    // Update state to loading
    setState(() {
      _state = SubmissionState.loading;
      _errorMessage = null;
    });

    try {
      // Call API to generate PDF
      final response = await ApiRepository.generateResumePdf(
        widget.resumeData.toJson(),
      );

      // Cancel the timeout timer since we got a response
      _timeoutTimer?.cancel();

      if (response.isSuccess!) {
        // Store PDF URL if available
        if (response.data != null && response.data['pdfUrl'] != null) {
          _pdfUrl = response.data['pdfUrl'] as String;
        }

        // Extract and store the resumeId
        if (response.data != null &&
            response.data['response'] != null &&
            response.data['response']['resumeId'] != null) {
          _resumeId = response.data['response']['resumeId'];
        }

        // Update state to success
        setState(() {
          _state = SubmissionState.success;
        });
      } else {
        // Handle error
        setState(() {
          _state = SubmissionState.error;
          _errorMessage = "Failed to generate resume PDF";
        });
      }
    } catch (e) {
      // Cancel the timeout timer since we got a response (even if it's an error)
      _timeoutTimer?.cancel();

      // Handle exception
      setState(() {
        _state = SubmissionState.error;
        _errorMessage = "An error occurred: $e";
      });
    }
  }

  void _openPdfPreview() async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      // Call API to get resume preview
      final response = await ApiRepository.previewResume({});

      // Close loading dialog
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }

      if (response.isSuccess! && response.data != null) {
        // Extract the PDF buffer data
        final responseData = response.data;

        if (responseData['type'] == 'Buffer' && responseData['data'] != null) {
          // Convert buffer array to Uint8List
          final List<dynamic> bufferData = responseData['data'];
          final Uint8List pdfBytes = Uint8List.fromList(List<int>.from(bufferData));

          // Show PDF preview dialog with actual PDF content
          _showPdfPreviewDialog(pdfBytes);
        } else {
          _showErrorDialogWithRetry('Preview Error', 'Invalid buffer format in response', _openPdfPreview);
        }
      } else {
        _showErrorDialogWithRetry('Preview Error', 'Failed to load resume preview.', _openPdfPreview);
      }
    } catch (e) {
      // Close loading dialog if it's still open
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }

      _showErrorDialogWithRetry('Error', 'An error occurred while loading the preview: $e', _openPdfPreview);
    }
  }

// First, add this to your pubspec.yaml:
// dependencies:
//   syncfusion_flutter_pdfviewer: ^23.1.36 (or latest version)

// Then add this import at the top of your file:


  void _showPdfPreviewDialog(Uint8List pdfBytes) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
                        onTap: () => Navigator.of(context).pop(),
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
                    canShowScrollHead: false, // Hide the scroll head for cleaner UI
                    enableDoubleTapZooming: true,
                    enableTextSelection: false, // Set to true if you want users to select text
                    pageSpacing: 4.0,
                    controller: PdfViewerController(), // You can store this in a class variable if needed
                  ),
                ),

                // Close button at the bottom
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
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
  // New method to show error dialog with retry button
  void _showErrorDialogWithRetry(String title, String message, VoidCallback retryCallback) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              retryCallback();
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
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      // Step 1: Initiate payment on your server to get the orderId
      final initiateResponse = await ApiRepository.initiatePaymentResume({
        "amount": 10
      });

      // Close loading dialog
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }

      if (!initiateResponse.isSuccess! || initiateResponse.data == null) {
        _showErrorDialogWithRetry('Payment Error', 'Failed to initiate payment. Please try again.', _initiatePayment);
        return;
      }

      // Print the response for debugging
      print("Payment initiation response: ${initiateResponse.data}");

      // Extract orderId and payment details with proper null checks
      final responseData = initiateResponse.data['response'];
      if (responseData == null) {
        _showErrorDialogWithRetry('Payment Error', 'Invalid response format. Please try again.', _initiatePayment);
        return;
      }

      final String? orderId = responseData['orderId'];
      if (orderId == null) {
        _showErrorDialogWithRetry('Payment Error', 'Order ID not found in response. Please try again.', _initiatePayment);
        return;
      }

      final providerData = responseData['providerData'];
      if (providerData == null) {
        _showErrorDialogWithRetry('Payment Error', 'Provider data not found in response. Please try again.', _initiatePayment);
        return;
      }

      final String? paymentSessionId = providerData['payment_session_id'];
      if (paymentSessionId == null) {
        _showErrorDialogWithRetry('Payment Error', 'Payment session ID not found. Please try again.', _initiatePayment);
        return;
      }

      // Step 2: Open Cashfree payment page using WebView
      final paymentResult = await _openCashfreePayment(
        context: context,
        orderId: orderId,
        paymentSessionId: paymentSessionId,
      );

      if (paymentResult.cancelled) {
        _showInfoDialog('Payment Cancelled', 'You cancelled the payment process.');
        return;
      }

      if (!paymentResult.success) {
        _showErrorDialogWithRetry('Payment Failed', 'The payment process failed. Please try again.', _initiatePayment);
        return;
      }

      // Step 3: Verify payment on your server
      final verifyResponse = await ApiRepository.verifyPaymentResume({
        "orderId": orderId,
        "expectedAmount": 10,
        "resumeId": _resumeId ?? 0,
      });

      if (!verifyResponse.isSuccess!) {
        _showErrorDialogWithRetry(
            'Verification Failed',
            'Payment was processed but verification failed. Please try again.',
                () => _verifyPayment(orderId)  // Create this method separately
        );
        return;
      }

      // Step 4: Show success dialog and offer to download
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
                _downloadResume();
              },
              child: const Text('Download Now'),
            ),
          ],
        ),
      );
    } catch (e) {
      // Close loading dialog if still showing
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }

      // Print detailed error information for debugging
      print("Payment error: $e");
      _showErrorDialogWithRetry('Payment Error', 'An error occurred while processing payment: $e', _initiatePayment);
    }
  }

  // New method to handle payment verification separately
  void _verifyPayment(String orderId) async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      // Verify payment on your server
      final verifyResponse = await ApiRepository.verifyPaymentResume({
        "orderId": orderId,
        "expectedAmount": 10,
        "resumeId": _resumeId ?? 0,
      });

      // Close loading dialog
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }

      if (!verifyResponse.isSuccess!) {
        _showErrorDialogWithRetry(
            'Verification Failed',
            'Payment verification failed. Please try again.',
                () => _verifyPayment(orderId)
        );
        return;
      }

      // Show success dialog and offer to download
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
                _downloadResume();
              },
              child: const Text('Download Now'),
            ),
          ],
        ),
      );
    } catch (e) {
      // Close loading dialog if still showing
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }

      _showErrorDialogWithRetry('Verification Error', 'An error occurred while verifying payment: $e', () => _verifyPayment(orderId));
    }
  }

  Future<PaymentResult> _openCashfreePayment({
    required BuildContext context,
    required String orderId,
    required String paymentSessionId,
  }) async {
    // Create the payment URL with your Cashfree integration
    final paymentUrl = 'https://sandbox.cashfree.com/pg/orders/$orderId/pay' +
        '?payment_session_id=$paymentSessionId';

    final Completer<PaymentResult> completer = Completer<PaymentResult>();

    // Create WebView controller
    late WebViewController controller;

    // Show WebView in a dialog
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            // Handle back button press
            bool shouldPop = false;

            await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Cancel Payment?'),
                content: const Text('Are you sure you want to cancel this payment?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      shouldPop = true;
                      Navigator.of(context).pop();
                    },
                    child: const Text('Yes'),
                  ),
                ],
              ),
            );

            if (shouldPop && !completer.isCompleted) {
              completer.complete(PaymentResult(
                success: false,
                cancelled: true,
                orderId: orderId,
              ));
              return true;
            }

            return shouldPop;
          },
          child: Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
                maxWidth: MediaQuery.of(context).size.width * 0.9,
              ),
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    title: const Text(
                      'Payment Gateway',
                      style: TextStyle(color: Colors.black),
                    ),
                    leading: IconButton(
                      icon: const Icon(Icons.close, color: Colors.black),
                      onPressed: () async {
                        bool shouldClose = false;

                        await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Cancel Payment?'),
                            content: const Text('Are you sure you want to cancel this payment?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('No'),
                              ),
                              TextButton(
                                onPressed: () {
                                  shouldClose = true;
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Yes'),
                              ),
                            ],
                          ),
                        );

                        if (shouldClose) {
                          if (!completer.isCompleted) {
                            completer.complete(PaymentResult(
                              success: false,
                              cancelled: true,
                              orderId: orderId,
                            ));
                          }
                          Navigator.of(context).pop(); // Close payment dialog
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: Builder(
                      builder: (BuildContext context) {
                        final WebViewController webViewController = WebViewController()
                          ..setJavaScriptMode(JavaScriptMode.unrestricted)
                          ..setNavigationDelegate(
                            NavigationDelegate(
                              onNavigationRequest: (NavigationRequest request) {
                                // Check if the URL contains success or failure indicators
                                if (request.url.contains('success=true') ||
                                    request.url.toLowerCase().contains('status=success')) {
                                  // Payment completed successfully
                                  if (!completer.isCompleted) {
                                    completer.complete(PaymentResult(
                                      success: true,
                                      cancelled: false,
                                      orderId: orderId,
                                    ));
                                  }
                                  Navigator.of(context).pop(); // Close payment dialog
                                  return NavigationDecision.prevent;
                                } else if (request.url.contains('success=false') ||
                                    request.url.toLowerCase().contains('status=failure')) {
                                  // Payment failed
                                  if (!completer.isCompleted) {
                                    completer.complete(PaymentResult(
                                      success: false,
                                      cancelled: false,
                                      orderId: orderId,
                                    ));
                                  }
                                  Navigator.of(context).pop(); // Close payment dialog
                                  return NavigationDecision.prevent;
                                }
                                return NavigationDecision.navigate;
                              },
                              onPageFinished: (String url) {
                                // Handle page finish events if needed
                                if (url.contains('status=SUCCESS') ||
                                    url.contains('status=success')) {
                                  // Payment completed successfully based on URL
                                  if (!completer.isCompleted) {
                                    completer.complete(PaymentResult(
                                      success: true,
                                      cancelled: false,
                                      orderId: orderId,
                                    ));
                                  }
                                  Navigator.of(context).pop(); // Close payment dialog
                                }
                              },
                            ),
                          )
                          ..loadRequest(Uri.parse(paymentUrl));

                        controller = webViewController;

                        return WebViewWidget(
                          controller: webViewController,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    // If dialog is closed without completing
    if (!completer.isCompleted) {
      completer.complete(PaymentResult(
        success: false,
        cancelled: true,
        orderId: orderId,
      ));
    }

    // Wait for the payment result
    return completer.future;
  }

  void _downloadResume() async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      // Call API to get resume download
      final response = await ApiRepository.downLoadResume({});

      // Close loading dialog
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }

      if (!response.isSuccess!) {
        _showErrorDialogWithRetry('Download Error', 'Failed to download resume. Please try again.', _downloadResume);
        return;
      }

      // Handle the download response
      // This depends on your API implementation:
      // 1. It could return a file that you save to device
      // 2. It could return a URL that you open in browser
      // 3. It could return base64 content that you convert to a file

      _showInfoDialog(
          'Download Successful',
          'Your resume has been downloaded successfully.'
      );
    } catch (e) {
      // Close loading dialog if still showing
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }

      _showErrorDialogWithRetry('Download Error', 'An error occurred while downloading the resume: $e', _downloadResume);
    }
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