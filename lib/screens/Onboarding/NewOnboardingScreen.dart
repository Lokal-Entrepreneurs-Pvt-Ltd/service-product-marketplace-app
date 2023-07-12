import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Widgets/UikButton/UikButton.dart';
import '../../Widgets/UikNavbar/UikNavbar.dart';
import '../../Widgets/UikTextField/UikTextField.dart';
import '../../constants/json_constants.dart';
import '../../constants/strings.dart';
import '../../pages/UikBottomNavigationBar.dart';
import '../../screen_routes.dart';
import '../../utils/NavigationUtils.dart';
import '../../utils/UiUtils/UiUtils.dart';
import '../../utils/network/ApiRepository.dart';
import '../../utils/network/ApiRequestBody.dart';
import '../../utils/storage/preference_constants.dart';
import '../../utils/storage/user_data_handler.dart';

class NewOnboardingScreen extends StatefulWidget {
  final String? selectedUserType;

  NewOnboardingScreen({this.selectedUserType});

  @override
  _NewOnboardingScreenState createState() => _NewOnboardingScreenState();
}

class _NewOnboardingScreenState extends State<NewOnboardingScreen>
    with SingleTickerProviderStateMixin {
  bool isLoginSelected = true;
  int selectedIndex = 0;
  List<String> userTypes = ['CUSTOMER', 'PARTNER', 'FLEET'];
  late TabController _tabController;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var errorEmail = false;
  var descEmail = "";

  var errorPassword = false;
  var descPassword = "";

  var errorConfirmPassword = false;
  var descConfirmPassword = "";

  var isAuthError = false;
  var authErrorCode = -1;
  var authErrorMessage = "";
  bool isLoading = false;
  void initialize() async {
    emailController.text = await UserDataHandler.getUserEmail();
    //passwordController.text = await UserDataHandler.getUserPassword();
  }

  @override
  void initState() {
    super.initState();
    initialize();
    selectedIndex = userTypes.indexOf(widget.selectedUserType ?? 'User');
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? selectedUserType = widget.selectedUserType;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: const Color(0xffFEE440),
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Text(
                    ACCOUNT_TYPE,
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildUserTypeRectangle(0),
                      buildUserTypeRectangle(1),
                      buildUserTypeRectangle(2),
                    ],
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                isLoginSelected = true;
                              });
                              _tabController.animateTo(0);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: isLoginSelected
                                        ? Colors.black
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: Text(
                                'Login',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: isLoginSelected
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                isLoginSelected = false;
                              });
                              _tabController.animateTo(1);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: !isLoginSelected
                                        ? Colors.black
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: Text(
                                'Sign up',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: isLoginSelected
                                      ? Colors.grey
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 2,
              width: double.infinity,
              color: Colors.grey, // Color of the unselected tab view line
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.yellow),
                      )
                    : TabBarView(
                        controller: _tabController,
                        children: [
                          // Login Form
                          ListView(
                            children: [
                              UikNavbar(
                                size: "",
                                titleText: "welcome back!\nLogin to continue",
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              MyTextField(
                                labelText: "Email",
                                width: 343,
                                height: 64,
                                Controller: emailController,
                                error: errorEmail,
                                description: descEmail,
                              ),
                              MyTextField(
                                labelText: "Password",
                                width: 343,
                                height: 64,
                                Controller: passwordController,
                                error: errorPassword,
                                isPassword: true,
                                description: descPassword,
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 16,
                                ),
                                child: UikButton(
                                  text: "Log In",
                                  backgroundColor: const Color(0xffFEE440),
                                  onClick: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    selectedUserType = userTypes[selectedIndex];
                                    if (UiUtils.isEmailValid(
                                            emailController.text) &&
                                        passwordController.text.length >= 6) {
                                      print("Inside Email Validation!");
                                      final response =
                                          await ApiRepository.getLoginScreen(
                                              ApiRequestBody.getLoginRequest(
                                        emailController.text,
                                        passwordController.text,
                                        selectedUserType
                                      ));
                                      if (response.isSuccess!) {
                                        print("LOGINSCREEN----------------");
                                        UserDataHandler.saveUserToken(
                                            response.data[AUTH_TOKEN]);

                                        var customerData =
                                            response.data[CUSTOMER_DATA];
                                        if (customerData != null) {
                                          UserDataHandler.saveCustomerData(
                                              customerData);
                                        }

                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UikBottomNavigationBar(),
                                          ),
                                          ModalRoute.withName(
                                              ScreenRoutes.loginScreen),
                                        );
                                      } else {
                                        UiUtils.showToast(
                                            response.error![MESSAGE]);
                                      }
                                    }

                                    if (UiUtils.isEmailValid(
                                        emailController.text)) {
                                      errorEmail = false;
                                      descEmail = '';
                                    } else {
                                      errorEmail = true;
                                      descEmail = "Please enter a valid email";
                                    }

                                    if (passwordController.text.length >= 6) {
                                      errorPassword = false;
                                      descPassword = '';
                                    } else {
                                      errorPassword = true;
                                      descPassword =
                                          "Password must be at least 6 characters long";
                                    }

                                    setState(() {
                                      isLoading = false;
                                    });
                                  },
                                ),
                              ),
                              //...............................................Forget Password...............................
                              TextButton(
                                onPressed: () =>
                                    UiUtils.launchURL(FORGET_PASSWORD_URL),
                                child: Text(FORGET_PASSWORD),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                          // Sign Up Form
                          ListView(
                            children: [
                              UikNavbar(
                                size: "",
                                titleText:
                                    "enter your email\naddress to signup",
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              MyTextField(
                                labelText: "Email",
                                width: 343,
                                height: 64,
                                Controller: emailController,
                                error: errorEmail,
                                description: descEmail,
                              ),
                              MyTextField(
                                labelText: "Password",
                                width: 343,
                                height: 64,
                                Controller: passwordController,
                                error: errorPassword,
                                isPassword: true,
                                description: descPassword,
                              ),
                              MyTextField(
                                labelText: "Confirm Password",
                                width: 343,
                                height: 64,
                                Controller: confirmPasswordController,
                                error: errorConfirmPassword,
                                isPassword: true,
                                description: descConfirmPassword,
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 16,
                                ),
                                child: UikButton(
                                  text: "Sign Up",
                                  backgroundColor: const Color(0xffFEE440),
                                  onClick: () async {
                                    selectedUserType = userTypes[selectedIndex];
                                    print(
                                        'Selected User Type: $selectedUserType');
                                    if (UiUtils.isEmailValid(
                                            emailController.text) &&
                                        passwordController.text.length >= 6 &&
                                        confirmPasswordController.text ==
                                            passwordController.text) {
                                      NavigationUtils.showLoaderOnTop();
                                      final response =
                                          await ApiRepository.getSignUpScreen(
                                        ApiRequestBody.getSignUpRequest(
                                          emailController.text,
                                          passwordController.text,
                                          selectedUserType
                                        ),
                                      ).catchError((error) {
                                        NavigationUtils.pop();
                                      });

                                      NavigationUtils.pop();

                                      if (response.isSuccess!) {
                                        UserDataHandler.saveUserToken(
                                            response.data[AUTH_TOKEN]);

                                        var customerData =
                                            response.data[CUSTOMER_DATA];
                                        if (customerData != null) {
                                          UserDataHandler.saveCustomerData(
                                              customerData);
                                        }
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UikBottomNavigationBar(),
                                          ),
                                        );
                                      } else {
                                        UiUtils.showToast(
                                            response.error![MESSAGE]);
                                      }
                                    }

                                    if (UiUtils.isEmailValid(
                                        emailController.text)) {
                                      errorEmail = false;
                                      descEmail = '';
                                    } else {
                                      errorEmail = true;
                                      descEmail = "Please enter a valid email";
                                    }

                                 if (passwordController.text.length >= 6) {
                                      errorPassword = false;
                                      descPassword = '';
                                    } else {
                                      errorPassword = true;
                                      descPassword =
                                          "Password must be at least 6 characters long";
                                    }

                                    if (confirmPasswordController.text !=
                                        passwordController.text) {
                                      errorConfirmPassword = true;
                                      descConfirmPassword =
                                          "Passwords do not match";
                                    } else {
                                      errorConfirmPassword = false;
                                      descConfirmPassword = '';
                                    }

                                    setState(() {});
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildUserTypeRectangle(int index) {
    List<Widget> avatars = [
      GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Column(
          children: [
            Container(
              width: 90,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: index == selectedIndex ? Colors.black : Colors.grey,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    color: index == selectedIndex ? Colors.black : Colors.grey,
                  ),
                  SizedBox(height: 8),
                  Text(
                    CUSTOMER,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color:
                          index == selectedIndex ? Colors.black : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
      GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Column(
          children: [
            Container(
              width: 90,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: index == selectedIndex ? Colors.black : Colors.grey,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.business,
                    color: index == selectedIndex ? Colors.black : Colors.grey,
                  ),
                  SizedBox(height: 8),
                  Text(
                    PARTNER,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color:
                          index == selectedIndex ? Colors.black : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
      GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Column(
          children: [
            Container(
              width: 90,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: index == selectedIndex ? Colors.black : Colors.grey,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.local_shipping,
                    color: index == selectedIndex ? Colors.black : Colors.grey,
                  ),
                  SizedBox(height: 8),
                  Text(
                    AGENT,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color:
                          index == selectedIndex ? Colors.black : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    ];

    return avatars[index];
  }
}
