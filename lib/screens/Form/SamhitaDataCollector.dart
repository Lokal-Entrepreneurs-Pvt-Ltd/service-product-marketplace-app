import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/json_constants.dart';
import '../../utils/NavigationUtils.dart';
import '../../utils/UiUtils/UiUtils.dart';
import '../../utils/network/ApiRepository.dart';
import '../../utils/network/ApiRequestBody.dart';
import '../../utils/network/http/http_screen_client.dart';

class SamhitaDataCollector extends StatefulWidget {
  const SamhitaDataCollector({super.key});

  @override
  State<SamhitaDataCollector> createState() => _SamhitaDataCollectorState();
}

class _SamhitaDataCollectorState extends State<SamhitaDataCollector> {
  @override
  void initState() {
    super.initState();
    _fetchStates();
  }

  void _fetchStates() async {
    // NavigationUtils.showLoaderOnTop();
    final response = await ApiRepository.getStates(null);

    stateList = response.data["dataStore"]["stateList"]["textList"];
    stateCodeList = response.data["dataStore"]["stateList"]["actionList"];
    // NavigationUtils.pop();
    for (int i = 0; i < stateList.length; i++) {
      stateItems!.add(DropdownMenuItem(
        value: stateList[i]["text"],
        child: Text(stateList[i]["text"]),
      ));
    }
    // setState(() {});
  }

  void _fetchDistricts(String state) async {
    NavigationUtils.showLoaderOnTop();
    var stateCode = 0;
    for (int i = 0; i < stateCodeList.length; i++) {
      if (stateCodeList[i]["tap"]["values"]["stateName"] == state) {
        stateCode = int.parse(stateCodeList[i]["tap"]["data"]["value"]);
        break;
      }
    }
    final response = await ApiRepository.getDistricts({
      "stateCode": stateCode,
    });

    districtList = response.data["dataStore"]["districtsList"]["textList"];
    NavigationUtils.pop();
    for (int i = 0; i < districtList.length; i++) {
      districtItems!.add(DropdownMenuItem(
        value: districtList[i]["text"],
        child: Text(districtList[i]["text"]),
      ));
    }
    // setState(() {});
  }

  final _nameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _address1Controller = TextEditingController();
  final _address2Controller = TextEditingController();
  final _pincodeController = TextEditingController();
  final _cityController = TextEditingController();
  final _villageController = TextEditingController();
  final _aadharNumberController = TextEditingController();
  final _panNumberController = TextEditingController();
  final _ipIdController = TextEditingController();
  final _dobController = TextEditingController();
  final _onBoardingDateController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final DateTime _dateOfBirth = DateTime.now();
  final DateTime _onBoardingDate = DateTime.now();
  String? _selectedGender;
  String? _selectedState;
  String? _selectedDistrict;
  bool _phoneNumberValid = true;
  bool _emailValid = true;
  bool _nameRequired = true;
  final bool _lastNameRequired = true;
  final bool _onBoardingDateRequired = true;
  List<dynamic> stateList = [];
  List<dynamic> stateCodeList = [];
  List<DropdownMenuItem<String>>? stateItems = [
    const DropdownMenuItem(
      value: 'none',
      child: Text('None'),
    ),
  ];
  List<dynamic> districtList = [];
  List<DropdownMenuItem<String>>? districtItems = [
    const DropdownMenuItem(
      value: 'none',
      child: Text('None'),
    ),
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(left: 16, right: 16, top: 10),
          child: ListView(
            children: [
              Image.asset("assets/images/Samhita.png"),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Enter Your Details',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Name'),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  errorText: _nameRequired ? null : 'This is Required',
                ),
              ),
              const SizedBox(height: 16.0),
              // Text('Last Name'),
              // TextField(
              //   controller: _lastNameController,
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(),
              //     errorText: _lastNameRequired ? null : 'This is Required',
              //   ),
              // ),
              // SizedBox(height: 16.0),
              // Text('Middle Name'),
              // TextField(
              //   controller: _middleNameController,
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              // SizedBox(height: 16.0),
              // Text('IP Id'),
              // TextField(
              //   controller: _ipIdController,
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              // SizedBox(height: 16.0),
              // Text('Password'),
              // TextField(
              //   controller: _passwordController,
              //   obscureText: true,
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              // SizedBox(height: 16.0),
              const Text('Email'),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  errorText: _emailValid ? null : 'Please enter a valid email',
                ),
                onChanged: (value) {
                  if (!isEmailValid(value)) {
                    setState(() {
                      _emailValid = false;
                    });
                  } else {
                    setState(() {
                      _emailValid = true;
                    });
                  }
                },
              ),
              const SizedBox(height: 16.0),
              const Text('Phone Number'),
              TextField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  errorText: _phoneNumberValid
                      ? null
                      : 'Please enter a valid phone number starting with 7, 8, or 9',
                ),
                onChanged: (value) {
                  if (value.length < 10) {
                    setState(() {
                      _phoneNumberValid = false;
                    });
                  } else if (!RegExp(r'^[789]\d{9}$').hasMatch(value)) {
                    setState(() {
                      _phoneNumberValid = false;
                    });
                  } else {
                    setState(() {
                      _phoneNumberValid = true;
                    });
                  }
                },
              ),
              const SizedBox(height: 16.0),
              // Text('Date of Birth'),
              // TextField(
              //   controller: _dobController,
              //   readOnly: true,
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //   ),
              //   onTap: () async {
              //     final DateTime? date = await showDatePicker(
              //       context: context,
              //       initialDate: _dateOfBirth ?? DateTime.now(),
              //       firstDate: DateTime(1900),
              //       lastDate: DateTime.now(),
              //     );
              //     if (date != null) {
              //       setState(() {
              //         _dateOfBirth = date;
              //         _dobController.text =
              //             '${_dateOfBirth.day}/${_dateOfBirth.month}/${_dateOfBirth.year}';
              //       });
              //     }
              //   },
              // ),
              // SizedBox(height: 16.0),
              // Text('On boarding Date'),
              // TextField(
              //   controller: _onBoardingDateController,
              //   readOnly: true,
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(),
              //     errorText:
              //         _onBoardingDateRequired ? null : 'This is Required',
              //   ),
              //   onTap: () async {
              //     final DateTime? date = await showDatePicker(
              //       context: context,
              //       initialDate: _onBoardingDate ?? DateTime.now(),
              //       firstDate: DateTime(1900),
              //       lastDate: DateTime.now(),
              //     );
              //     if (date != null) {
              //       setState(() {
              //         _onBoardingDate = date;
              //         _onBoardingDateController.text =
              //             '${_onBoardingDate.day}/${_onBoardingDate.month}/${_onBoardingDate.year}';
              //       });
              //     }
              //   },
              // ),
              // SizedBox(height: 16.0),
              // Text('Gender'),
              // Container(
              //   height: 60,
              //   child: InputDecorator(
              //     decoration:
              //         const InputDecoration(border: OutlineInputBorder()),
              //     child: DropdownButtonHideUnderline(
              //       child: DropdownButton<String>(
              //         value: _selectedGender,
              //         isExpanded: true,
              //         icon: Icon(Icons.arrow_drop_down),
              //         onChanged: (value) {
              //           setState(() {
              //             _selectedGender = value!;
              //           });
              //         },
              //         items: const [
              //           DropdownMenuItem(
              //             value: 'male',
              //             child: Text('Male'),
              //           ),
              //           DropdownMenuItem(
              //             value: 'female',
              //             child: Text('Female'),
              //           ),
              //           DropdownMenuItem(
              //             value: 'other',
              //             child: Text('Other'),
              //           ),
              //           DropdownMenuItem(
              //             value: 'none',
              //             child: Text('None'),
              //           ),
              //         ],
              //         hint: Text('Select your gender'),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(height: 16.0),
              // Text('Select State'),
              // Container(
              //   height: 60,
              //   child: InputDecorator(
              //     decoration:
              //         const InputDecoration(border: OutlineInputBorder()),
              //     child: DropdownButtonHideUnderline(
              //       child: DropdownButton<String>(
              //         value: _selectedState,
              //         isExpanded: true,
              //         icon: Icon(Icons.arrow_drop_down),
              //         onChanged: (value) {
              //           setState(() {
              //             districtItems = [
              //               DropdownMenuItem(
              //                 value: 'none',
              //                 child: Text('None'),
              //               ),
              //             ];
              //             _selectedDistrict = "none";
              //             _selectedState = value;
              //             _fetchDistricts(value!);
              //           });
              //         },
              //         items: stateItems,
              //         hint: Text('Select your State'),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(height: 16.0),
              // Text('Select District'),
              // Container(
              //   height: 60,
              //   child: InputDecorator(
              //     decoration:
              //         const InputDecoration(border: OutlineInputBorder()),
              //     child: DropdownButtonHideUnderline(
              //       child: DropdownButton<String>(
              //         value: _selectedDistrict,
              //         isExpanded: true,
              //         icon: Icon(Icons.arrow_drop_down),
              //         onChanged: (value) {
              //           setState(() {
              //             _selectedDistrict = value!;
              //           });
              //         },
              //         items: districtItems,
              //         hint: Text('Select your District'),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(height: 16.0),
              // Text('Enter Aadhaar Number'),
              // TextField(
              //   controller: _aadharNumberController,
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              // SizedBox(height: 16.0),
              // Text('PAN Number'),
              // TextField(
              //   controller: _panNumberController,
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              // SizedBox(height: 16.0),
              // Text('Address Line 1'),
              // TextField(
              //   controller: _address1Controller,
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              // SizedBox(height: 16.0),
              // Text('Address Line 2'),
              // TextField(
              //   controller: _address2Controller,
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              // SizedBox(height: 16.0),
              // Text('Village'),
              // TextField(
              //   controller: _villageController,
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              // SizedBox(height: 16.0),
              // Text('City'),
              // TextField(
              //   controller: _cityController,
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              // SizedBox(height: 16.0),
              // Text('Pincode'),
              // TextField(
              //   controller: _pincodeController,
              //   keyboardType: TextInputType.number,
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              // SizedBox(height: 16.0),
              Container(
                height: 60,
                margin: const EdgeInsets.only(left: 5, right: 5, bottom: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_nameController.text.isEmpty) {
                      _nameRequired = false;
                    }
                    if (_phoneNumberController.text.isEmpty) {
                      _phoneNumberValid = false;
                    }
                    // if (_lastNameController.text.isEmpty) {
                    //   _lastNameRequired = false;
                    // }
                    // if (_onBoardingDateController.text.isEmpty) {
                    //   _onBoardingDateRequired = false;
                    // }
                    if (!isEmailValid(_emailController.text)) {
                      _emailValid = false;
                    }
                    if (isEmailValid(_emailController.text) &&
                        _nameController.text.isNotEmpty &&
                        _phoneNumberValid) {
                      NavigationUtils.showLoaderOnTop();
                      final response = await ApiRepository.submitSamhitaForm(
                          ApiRequestBody.submitSamhitaFormRequest(
                        _nameController.text,
                        _emailController.text,
                        _phoneNumberController.text,
                      )).catchError((err) {
                        NavigationUtils.pop();
                        UiUtils.showToast(err);
                      });

                      NavigationUtils.pop();

                      if (response.isSuccess!) {
                        // ignore: use_build_context_synchronously
                        HttpScreenClient.displayDialogBox(
                            "You Have become the Champion");
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => UikBottomNavigationBar()),
                        // );
                      } else {
                        UiUtils.showToast(response.error![MESSAGE]);
                      }
                    }
                    setState(() {});
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isEmailValid(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }
}
