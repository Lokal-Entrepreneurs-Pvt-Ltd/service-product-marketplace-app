// lib/services/payment/payment_model.dart
class PaymentResult {
  /// Whether the API call was successful (not necessarily if payment was made)
  final bool isSuccess;

  /// Order ID for the transaction
  final String? orderId;

  /// Payment session ID from the payment gateway
  final String? paymentSessionId;

  /// URL to redirect the user to complete payment
  final String? paymentUrl;

  /// Whether the payment has been made successfully
  final bool? paid;

  /// Message describing the result
  final String? message;

  /// Additional data returned by the payment gateway
  final Map<String, dynamic>? data;

  PaymentResult({
    required this.isSuccess,
    this.orderId,
    this.paymentSessionId,
    this.paymentUrl,
    this.paid,
    this.message,
    this.data,
  });
}

class PaymentConfig {
  final String appId;
  final String secretKey;
  final bool isProduction;

  const PaymentConfig({
    required this.appId,
    required this.secretKey,
    this.isProduction = false,
  });
}