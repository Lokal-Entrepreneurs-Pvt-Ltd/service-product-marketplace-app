import '../../constants/json_constants.dart';

class ApiRequestBody {
  static getLoginRequest(String email, password) {
    return {EMAIL: email, PASSWORD: password};
  }

  static getSignUpRequest(String email, password) {
    return {EMAIL: email, PASSWORD: password};
  }

  static submitIspFormRequest(
      stateCode,
      districtCode,
      blockCode,
      stateName,
      districtName,
      blockName,
      customerName,
      email,
      phoneNo,
      latitude,
      longitude) {
    return {
      CUSTOMER_NAME: customerName,
      EMAIL: email,
      ISP_PHONE_NUMBER: phoneNo,
      STATE_CODE: stateCode,
      STATE_NAME: stateName,
      DISTRICT_CODE: districtCode,
      DISTRICT_NAME: districtName,
      BLOCK_CODE: blockCode,
      BLOCK_NAME: blockName,
      LATITUDE: latitude,
      LONGITUDE: longitude
    };
  }

  static getUpdateCartRequest(String skuId, String action, String cartId) {
    return {
      SKU_ID: skuId,
      ACTION: action,
      CART_ID: cartId,
    };
  }

  static confirmTowerRequest(int value, String towerId) {
    return {
      ID: value,
      TOWER_ID: towerId,
    };
  }

  static getNotificationAddUserDetailsRequest(String token, String tokenType) {
    return {
      TOKEN: token,
      TOKEN_TYPE: tokenType,
    };
  }

  static getSaveDetailsRequest(
      String name, String email, String gst, String dob, String phone) {
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

  static getPaymentNextRequest(String paymentMethod) {
    return {PAYMENT_METHOD: paymentMethod};
  }

  static getValidatePayment(
      String orderNumberId, String rzpPaymentId, String rzpSignature) {
    return {
      ORDER_NUMBER_ID: orderNumberId,
      RAZOR_PAYMENT_ID: rzpPaymentId,
      RAZOR_PAY_SIGNATURE: rzpSignature
    };
  }
}
