import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayPayment {
  final Razorpay _razorpay = Razorpay();

  Map<String, dynamic> options = {
    'key': 'HqtzkMv1vxs2f8',
    'amount': 0, //in the smallest currency sub-unit.
    'name': 'Lokal',
    'order_id': '', // Generate order_id using Orders API
    'description': 'WIFI',
    'timeout': 300, // in seconds
    'prefill': {
      'contact': '9012345678',
      'email': 'dummy@gmail.com',
    },
  };

  RazorpayPayment({required String orderId}) {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void dispose() {
    _razorpay.clear();
  }

  void openPaymentPage() {
    _razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }
}
