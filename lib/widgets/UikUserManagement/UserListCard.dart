import 'package:flutter/material.dart';
import 'package:lokal/widgets/UikAvatar/uikAvatar.dart';

class UserListCard extends StatelessWidget {
  final userName;
  final location;
  const UserListCard({super.key, 
    this.userName = "Natalie Dormer",
    this.location = "Toronto, Canada",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffE5E5E5),
        body: Center(
          child: Container(
            color: Colors.white,
            width: 1121,
            height: 85,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      UikAvatar(
                        child: Image.asset(
                          "assets/images/Avatar.png",
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              userName,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff3A3C40),
                              ),
                            ),
                            Text(
                              location,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xff82868C),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 102,
                        height: 25,
                        padding: const EdgeInsets.only(top: 4.5),
                        margin: const EdgeInsets.only(left: 146),
                        decoration: BoxDecoration(
                          color: const Color(0xffFEE440),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "UI Designer",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 123),
                        child: const Text("Tesla",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 211),
                        child: const Text("Project X",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 168),
                        child: const Text("Yes",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
