import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:login/testing/fire.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'fire.dart';

class Pay extends StatefulWidget {
  const Pay({super.key});

  @override
  State<Pay> createState() => _PayState();
}

var _razorpay = Razorpay();

var options = {
  'key': 'rzp_test_NNbwJ9tmM0fbxj',
  'amount': 100,
  'name': 'Acme Corp.',
  'description': 'Fine T-Shirt',
  'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
};

class _PayState extends State<Pay> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    log("Success ${response.signature}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    log("Fail");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    log("wallet");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Pay"),
          onPressed: () {
            _razorpay.open(options);
          },
        ),
      ),
    );
  }
}
