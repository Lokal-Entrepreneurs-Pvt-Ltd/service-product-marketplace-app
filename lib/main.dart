import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              toolbarHeight: 158,
              title: const Text('bag',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.bold

                      // height: 42,
                      )),
              backgroundColor: Colors.white,
              elevation: 0.0,
              titleSpacing: 20.0,
            ),
            body: Container(
              margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  SizedBox(height: 60),
                  Image.asset('assets/images/surprised.jpg', fit: BoxFit.cover),
                  
                  Text('your bag is empty',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,


                        // height: 42,
                      )),
                  Text(
                      'items remain in your bag for 1 hour, and the they\'re moved to your saved items',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        // fontWeight: FontWeight.bold

                        // height: 42,
                      )),
                  const SizedBox(
                    height: 100,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Start shopping',
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      primary: Colors.yellow,
                      onPrimary: Colors.black,
                      minimumSize: Size(363.0, 64.0),
                      // padding: EdgeInsets.only(bottom: 10.0),
                    ),
                  ),
                  const SizedBox(
                    height: 0,
                  )
                ],
              ),
            )));
  }
}
