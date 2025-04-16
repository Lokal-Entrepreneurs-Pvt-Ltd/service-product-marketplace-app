// lib/services/payment_service.dart

import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfwebcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';

class PaymentService {
  static final PaymentService _instance = PaymentService._internal();
  factory PaymentService() => _instance;

  PaymentService._internal();

  final CFPaymentGatewayService _cfService = CFPaymentGatewayService();

  void Function(String orderId)? onPaymentSuccess;
  void Function(CFErrorResponse error, String orderId)? onPaymentFailure;

  void setup() {
    _cfService.setCallback(
          (orderId) {
        onPaymentSuccess?.call(orderId);
      },
          (error, orderId) {
        onPaymentFailure?.call(error, orderId);
      },
    );
  }

  Future<void> startPayment({
    required String orderId,
    required String paymentSessionId,
    bool isProduction = false,
  }) async {
    final session = CFSessionBuilder()
        .setEnvironment(isProduction ? CFEnvironment.PRODUCTION : CFEnvironment.SANDBOX)
        .setOrderId(orderId)
        .setPaymentSessionId(paymentSessionId)
        .build();

    final theme = CFThemeBuilder()
        .setNavigationBarBackgroundColorColor("#FFD833")
        .setNavigationBarTextColor("#000000")
        .build();

    final cfWebCheckout = CFWebCheckoutPaymentBuilder()
        .setSession(session)
        .setTheme(theme)
        .build();

    _cfService.doPayment(cfWebCheckout);
  }
}
