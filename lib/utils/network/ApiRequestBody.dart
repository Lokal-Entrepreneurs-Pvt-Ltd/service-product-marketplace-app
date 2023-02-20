import '../../constants/json_constants.dart';

class ApiRequestBody {
  static getLoginRequest(String email, password) {
    return {EMAIL: email, PASSWORD: password};
  }

  static getSignUpRequest(String email, password) {
    return {EMAIL: email, PASSWORD: password};
  }

  static getUpdateCartRequest(String skuId,String action, String cartId) {
   return {
      SKU_ID: skuId,
      ACTION: action,
      CART_ID: cartId,
    };
  }

  static getSaveDetailsRequest(String name, String email, String gst, String dob, String phone) {
    return {
      NAME: name,
      EMAIL: email,
      TAX_VAT: gst,
      DOB: dob,
      PHONE: phone,
    };
  }

  static getSendOtpRequest(String phoneNumber) {
    return {PHONE_NUMBER: phoneNumber};
  }

  static getVerifyOtpRequest(String phoneNumber, String otp) {
    return {PHONE_NUMBER: phoneNumber, OTP: otp};
  }

  static getAddressNextRequest(String cartId, num addressId) {
    return {CART_ID: cartId, ADDRESS_ID: addressId};
  }

  static getPaymentNextRequest( String paymentMethod) {
    return { PAYMENT_METHOD: paymentMethod};
  }

}
