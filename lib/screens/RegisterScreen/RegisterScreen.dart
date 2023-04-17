import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lokal/screens/Otp/OtpScreen.dart';

void main() {
  runApp(RegisterScreen());
}

class RegisterScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController mobileController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_outlined,
                color: Colors.black,
                size: 34,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              TextButton(
                child: const Text(
                  "Help",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                onPressed: () {},
              )
            ],
          ),
          body: Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Join Lokal",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Text(
                    "to change your life",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Personal Details",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: HexColor("#9E9E9E")),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                        height: 64,
                        width: 343,
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        decoration: BoxDecoration(
                          color: HexColor("#F5F5F5"),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "Name (as Per Aadhaar)*",
                            labelStyle: TextStyle(
                              color: HexColor("#9E9E9E"),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          controller: nameController,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                        height: 64,
                        width: 343,
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        decoration: BoxDecoration(
                          color: HexColor("#F5F5F5"),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            icon: const Icon(Icons.flag),
                            border: InputBorder.none,
                            labelText: "Phone number*",
                            labelStyle: TextStyle(
                              color: HexColor("#9E9E9E"),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          controller: mobileController,
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                        height: 64,
                        width: 343,
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        decoration: BoxDecoration(
                          color: HexColor("#F5F5F5"),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "Email*",
                            labelStyle: TextStyle(
                              color: HexColor("#9E9E9E"),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      SizedBox(
                        height: 64,
                        width: 343,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OtpScreen(
                                        mobileNumber: mobileController.text)));
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              HexColor("#FEE440"),
                            ),
                          ),
                          child: Text(
                            "Continue",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: HexColor("#212121")),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
