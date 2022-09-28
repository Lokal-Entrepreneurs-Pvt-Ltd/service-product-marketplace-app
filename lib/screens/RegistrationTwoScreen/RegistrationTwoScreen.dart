import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:login/screens/Membership/MembershipScreen.dart';
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String  dropdownvalue = "item1";
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  @override
  Widget build(BuildContext context) {


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
                    "Address*",
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
                          margin:EdgeInsets.fromLTRB(0, 16 , 0,4),
                          height: 64,
                          width: 343,
                          padding:EdgeInsets.fromLTRB(16,9.5,16, 0),
                          decoration: BoxDecoration(
                            color: HexColor("#F5F5F5"),
                            borderRadius:BorderRadius.all(Radius.circular(8)) ,
                          ),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("State*",
                                  style: TextStyle(
                                    color: HexColor("#9E9E9E"),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  ),
                                  Container(
                                    height:24,
                                    width: 280,
                                    child: DropdownButton(
                                      iconSize: 0,
                                      underline: SizedBox(),
                                      hint: Text("Select State",
                                      style: TextStyle(
                                          fontSize:16,
                                          fontWeight:FontWeight.w400,
                                          color: HexColor("#9E9E9E")
                                      ),
                                      ),
                                      items: items.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items,
                                          style: TextStyle(
                                            fontSize:14,
                                            fontWeight:FontWeight.w400,
                                            color: HexColor("#9E9E9E")
                                          ),),
                                        );
                                      }).toList(),
                                      onChanged:(String? newValue) {
                                         setState(() {
                                                 dropdownvalue = newValue!;
                                                 print(dropdownvalue);
                                         });},
                                    ),
                                  )
                                ],
                              ),
                              Icon(Icons.chevron_right)
                            ],
                          ),
                        ),
                        Container(
                          margin:EdgeInsets.fromLTRB(0, 16 , 0,4),
                          height: 64,
                          width: 343,
                          padding:EdgeInsets.fromLTRB(16,9.5,16, 0),
                          decoration: BoxDecoration(
                            color: HexColor("#F5F5F5"),
                            borderRadius:BorderRadius.all(Radius.circular(8)) ,
                          ),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("District*",
                                    style: TextStyle(
                                      color: HexColor("#9E9E9E"),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Container(
                                    height:24,
                                    width: 280,
                                    child: DropdownButton(
                                      iconSize: 0,
                                      underline: SizedBox(),
                                      hint: Text("Select District",
                                        style: TextStyle(
                                            fontSize:16,
                                            fontWeight:FontWeight.w400,
                                            color: HexColor("#9E9E9E")
                                        ),
                                      ),
                                      items: items.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items,
                                            style: TextStyle(
                                                fontSize:14,
                                                fontWeight:FontWeight.w400,
                                                color: HexColor("#9E9E9E")
                                            ),),
                                        );
                                      }).toList(),
                                      onChanged:(String? newValue) {
                                        setState(() {
                                          dropdownvalue = newValue!;
                                          print(dropdownvalue);
                                        });},
                                    ),
                                  )
                                ],
                              ),
                              Icon(Icons.chevron_right)
                            ],
                          ),
                        ),
                        Container(
                          margin:EdgeInsets.fromLTRB(0, 16 , 0,4),
                          height: 64,
                          width: 343,
                          padding:EdgeInsets.fromLTRB(16,9.5,16, 0),
                          decoration: BoxDecoration(
                            color: HexColor("#F5F5F5"),
                            borderRadius:BorderRadius.all(Radius.circular(8)) ,
                          ),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Block*",
                                    style: TextStyle(
                                      color: HexColor("#9E9E9E"),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Container(
                                    height:24,
                                    width: 280,
                                    child: DropdownButton(
                                      iconSize: 0,
                                      underline: SizedBox(),
                                      hint: Text("Select Block",
                                        style: TextStyle(
                                            fontSize:16,
                                            fontWeight:FontWeight.w400,
                                            color: HexColor("#9E9E9E")
                                        ),
                                      ),
                                      items: items.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items,
                                            style: TextStyle(
                                                fontSize:14,
                                                fontWeight:FontWeight.w400,
                                                color: HexColor("#9E9E9E")
                                            ),),
                                        );
                                      }).toList(),
                                      onChanged:(String? newValue) {
                                        setState(() {
                                          dropdownvalue = newValue!;
                                          print(dropdownvalue);
                                        });},
                                    ),
                                  )
                                ],
                              ),
                              Icon(Icons.chevron_right)
                            ],
                          ),
                        ),
                        Container(
                          margin:EdgeInsets.fromLTRB(0, 16 , 0,4),
                          height: 64,
                          width: 343,
                          padding:EdgeInsets.fromLTRB(16,9.5,16, 0),
                          decoration: BoxDecoration(
                            color: HexColor("#F5F5F5"),
                            borderRadius:BorderRadius.all(Radius.circular(8)) ,
                          ),
                          child: Row(
                            children: [
                              Container(
                                height:24,
                                width: 280,
                                child: DropdownButton(
                                  iconSize: 0,
                                  underline: SizedBox(),
                                  hint: Text("PINCODE",
                                    style: TextStyle(
                                        fontSize:16,
                                        fontWeight:FontWeight.w400,
                                        color: HexColor("#9E9E9E")
                                    ),
                                  ),
                                  items: items.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items,
                                        style: TextStyle(
                                            fontSize:14,
                                            fontWeight:FontWeight.w400,
                                            color: HexColor("#9E9E9E")
                                        ),),
                                    );
                                  }).toList(),
                                  onChanged:(String? newValue) {
                                    setState(() {
                                      dropdownvalue = newValue!;
                                      print(dropdownvalue);
                                    });},
                                ),
                              ),
                              Icon(Icons.chevron_right)
                            ],
                          ),
                        ),
                        SizedBox(height: 14,),
                        Container(
                          height: 64,
                          width: 343,
                          child:ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder:(context)=>MembershipPlan()));
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
