import 'package:lokal/constants/json_constants.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/network/ApiRequestBody.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../configs/environment.dart';

class RazorpayPayment {
  final Razorpay _razorpay = Razorpay();

  Map<String, dynamic> options = {};

  var phone = UserDataHandler.getUserPhone();
  var email = UserDataHandler.getUserEmail();
  String orderNumberId = "";

  RazorpayPayment({required String rzpOrderId, required this.orderNumberId}) {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    options = {
      'key': Environment().config.razorPayKey,
      'amount': 1000, //in the smallest currency sub-unit.
      'name': 'Lokal',
      'order_id': rzpOrderId, // Generate order_id using Orders API
      'description': 'WIFI',
      'timeout': 300, // in seconds
      'prefill': {
        'contact': phone,
        'email': email,
      },
    };
  }

  void dispose() {
    _razorpay.clear();
  }

  void openPaymentPage() {
   try{
     _razorpay.open(options);
   }
   catch(e){
     print(e);
   }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print( "Payment Success"+ response.toString());
    print( "order Id"+orderNumberId);
    print( response.paymentId);
    print(response.signature);
    NavigationUtils.showLoaderOnTop();
   validatePayment(orderNumberId,response.paymentId,response.signature);
  }

  Future<void> validatePayment(  String? orderNumberId, String? rzpPaymentId, String? rzpSignature) async {
    dynamic response = await ApiRepository.validatePayment(
      ApiRequestBody.getValidatePayment(orderNumberId!, rzpPaymentId!,rzpSignature!),
    );
    NavigationUtils.pop();
    if (response.isSuccess!) {
       var orderNumberId = response.data[ORDER_NUMBER_ID];
       Map<String, dynamic>? args = {
         ORDER_NUMBER_ID: orderNumberId,
         PAYMENT_METHOD: PAYMENT_METHOD_ONLINE,
       };
       NavigationUtils.openOrderScreen(args);
    } else {
      UiUtils.showToast(response.error![MESSAGE]);
      NavigationUtils.openHomeScreen({});
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("paymebnt fail");
    UiUtils.showToast(response.message.toString());
    NavigationUtils.openHomeScreen({});
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    print("paymebnt external");
  }
}
