import 'package:flutter/material.dart';

// import '../../../widgets/UikAvatar/uikAvatar.dart';
import 'package:lokal/widgets/UikAvatar/uikAvatar.dart';

class MyAccountCard extends StatelessWidget {
  const MyAccountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          // color: Colors.blue,
          width: 307,
          height: 700,

          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                width: 281,
                height: 42,
                child: const Center(
                  child: Text(
                    "My Account Card",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 307,
                height: 518,
                child: Card(
                  // color: Colors.yellow,
                  // semanticContainer: true,
                  borderOnForeground: true,
                  child: Column(
                    children: [
                      Container(
                        width: 62,
                        height: 62,
                        margin: const EdgeInsets.fromLTRB(0, 30, 0, 7),
                        child: const UikAvatar(
                          backgroundColor: Colors.purple,
                          radius: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 75,
                        height: 17,
                        child: Center(
                          child: Text(
                            "Elon Musk",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Color(0xFF9E9E9E),
                            ),
                          ),
                        ),
                      ),

                      Container(
                        width: 61,
                        height: 11,
                        margin: const EdgeInsets.only(bottom: 20),
                        child: const Center(
                          child: Text(
                            "My Account",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF9E9E9E),
                            ),
                          ),
                        ),
                      ),

                      //Divider 1

                      const Divider(
                        height: 10,
                        color: Color(0xFFBDBDBD),
                      ),
                      // ListTile(
                      //   leading: Container(
                      //     width: 81,
                      //     height: 16,
                      //     child: Text(
                      //       "Online Now",
                      //       style: TextStyle(
                      //         fontSize: 13,
                      //         fontWeight: FontWeight.w600,
                      //         color: Color(0xFF9E9E9E),
                      //       ),
                      //     ),
                      //   ),
                      //   trailing: Container(
                      //     width: 29,
                      //     height: 19,
                      //     padding: EdgeInsets.fromLTRB(2, 9, 2, 9),
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.all(Radius.circular(20)),
                      //       color: Color(0xFFBDBDBD),
                      //     ),
                      //     // color: Colors.white),
                      //     child: Text(
                      //       "12",
                      //       style: TextStyle(color: Colors.red),
                      //     ),
                      //   ),
                      // ),
                      Container(
                        width: 307,
                        height: 30,
                        margin: const EdgeInsets.only(bottom: 15, top: 10),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            const SizedBox(
                              width: 81,
                              height: 16,
                              child: Text(
                                "Online now",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF9E9E9E),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              width: 29,
                              height: 19,
                              // color: Colors.grey,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xFFEDEDED),
                              ),
                              child: const Center(
                                child: Text(
                                  "12",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF9E9E9E),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        // decoration: BoxDecoration(
                        //   border: Border.all(color: Colors.black),
                        // ),
                        width: 306,
                        height: 32,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: const UikAvatar(
                                backgroundColor: Colors.red,
                                radius: 14,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                              child: const UikAvatar(
                                backgroundColor: Colors.red,
                                radius: 14,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                              child: const UikAvatar(
                                backgroundColor: Colors.red,
                                radius: 14,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                              child: const UikAvatar(
                                backgroundColor: Colors.red,
                                radius: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      // Divider 2
                      const Divider(
                        height: 20,
                        color: Color(0xFFBDBDBD),
                      ),
                      SizedBox(
                        height: 230,
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          children: [
                            const ListTile(
                              leading: Text(
                                "Recent Chats",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF9E9E9E),
                                ),
                              ),
                            ),
                            ListTile(
                              dense: true,
                              leading: Container(
                                margin: const EdgeInsets.all(0),
                                child: const UikAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 14,
                                ),
                              ),
                              title: const Text(
                                "Shubham Jacob",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF9E9E9E),
                                ),
                              ),
                              subtitle: const Text("Hi Our Deadline are.."),
                              trailing: const Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "11:30pm",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF9E9E9E),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              height: 1,
                            ),
                            ListTile(
                              dense: true,
                              leading: Container(
                                margin: const EdgeInsets.all(0),
                                child: const UikAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 14,
                                ),
                              ),
                              title: const Text(
                                "Shubham Jacob",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF9E9E9E),
                                ),
                              ),
                              subtitle: const Text("Hi Our Deadline are.."),
                              trailing: const Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "11:30pm",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF9E9E9E),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              height: 1,
                            ),
                            ListTile(
                              dense: true,
                              leading: Container(
                                margin: const EdgeInsets.all(0),
                                child: const UikAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 14,
                                ),
                              ),
                              title: const Text(
                                "Shubham Jacob",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF9E9E9E),
                                ),
                              ),
                              subtitle: const Text("Hi Our Deadline are.."),
                              trailing: const Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "11:30pm",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF9E9E9E),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              height: 1,
                            ),
                            ListTile(
                              dense: true,
                              leading: Container(
                                margin: const EdgeInsets.all(0),
                                child: const UikAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 14,
                                ),
                              ),
                              title: const Text(
                                "Shubham Jacob",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF9E9E9E),
                                ),
                              ),
                              subtitle: const Text("Hi Our Deadline are.."),
                              trailing: const Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "11:30pm",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF9E9E9E),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              height: 1,
                            ),
                            ListTile(
                              dense: true,
                              leading: Container(
                                margin: const EdgeInsets.all(0),
                                child: const UikAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 14,
                                ),
                              ),
                              title: const Text(
                                "Shubham Jacob",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF9E9E9E),
                                ),
                              ),
                              subtitle: const Text("Hi Our Deadline are.."),
                              trailing: const Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "11:30pm",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF9E9E9E),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
    );
  }
}
