import "package:flutter/material.dart";

class AddressCard extends StatelessWidget {
  const AddressCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 653,
          height: 220,
          child: Card(
            elevation: 10,
            shadowColor: const Color.fromRGBO(40, 41, 61, 0.08),
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          left: 30,
                          top: 26,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: const Text(
                                "Address",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF212121),
                                ),
                              ),
                            ),
                            Container(
                              width: 250,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(
                                  color: Colors.grey.shade500,
                                  width: 2.0,
                                ),
                              ),
                              child: const TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  // fillColor: Color(0xFFF5F5F5),
                                  // filled: true,
                                  // labelText: 'Enter Name',
                                  //  hintText: 'Enter Your Name',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          left: 30,
                          top: 26,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: const Text(
                                "Town/City",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF212121),
                                ),
                              ),
                            ),
                            Container(
                              width: 250,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(
                                  color: Colors.grey.shade500,
                                  width: 2.0,
                                ),
                              ),
                              child: const TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  // fillColor: Color(0xFFF5F5F5),
                                  // filled: true,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        left: 30,
                        top: 26,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              bottom: 10,
                            ),
                            child: const Text(
                              "Address",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF212121),
                              ),
                            ),
                          ),
                          Container(
                            width: 250,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                color: Colors.grey.shade500,
                                width: 2.0,
                              ),
                            ),
                            child: const TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                // fillColor: Color(0xFFF5F5F5),
                                // filled: true,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
