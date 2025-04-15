// lib/utils/payment_helper.dart
import 'package:flutter/material.dart';
import 'package:lokal/screens/Payments/payment_model.dart';

import 'CashFreePaymentService.dart';


class PaymentHelper {
  // Cashfree credentials - Replace with your actual credentials
  static const PaymentConfig cashfreeConfig = PaymentConfig(
    appId: 'YOUR_CASHFREE_APP_ID',
    secretKey: 'YOUR_CASHFREE_SECRET_KEY',
    isProduction: false, // Set to true for production
  );

  // Get Cashfree payment service instance
  static CashfreePaymentService getCashfreeService() {
    return CashfreePaymentService(
      appId: cashfreeConfig.appId,
      secretKey: cashfreeConfig.secretKey,
      isProduction: cashfreeConfig.isProduction,
    );
  }

  // Process resume payment and download
  static Future<PaymentResult> processResumePayment({
    required BuildContext context,
    required String customerName,
    required String customerPhone,
    required String customerEmail,
    required String pdfUrl,
  }) async {
    final paymentService = getCashfreeService();

    final result = await paymentService.processResumePayment(
      context: context,
      customerName: customerName,
      customerPhone: customerPhone,
      customerEmail: customerEmail,
      pdfUrl: pdfUrl,
      amount: 10.0, // Rs 10 for resume download
    );

    if (result.paid == true) {
      // Handle successful payment
      // You can download the PDF or update your UI here
    }

    return result;
  }

  // Show payment result dialog
  static void showPaymentResultDialog({
    required BuildContext context,
    required PaymentResult result,
    VoidCallback? onSuccess,
    VoidCallback? onFailure,
  }) {
    final isSuccess = result.paid == true;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          isSuccess ? 'Payment Successful' : 'Payment Failed',
          style: TextStyle(
            color: isSuccess ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSuccess ? Icons.check_circle : Icons.error,
              color: isSuccess ? Colors.green : Colors.red,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              isSuccess
                  ? 'Your payment has been successfully processed. You can now download your resume.'
                  : result.message ?? 'There was a problem processing your payment. Please try again.',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (isSuccess && onSuccess != null) {
                onSuccess();
              } else if (!isSuccess && onFailure != null) {
                onFailure();
              }
            },
            child: Text(isSuccess ? 'OK' : 'Try Again'),
          ),
        ],
      ),
    );
  }
}