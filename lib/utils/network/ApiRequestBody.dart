class ApiRequestBody {
  static getLoginRequest(String email, password) {
    return {"email": email, "password": password};
  }

  static getSignUpRequest(String email, password) {
    return {"email": email, "password": password};
  }
}
