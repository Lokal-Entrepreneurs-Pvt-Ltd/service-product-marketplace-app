import 'package:flutter/material.dart';
import 'package:lokal/constants/dimens.dart';
import '../../Widgets/UikButton/UikButton.dart';
import '../../Widgets/UikTextField/UikTextField.dart';
import '../../constants/json_constants.dart';
import '../../constants/strings.dart';
import '../../pages/UikBottomNavigationBar.dart';
import '../../screen_routes.dart';
import '../../utils/UiUtils/UiUtils.dart';
import '../../utils/network/ApiRepository.dart';
import '../../utils/network/ApiRequestBody.dart';
import '../../utils/storage/preference_constants.dart';
import '../../utils/storage/user_data_handler.dart';
import '../signUp/signup_screen.dart';

class NewOnboardingScreen extends StatefulWidget {
  final String? selectedUserType;

  const NewOnboardingScreen({super.key, this.selectedUserType});

  @override
  _NewOnboardingScreenState createState() => _NewOnboardingScreenState();
}

class _NewOnboardingScreenState extends State<NewOnboardingScreen>
    with SingleTickerProviderStateMixin {
  List<String> userTypes = [CUSTOMER, PARTNER, AGENT];
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

  String selectedUserType = CUSTOMER;

  void initialize() async {
    emailController.text = UserDataHandler.getUserEmail();
    //passwordController.text = await UserDataHandler.getUserPassword();
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 62.0,
                  ),
                  child: Image.asset(
                    "assets/images/Login1.png",
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 292),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const SignupScreen(), 
                        ),
                      );
                    },
                    child: const Text(
                      REGISTER,
                      style: TextStyle(
                          color: Color(0XFF3F51B5),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(
                  height: DIMEN_35,
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(DIMEN_20),
                        topRight: Radius.circular(DIMEN_20),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: DIMEN_20,
                        ),
                        Container(
                          height: DIMEN_52,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.circular(DIMEN_24),
                          ),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceAround, // Equal spacing
                            children: userTypes.map((type) {
                              bool isSelected = type == selectedUserType;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedUserType = type;
                                  });
                                },
                                child: Container(
                                  height: DIMEN_43,
                                  width: DIMEN_108,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Colors.white
                                        : null, // No background for unselected items
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Text(
                                    type,
                                    style: TextStyle(
                                      color: isSelected
                                          ? const Color(0xFF212121)
                                          : const Color(
                                              0xFF9E9E9E), // Green text for unselected items
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(
                          height: DIMEN_25,
                        ),
                        MyTextField(
                          labelText: BTS_EMAIL,
                          width: DIMEN_343,
                          height: DIMEN_64,
                          Controller: emailController,
                          error: errorEmail,
                          description: descEmail,
                        ),
                        MyTextField(
                          labelText: BTS_PASSWORD,
                          width: DIMEN_343,
                          height: DIMEN_64,
                          Controller: passwordController,
                          error: errorPassword,
                          isPassword: true,
                          description: descPassword,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: DIMEN_16,
                          ),
                          child: UikButton(
                            text: LOGIN,
                            backgroundColor: const Color(0xffFEE440),
                            onClick: () async {
                              setState(() {
                                isLoading = true;
                              });
                              if (UiUtils.isEmailValid(emailController.text) &&
                                  passwordController.text.length >= 6) {
                                final response =
                                    await ApiRepository.getLoginScreen(
                                        ApiRequestBody.getLoginRequest(
                                            emailController.text,
                                            passwordController.text,
                                            selectedUserType));
                                if (response.isSuccess!) {
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
                                          const UikBottomNavigationBar(),
                                    ),
                                    ModalRoute.withName(
                                        ScreenRoutes.loginScreen),
                                  );
                                } else {
                                  UiUtils.showToast(response.error![MESSAGE]);
                                }
                              }

                              if (UiUtils.isEmailValid(emailController.text)) {
                                errorEmail = false;
                                descEmail = '';
                              } else {
                                errorEmail = true;
                                descEmail = VALID_EMAIL;
                              }

                              if (passwordController.text.length >= 6) {
                                errorPassword = false;
                                descPassword = '';
                              } else {
                                errorPassword = true;
                                descPassword = PASSWORD_LENGTH;
                              }

                              setState(() {
                                isLoading = false;
                              });
                            },
                          ),
                        ),
                        TextButton(
                          onPressed: () =>
                              UiUtils.launchURL(FORGET_PASSWORD_URL),
                          child: const Text(
                            FORGET_PASSWORD,
                            style: TextStyle(
                              color: Color(0xFF9E9E9E),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
