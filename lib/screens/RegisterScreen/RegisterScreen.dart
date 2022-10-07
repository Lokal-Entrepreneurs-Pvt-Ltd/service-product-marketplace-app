import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:login/screens/Otp/OtpScreen.dart';



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
              icon: Icon(
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
                child: Text(
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
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Join Lokal",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "to change your life",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Personal Details",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: HexColor("#9E9E9E")),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8,),
                        Container(
                          margin:EdgeInsets.fromLTRB(0, 16 , 0, 0),
                          height: 64,
                          width: 343,
                          padding:EdgeInsets.fromLTRB(16, 0, 16, 0),
                          decoration: BoxDecoration(
                            color: HexColor("#F5F5F5"),
                            borderRadius:BorderRadius.all(Radius.circular(8)) ,
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "Name (as Per Aadhaar)*",
                              labelStyle:TextStyle(
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
                          margin:EdgeInsets.fromLTRB(0, 16 , 0, 0),
                          height: 64,
                          width: 343,
                          padding:EdgeInsets.fromLTRB(16, 0, 16, 0),
                          decoration: BoxDecoration(
                            color: HexColor("#F5F5F5"),
                            borderRadius:BorderRadius.all(Radius.circular(8)) ,
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              icon:Icon(Icons.flag),
                              border: InputBorder.none,
                              labelText: "Phone number*",
                              labelStyle:TextStyle(
                                color: HexColor("#9E9E9E"),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            controller:mobileController,
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                        Container(
                          margin:EdgeInsets.fromLTRB(0, 16, 0, 16),
                          height: 64,
                          width: 343,
                          padding:EdgeInsets.fromLTRB(16, 0, 16, 0),
                          decoration: BoxDecoration(
                            color: HexColor("#F5F5F5"),
                            borderRadius:BorderRadius.all(Radius.circular(8)) ,
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "Email*",
                              labelStyle:TextStyle(
                                color: HexColor("#9E9E9E"),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        Container(
                          height: 64,
                          width: 343,
                          child:ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder:(context)=>OtpScreen(mobileController.text)));
                            },
                            child: Text(
                              "Continue",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: HexColor("#212121")),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                HexColor("#FEE440"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
