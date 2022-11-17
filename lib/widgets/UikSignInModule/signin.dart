import "package:flutter/material.dart";

// import '../UikAvatar/UikAvatar.dart';
import 'package:login/widgets/UikAvatar/uikAvatar.dart';
import '../UikButton/UikButton.dart';
import '../UikRadioButton/radio.dart';
import '../UikSwitch/UikSwitch.dart';

class SignIn extends StatelessWidget {
  final val;
  final elevation;
  final eliminateDasher;
  final eliminateSubheading;

  SignIn({
    this.val = "signin",
    this.elevation = 10,
    this.eliminateDasher,
    this.eliminateSubheading,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: 450,
          //height: ,
          child: Card(
            shape: (elevation != 0)
                ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  )
                : null,
            color: Colors.white,
            elevation: elevation,
            child: Column(
              children: [
                Container(
                  margin: (eliminateSubheading == null)
                      ? EdgeInsets.fromLTRB(10, 15, 0, 48)
                      : EdgeInsets.fromLTRB(0, 15, 0, 48),
                  child: Row(
                    mainAxisAlignment: (eliminateSubheading == null)
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
                    children: [
                      Text(
                        (val == "signin") ? "Sign In" : "Sign Up",
                        style: TextStyle(
                          color: Color(0xFF212121),
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                (eliminateSubheading == null)
                    ? Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 48),
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
                                (val == "signin")
                                    ? "Sign in with"
                                    : "Sign up with",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 48),
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
                (eliminateDasher == null)
                    ? Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 32),
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
                      )
                    : Container(),

                //Name and password section........................

                Container(
                  margin: EdgeInsets.only(
                    bottom: 24,
                    left: 10,
                  ),
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
                                (val == 'signin') ? "Password" : "Email",
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

                //optional field only in signUp
                (val == "signup")
                    ? Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 33),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "Password",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 240),
                                  GestureDetector(
                                    child: Text(
                                      "Forget Password?",
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 420,
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
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 420,
                                    child: LinearProgressIndicator(
                                      value: 0.7,
                                      backgroundColor: Color(0xFFE0E0E0),
                                      color: Color(0xFFEF9A9A),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Not bad but you know you can do better",
                                    style: TextStyle(
                                      color: Color(0xFFEF9A9A),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(),

                //optional singup rows
                // Container(
                // width: 100,
                // height: 100,
                (val == "signup")
                    ? Container(
                        margin: EdgeInsets.only(left: 10, bottom: 44),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              child: RadioButton(borderRadius: 10),
                            ),
                            SizedBox(width: 8),
                            Text("I agree to"),
                            Text(
                              " terms & conditions",
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                // ),

                //Radio and forget password
                (val == "signin")
                    ? Container(
                        margin: EdgeInsets.only(
                          bottom: 24,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            UikSwitch(
                              activebackgroundColor: Color(0xFFFEF2A0),
                              activetopColor: Colors.yellow,
                              inactivebackgroundColor: Colors.grey.shade400,
                              inactivetopColor: Colors.yellow,
                            ),
                            Container(
                              child: Text(
                                "Remember Me",
                                style: TextStyle(
                                  color: Color(0xFF121625),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(width: 160),
                            Container(
                              child: GestureDetector(
                                child: Text(
                                  "Forget Password?",
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(),

                //button Sign in and SignUp button
                Container(
                  margin: EdgeInsets.only(
                    bottom: 21,
                    left: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      UikButton(
                        widthSize: 420,
                        text: (val == "signin") ? "Sign In" : "Sign Up",
                      ),
                    ],
                  ),
                ),

                //create an account (clickable text)
                (val == "signin")
                    ? Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Text(
                          "Create an account",
                          style: TextStyle(
                            color: Color(0xFF3F51B5),
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Do you already have an account?"),
                              Text(
                                " Log in",
                                style: TextStyle(
                                  color: Colors.blue,
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
