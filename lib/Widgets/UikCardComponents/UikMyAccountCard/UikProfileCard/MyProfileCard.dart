import 'package:flutter/material.dart';
// 
import '../../../../widgets/UikAvatar/uikAvatar.dart';

class MyProfileCard extends StatelessWidget {
  const MyProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              Container(
                width: 190,
                height: 42,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 42),
                child: const Text(
                  "Profile Card",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 581,
                width: 218,
                // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                child: Card(
                  child: Column(
                    children: [
                      Container(
                        width: 62,
                        height: 62,
                        margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: const UikAvatar(
                          backgroundColor: Colors.purple,
                          radius: 20,
                        ),
                      ),
                      Container(
                        width: 81,
                        height: 17,
                        margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                        child: const Center(
                          child: Text(
                            "Tom Cruise",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 67,
                        height: 12,
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: const Center(
                          child: Text(
                            "Ui Designer",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        color: Color(0xFFBABFC5),
                        height: 1,
                      ),
                      SizedBox(
                        width: 218,
                        height: 231,
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          children: [
                            const ListTile(
                              leading: SizedBox(
                                width: 82,
                                height: 15,
                                child: Text(
                                  "Shared Files",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              trailing: SizedBox(
                                width: 33,
                                height: 12,
                                child: Text(
                                  "See All",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            for (int i = 0; i < 5; i++) ...[
                              Container(
                                height: 50,
                                width: 150,
                                margin: const EdgeInsets.only(top: 0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 26,
                                          height: 20,
                                          margin:
                                              const EdgeInsets.fromLTRB(12, 5, 9, 0),
                                          child: const Icon(
                                            Icons.folder_outlined,
                                            color: Color(0xFF9E9E9E),
                                          ),
                                        ),
                                        const Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: 71,
                                              height: 12,
                                              child: Text(
                                                "Reference Zip",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 71,
                                              height: 12,
                                              child: Text(
                                                "Oct 21,2021",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF9E9E9E),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Column(
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              width: 29,
                                              height: 19,
                                              margin:
                                                  const EdgeInsets.only(right: 10),
                                              child: const Text(
                                                "1.8MB",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF9E9E9E),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const Divider(
                        height: 1,
                      ),
                      SizedBox(
                        width: 218,
                        height: 165,
                        // decoration: BoxDecoration(
                        //     border: Border.all(color: Colors.red)),
                        child: ListView(
                          controller: ScrollController(),
                          scrollDirection: Axis.vertical,
                          children: [
                            const ListTile(
                              leading: SizedBox(
                                width: 82,
                                height: 16,
                                child: Text(
                                  "Shared Links",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              trailing: SizedBox(
                                width: 33,
                                height: 12,
                                child: Text(
                                  "See All",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            for (int i = 0; i < 5; i++) ...[
                              Container(
                                height: 50,
                                width: 150,
                                margin: const EdgeInsets.only(top: 0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const SizedBox(
                                              width: 38,
                                              height: 12,
                                              child: Text(
                                                "Dribble",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            Container(
                                              width: 58,
                                              height: 12,
                                              margin: const EdgeInsets.only(left: 20),
                                              child: const Text(
                                                "Oct 21,2021",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF9E9E9E),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Column(
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              width: 29,
                                              height: 19,
                                              margin:
                                                  const EdgeInsets.only(right: 10),
                                              child: const Text(
                                                "1.8MB",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF9E9E9E),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
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



















// ListView.builder(
//                           controller: ScrollController(),
//                           itemBuilder: (context, index) {
//                             return ListTile(
//                               dense: true,
//                               leading: Container(
//                                 margin: EdgeInsets.all(0),
//                                 decoration: BoxDecoration(
//                                     border: Border.all(color: Colors.green)),
//                                 child: Icon(Icons.folder_zip),
//                               ),
//                               title: Text(
//                                 "Reference Zip",
//                                 style: TextStyle(
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.w600,
//                                   color: Color(0xFF9E9E9E),
//                                 ),
//                               ),
//                               subtitle: Text("Oct 21,2021"),
//                               trailing: Column(
//                                 children: [
//                                   SizedBox(
//                                     height: 5,
//                                   ),
//                                   Text(
//                                     "1.0Mb",
//                                     style: TextStyle(
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.w500,
//                                       color: Color(0xFF9E9E9E),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                           itemCount: 15,
//                         ),