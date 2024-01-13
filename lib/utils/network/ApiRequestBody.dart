import 'dart:io';

import '../../constants/json_constants.dart';

class ApiRequestBody {
  static getLoginRequest(String email, password, userType) {
    return {EMAIL: email, PASSWORD: password, USER_TYPE: userType};
  }

  static sendQusetionAnswers(
      int userid, int serviceId, Map<String, String> answermap) {
    return {USERID: userid, SERVICE_ID: serviceId, ANSWER_MAP: answermap};
  }

  static getuploaddocumentsid(String type, File file) async {
    return {FILE: file, USE_CASE: type};
  }

  static updateLatlong(double lat, double long) {
    return {LATITUDE: lat, LONGITUDE: long};
  }

  static getPersonalJobDetail(
      String name, String date, String mob, String loc, String gender) {
    return {
      FIRST_NAME: name,
      dob: date,
      MOBILE_NO: mob,
      LOCATION: loc,
      GENDER: gender
    };
  }

  static serviceId(String service) {
    return {SERVICE_ID: service};
  }

  static getPersonalDetail(String name, String date, double lat, double long) {
    return {NAME: name, dob: date, LATITUDE: lat, LONGITUDE: long};
  }

  static getOtherDetail(String education, workex, bool relocate) {
    return {EDUCATION: education, WORKEX: workex, RELOCATE: relocate};
  }

  static getUploadDocument(int gst, aadharf, aadharb, pan) {
    return {GST: gst, AADHARF: aadharf, AADHARB: aadharb, PAN: pan};
  }

  static getLoginAsPhoneRequest(String phoneNo) {
    return {PHONE_NUMBER: phoneNo};
  }

  static getSignUpRequest(String email, password, userType, phoneNo) {
    return {
      EMAIL: email,
      PASSWORD: password,
      USER_TYPE: userType,
      PHONE_NUMBER: phoneNo
    };
  }

  static getOptinRequest(String serviceId) {
    return {SERVICE_ID: serviceId};
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
      participantName, mobile, samhitaId) {
    return {
      PARTICIPANT_NAME: participantName,
      MOBILE: mobile,
      SAMHITA_ID: samhitaId,
    };
  }

  static submitUserServiceCreateCustomerFormRequest(
    name,
    phoneNumber,
    age,
    email,
    stateCode,
    districtCode,
    blockCode,
    pinCode,
    employmentType,
  ) {
    return {
      USERID: "98",
      // ignore: equal_keys_in_map
      SERVICE_ID: "134",
      NAME: name,
      PHONE_NUMBER: phoneNumber,
      AGE: age,
      EMAIL: email,
      STATE_CODE: stateCode,
      DISTRICT_CODE: districtCode,
      BLOCK_CODE: blockCode,
      PINCODE: pinCode,
      EMPLOYMENT_TYPE: employmentType,
      ISVERIFIED: "false",
      DELIVERY_STATUS: "IN_PROGRESS",
    };
  }

  static submitExtraPayOptInRequest(
    name,
    mobile,
    city,
    region,
    state,
    aadhar,
    pan,
  ) {
    return {
      NAME: name,
      MOBILE: mobile,
      AADHAR: aadhar,
      PAN: pan,
      LOCATION: {
        CITY: city,
        REGION: region,
        STATE: state,
      }
    };
  }

  static getVerifyAddAgentOtpRequest(
      String mobile, String otp, String partnerId) {
    return {MOBILE: mobile, OTP: otp, PARTNERID: partnerId};
  }

  static submitAddAgentScreenFormRequest(
      String name, String mobile, String partnerId, String email) {
    return {NAME: name, MOBILE: mobile, PARTNERID: partnerId, EMAIL: email};
  }

  static submitAddPartnerAgentRequest(
      String partnerId, String name, String mobile, String email) {
    return {
      PARTNER_ID: partnerId,
      "agentData": {
        FIRST_NAME: name,
        LAST_NAME_C: "",
        PHONE_NUMBER: mobile,
        EMAIL: email,
        LATITUDE: "40.71277600",
        LONGITUDE: "-74.00597400",
        GENDER: "MALE",
        DISTRICT: "DELHI",
        STATE: "DELHI",
        BLOCK: "DELHI",
        TAX_VAT: "12345",
        USER_TYPE: "AGENT"
      }
    };
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
    return {
      MOBILE: mobile,
      OTP: otp,
      SAMHITA_ID: samhitaId,
    };
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
