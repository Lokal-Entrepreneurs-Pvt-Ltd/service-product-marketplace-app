import 'package:flutter/material.dart';
import 'package:lokal/widgets/UikButton/UikButton.dart';

class NewUserInfo extends StatelessWidget {
  const NewUserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 671,
          height: 540,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color(0xffBABFC5),
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 27.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 292,
                      height: 45,
                      decoration: BoxDecoration(
                        //color: Color(0xffF5F5F5),
                        border: Border.all(color: const Color(0xffBDBDBD)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                            hintText: "Full Name",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 15)),
                      ),
                    ),
                    Container(
                      width: 292,
                      height: 45,
                      decoration: BoxDecoration(
                        //color: Color(0xffF5F5F5),
                        border: Border.all(color: const Color(0xffBDBDBD)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                            hintText: "Email Address",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 15)),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 292,
                      height: 45,
                      decoration: BoxDecoration(
                        //color: Color(0xffF5F5F5),
                        border: Border.all(color: const Color(0xffBDBDBD)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                            hintText: "Phone Number",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 15)),
                      ),
                    ),
                    Container(
                      width: 292,
                      height: 45,
                      decoration: BoxDecoration(
                        //color: Color(0xffF5F5F5),
                        border: Border.all(color: const Color(0xffBDBDBD)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                            hintText: "Country",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 15)),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 292,
                      height: 45,
                      decoration: BoxDecoration(
                        //color: Color(0xffF5F5F5),
                        border: Border.all(color: const Color(0xffBDBDBD)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                            hintText: "State/Region",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 15)),
                      ),
                    ),
                    Container(
                      width: 292,
                      height: 45,
                      decoration: BoxDecoration(
                        //color: Color(0xffF5F5F5),
                        border: Border.all(color: const Color(0xffBDBDBD)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                            hintText: "City",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 15)),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 292,
                      height: 45,
                      decoration: BoxDecoration(
                        //color: Color(0xffF5F5F5),
                        border: Border.all(color: const Color(0xffBDBDBD)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                            hintText: "Address",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 15)),
                      ),
                    ),
                    Container(
                      width: 292,
                      height: 45,
                      decoration: BoxDecoration(
                        //color: Color(0xffF5F5F5),
                        border: Border.all(color: const Color(0xffBDBDBD)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                            hintText: "Zip Code",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 15)),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 24.5),
                width: 611,
                height: 140,
                decoration: BoxDecoration(
                  //color: Color(0xffF5F5F5),
                  border: Border.all(color: const Color(0xffBDBDBD)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                      hintText: "About",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15)),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(517, 30, 30, 32),
                child: UikButton(
                    text: "Create User",
                    widthSize: 124,
                    heightSize: 38,
                    type: "primary",
                    stuck: true,
                    textWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }
}
