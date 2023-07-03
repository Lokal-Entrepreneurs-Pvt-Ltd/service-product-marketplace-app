import '../../constants/json_constants.dart';

class ApiRequestBody {
  static getLoginRequest(String email, password) {
    return {EMAIL: email, PASSWORD: password};
  }

  static getSignUpRequest(String email, password) {
    return {EMAIL: email, PASSWORD: password};
  }

  static getOptinRequest(String serviceCode) {
    return {SERVICE_CODE: serviceCode};
  }

  static submitSamhitaAddParticipantsFormRequest(
      firstName,
      middleName,
      lastName,
      mobileNo,
      ipId,
      emailId,
      onboardingDate,
      dob,
      gender,
      aadhaarNo,
      panNo,
      addressLine1,
      addressLine2,
      village,
      state,
      district,
      city,
      pincode) {
    return {
      FIRST_NAME: firstName,
      MIDDLE_NAME: middleName,
      LAST_NAME_C: lastName,
      MOBILE_No: mobileNo,
      IP_ID: ipId,
      EMAIL_ID: emailId,
      ON_BOARDING_DATE: onboardingDate,
      DOB: dob,
      GENDER: gender,
      AADHAR_NUMBER: aadhaarNo,
      PAN_NUMBER: panNo,
      ADDRESS_LINE_1: addressLine1,
      ADDRESS_LINE_2: addressLine2,
      VILLAGE: village,
      STATE: state,
      DISTRICT: district,
      CITY: city,
      PINCODE: pincode
    };
  }

  static submitSamhitaBecomeParticipantFormRequest(
    firstName,
    lastName,
    mobileNo,
    email,
    requestID,
  ) {
    return {
      FIRST_NAME: firstName,
      LAST_NAME_C: lastName,
      MOBILE_No: mobileNo,
      EMAIL_ID: email,
      GROUP: "participant",
      USERTYPE: "Participant",
      ROLE: "PARTICIPANT",
      REQUEST_ID: requestID,
      onboardingDate: onboardingDate,
      dob: dob,
    };
  }

  static submitSamhitaVerifyParticipantFormRequest(
    participantName,
    mobile,
    samhitaId
  ) {
    return {
      PARTICIPANT_NAME: participantName,
      MOBILE: mobile,
      SAMHITA_ID: samhitaId,
    };
  }

  static getVerifyAddFleetOtpRequest(String mobile, String otp) {
    return {MOBILE: mobile, OTP: otp};
  }

  static submitAddFleetScreenFormRequest(String participantName, String mobile, String email) {
    return {PARTICIPANT_NAME: participantName, MOBILE: mobile, EMAIL: email};
  }

  static submitSamhitaFormRequest(
    name,
    emailId,
    phoneNumber,
  ) {
    return {
      NAME: name,
      EMAIL_ID: emailId,
      MOBILE_NO: phoneNumber,
    };
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

  static getVerifySamhitaOtpRequest(String mobile, String otp, samhitaId) {
    return {MOBILE: mobile, OTP: otp, SAMHITA_ID: samhitaId,};
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
