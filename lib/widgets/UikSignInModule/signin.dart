import "package:flutter/material.dart";

import '../UikAvatar/UikAvatar.dart';
import '../UikRadioButton/radio.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 552,
        height: 608,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.white,
          elevation: 10,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 48),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Sign In",
                      style: TextStyle(
                        color: Color(0xFF212121),
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 48),
                child: Row(
                  children: [
                    Container(
                      width: 90,
                      child: Divider(
                        color: Colors.blue,
                        thickness: 4,
                      ),
                    ),
                    SizedBox(width: 16),
                    Container(
                      child: Text(
                        "Sign in with",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 48),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          UikAvatar(
                            shape: UikAvatarShape.circle,
                            size: UikSize.SMALL,
                            backgroundImage: NetworkImage(
                                "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                          ),
                          SizedBox(width: 12.93),
                          Container(
                            child: Text(
                              "Sign in with Google",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: Color(0xFF212121),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 50),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          UikAvatar(
                            shape: UikAvatarShape.circle,
                            size: UikSize.SMALL,
                            backgroundImage: NetworkImage(
                                "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                          ),
                          SizedBox(width: 12.93),
                          Container(
                            child: Text(
                              "Sign in with Facebook",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: Color(0xFF212121),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 32),
                child: Row(
                  children: [
                    Container(
                      width: 195,
                      child: Divider(
                        color: Color(0xFFBDBDBD),
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      child: Text(
                        "Or",
                        style: TextStyle(
                          color: Color(0xFFBDBDBD),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      width: 195,
                      child: Divider(
                        color: Color(0xFFBDBDBD),
                      ),
                    ),
                  ],
                ),
              ),

              //Name and password section........................

              Container(
                child: Row(
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              bottom: 9,
                            ),
                            child: Text(
                              "Name",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            width: 200,
                            // height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1.0,
                              ),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Color(0xFFF5F5F5),
                                filled: true,
                                // labelText: 'Enter Name',
                                //  hintText: 'Enter Your Name',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              bottom: 9,
                            ),
                            child: Text(
                              "Password",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            width: 200,
                            // height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1.0,
                              ),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Color(0xFFF5F5F5),
                                filled: true,
                                // labelText: 'Enter Name',
                                //  hintText: 'Enter Your Name',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //Radio and forget password
              Container(
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: RadioButton(),
                    ),
                    // Container(
                    //   child: Text("remember me"),
                    // ),
                    // Container(
                    //   child: GestureDetector(
                    //     child: Text(
                    //       "Forget Password?",
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
