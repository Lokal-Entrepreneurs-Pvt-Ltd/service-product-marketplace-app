// lib/services/payment/cashfree_payment_service.dart
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'payment_model.dart';

class CashfreePaymentService {
  // API endpoints
  static const String _productionHost = "https://api.cashfree.com/pg";
  static const String _sandboxHost = "https://sandbox.cashfree.com/pg";

  // Configuration variables
  final bool _isProduction;
  final String _appId;
  final String _secretKey;

  CashfreePaymentService({
    required String appId,
    required String secretKey,
    bool isProduction = false,
  }) : _appId = appId,
        _secretKey = secretKey,
        _isProduction = isProduction;

  String get _baseUrl => _isProduction ? _productionHost : _sandboxHost;

  /// Create a payment order on Cashfree
  Future<PaymentResult> createOrder({
    required String orderId,
    required double amount,
    required String currency,
    required String customerName,
    required String customerPhone,
    required String customerEmail,
    String? description,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final url = '$_baseUrl/orders';

      final headers = {
        'Content-Type': 'application/json',
        'x-client-id': _appId,
        'x-client-secret': _secretKey,
      };

      final body = jsonEncode({
        'order_id': orderId,
        'order_amount': amount,
        'order_currency': currency,
        'customer_details': {
          'customer_id': customerPhone, // Using phone as customer ID
          'customer_name': customerName,
          'customer_email': customerEmail,
          'customer_phone': customerPhone,
        },
        'order_meta': {
          'return_url': 'https://yourapp.com/return?order_id={order_id}',
          'notify_url': 'https://yourapp.com/notify',
        },
        'order_note': description ?? 'Payment for services',
        if (metadata != null) ...metadata,
      });

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return PaymentResult(
          isSuccess: true,
          orderId: orderId,
          paymentSessionId: responseData['cf_order_id'],
          paymentUrl: responseData['payment_link'],
          message: 'Order created successfully',
          data: responseData,
        );
      } else {
        return PaymentResult(
          isSuccess: false,
          orderId: orderId,
          message: responseData['message'] ?? 'Failed to create order',
          data: responseData,
        );
      }
    } catch (e) {
      return PaymentResult(
        isSuccess: false,
        orderId: orderId,
        message: 'Exception: $e',
      );
    }
  }

  /// Get the status of a payment order
  Future<PaymentResult> getOrderStatus(String orderId) async {
    try {
      final url = '$_baseUrl/orders/$orderId';

      final headers = {
        'Content-Type': 'application/json',
        'x-client-id': _appId,
        'x-client-secret': _secretKey,
      };

      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final orderStatus = responseData['order_status'];
        final isPaymentSuccessful = orderStatus == 'PAID';

        return PaymentResult(
          isSuccess: true,
          orderId: orderId,
          paid: isPaymentSuccessful,
          message: 'Order status: $orderStatus',
          data: responseData,
        );
      } else {
        return PaymentResult(
          isSuccess: false,
          orderId: orderId,
          message: responseData['message'] ?? 'Failed to get order status',
          data: responseData,
        );
      }
    } catch (e) {
      return PaymentResult(
        isSuccess: false,
        orderId: orderId,
        message: 'Exception: $e',
      );
    }
  }

  /// Show payment gateway in a WebView
  Future<PaymentResult> showPaymentGateway({
    required BuildContext context,
    required String paymentUrl,
    required String orderId,
    bool fullscreen = false,
  }) async {
    final Completer<PaymentResult> completer = Completer<PaymentResult>();

    // Create WebView controller
    late WebViewController controller;

    // Method to check the payment status
    Future<void> checkPaymentStatus() async {
      final result = await getOrderStatus(orderId);
      if (!completer.isCompleted) {
        completer.complete(result);
      }
      Navigator.of(context).pop(); // Close the WebView
    }

    // Show WebView in a dialog or fullscreen
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
                isSuccess: false,
                orderId: orderId,
                message: 'Payment cancelled by user',
              ));
              return true;
            }

            return shouldPop;
          },
          child: Dialog(
            insetPadding: fullscreen
                ? EdgeInsets.zero
                : const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Container(
              width: fullscreen
                  ? MediaQuery.of(context).size.width
                  : MediaQuery.of(context).size.width * 0.9,
              height: fullscreen
                  ? MediaQuery.of(context).size.height
                  : MediaQuery.of(context).size.height * 0.8,
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
                              isSuccess: false,
                              orderId: orderId,
                              message: 'Payment cancelled by user',
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
                                // Check if the URL is the return URL
                                if (request.url.contains('yourapp.com/return')) {
                                  // Payment completed, check status
                                  checkPaymentStatus();
                                  return NavigationDecision.prevent;
                                }
                                return NavigationDecision.navigate;
                              },
                              onPageFinished: (String url) {
                                // Handle page finish events if needed
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

    // Wait for the payment result
    return completer.future;
  }

  /// Process a resume download payment
  Future<PaymentResult> processResumePayment({
    required BuildContext context,
    required String customerName,
    required String customerPhone,
    required String customerEmail,
    required String pdfUrl,
    double amount = 10.0, // Default Rs 10
  }) async {
    try {
      // Generate a unique order ID
      final orderId = 'resume_${DateTime.now().millisecondsSinceEpoch}';

      // Create payment order
      final orderResult = await createOrder(
        orderId: orderId,
        amount: amount,
        currency: 'INR',
        customerName: customerName,
        customerPhone: customerPhone,
        customerEmail: customerEmail,
        description: 'Resume Download',
        metadata: {
          'pdf_url': pdfUrl,
        },
      );

      if (!orderResult.isSuccess) {
        return orderResult;
      }

      // Show payment gateway
      final paymentResult = await showPaymentGateway(
        context: context,
        paymentUrl: orderResult.paymentUrl!,
        orderId: orderId,
      );

      if (paymentResult.paid == true) {
        // Payment successful, now handle the download
        return paymentResult;
      } else {
        // Payment failed or was cancelled
        return paymentResult;
      }
    } catch (e) {
      return PaymentResult(
        isSuccess: false,
        message: 'Exception during payment process: $e',
      );
    }
  }
}