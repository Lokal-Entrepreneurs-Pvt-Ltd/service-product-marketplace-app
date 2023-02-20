class ApiRequestBody {
  static getLoginRequest(String email, password) {
    return {"email": email, "password": password};
  }

  static getSignUpRequest(String email, password) {
    return {"email": email, "password": password};
  }

  static getUpdateCartRequest(String skuId,String action, String cartId) {
   return {
      "skuId": skuId,
      "action": action,
      "cartId": cartId,
    };
  }

  static getSaveDetailsRequest(String name, String email, String gst, String dob, String phone) {
    return {
      "name": name,
      "email": email,
      "taxvat":gst,
      "dob": dob,
      "phone": phone,
    };
  }

  static getSendOtpRequest(String phoneNumber) {
    return {"phoneNumber": phoneNumber};
  }




}
