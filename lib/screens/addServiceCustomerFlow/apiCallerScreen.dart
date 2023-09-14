import 'package:flutter/material.dart';
import 'package:lokal/constants/dimens.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lottie/lottie.dart';

import '../../constants/strings.dart';
import '../../utils/network/ApiRepository.dart';

class ApiCallerScreen extends StatefulWidget {

  const ApiCallerScreen({Key? key}) : super(key: key);

  @override
  _ApiCallerScreenState createState() => _ApiCallerScreenState();
}

class _ApiCallerScreenState extends State<ApiCallerScreen> {
  bool _isLoading = true;
  bool _isSuccess = false;

  @override
  void initState() {
    super.initState();

  }

  late dynamic args;

  @override
  void didChangeDependencies() {
    args = ModalRoute.of(context)?.settings.arguments;
    _callApi();
    super.didChangeDependencies();
  }

  Future<void> _callApi() async {
    try {
      final response = await ApiRepository.apiCallerScreen(
        args['apiRoute'],
        args,
      );

      setState(() {
        _isLoading = false;
        _isSuccess = response.isSuccess!;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLoading)
              _buildLoadingUI()
            else if (_isSuccess)
              _SuccessMessageWidget(context)
            else
              _ErrorMessageWidget(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingUI() {
    return Column(
      children: [
        Lottie.network(
          LOADING_LOTTIE,
          height: 150, // Adjust the height as needed
          width: 150, // Adjust the width as needed
        ),
        const SizedBox(height: DIMEN_15),
        Text(args['loadingText'],
          style: const TextStyle(
            fontSize: DIMEN_25,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: DIMEN_20),
        const Text(
          'Please wait...',
          style: TextStyle(
            fontSize: DIMEN_20,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _ErrorMessageWidget(BuildContext context) {
    return Column(
      children: [
        Lottie.network(ERROR_LOTTIE),
        const SizedBox(height: DIMEN_16),
        Text(args['failureText']),
        const SizedBox(height: DIMEN_25,),
        ElevatedButton(
          onPressed: () {
            NavigationUtils.openScreenUntil(ScreenRoutes.addUserServiceCustomer,args);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFEE440), // Set the desired color
          ),
          child: const Text(
            "Kindly Add Customer Data Again",
            style: TextStyle(
              fontSize: DIMEN_15,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _SuccessMessageWidget(BuildContext context) {
    return Column(
      children: [
        Lottie.network(SUCCESS_LOTTIE),
        const SizedBox(height: DIMEN_16),
        Text(
          args['successText'],
          style: const TextStyle(
            fontSize: DIMEN_25,
            color: Colors.black,
            fontWeight: FontWeight.bold, // Add FontWeight.bold for a bolder text
          ),
        ),
        const SizedBox(height: DIMEN_25),
        ElevatedButton(
          onPressed: () {
            NavigationUtils.openScreenUntil(ScreenRoutes.userServiceTabsScreen,args);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFEE440), // Set the desired color
          ),
          child: const Text(
            " Move to Service Details ",
            style: TextStyle(
              fontSize: DIMEN_12,
              color: Colors.black,
              fontWeight: FontWeight.normal, // Add FontWeight.bold for a bolder text
            ),
          ),
        ),
      ],
    );
  }
}