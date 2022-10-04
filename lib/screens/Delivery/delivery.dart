import 'package:flutter/material.dart';

import '../../Widgets/UikDelivery/cancel.dart';
import '../../Widgets/UikDelivery/delivery.dart';


void main() {
  runApp( DeliveryScreen());
}

class DeliveryScreen extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool srujan = false;
  bool siri = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          Container(
              width: double.infinity,
              height: 300,
              child: Card(
                  color: Colors.white,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Delivery(),
                        ListTile(
                          leading: Icon(
                            Icons.location_on_outlined,
                            color: Colors.black,
                          ),
                          title: Text('302 Bhaskar Mansion'),
                          subtitle: Text('2nd Fir Avenue Road,Kerala'),
                          trailing: CircleAvatar(
                            radius: 17,
                            backgroundColor: Colors.yellow,
                            child: Icon(
                              Icons.check_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.location_on_outlined,
                            color: Colors.black,
                          ),
                          title: Text('2, Moonstone Apts,65 E Linking Rd'),
                          subtitle: Text('Santacruz, Karnataka'),
                        ),
                        Cancel(),
                      ])))
        ]),
      ),
    );
  }
}
