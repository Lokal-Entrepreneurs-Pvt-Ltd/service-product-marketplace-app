
import 'package:flutter/material.dart';



class Cancel extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return   Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                              bottom: 20, left: 20, right: 20),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 234, 228, 228))),
                            onPressed: () {},
                            child: Container(
                              padding:
                                  const EdgeInsets.only(bottom: 10, top: 10),
                              child: const Text("Cancel",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                        );
  }
}