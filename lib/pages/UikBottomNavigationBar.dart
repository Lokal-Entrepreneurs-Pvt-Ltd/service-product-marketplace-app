import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lokal/configs/environment.dart';
import 'package:lokal/configs/environment_data_handler.dart';
import 'package:lokal/pages/UikCartScreen.dart';
import 'package:lokal/pages/UikCatalogScreen.dart';
import 'package:lokal/pages/UikHomeWrapper.dart';
import 'package:lokal/pages/UikMyAccountScreen.dart';
import 'package:lokal/pages/UikOrderScreen.dart';
import 'package:lokal/pages/UikProductPage.dart';
import 'package:lokal/pages/UikSearchCatalog.dart';
import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/storage/cart_data_handler.dart';
import 'package:lokal/utils/storage/preference_util.dart';
import '../main.dart';
import '../utils/network/retrofit/api_routes.dart';
import 'UikHome.dart';

class
UikBottomNavigationBar extends StatefulWidget {
  @override
  State<UikBottomNavigationBar> createState() => _UikBottomNavigationBarState();
}

class _UikBottomNavigationBarState extends State<UikBottomNavigationBar> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const UikHomeWrapper(),
    // UikCartScreen().page,
    // UikMyAccountScreen().page,
  ];

  int totalCartItems = CartDataHandler.getCartItems().length;

  var tempLocalUrl=EnvironmentDataHandler.getLocalBaseUrl();

  void _onItemTapped(int index) {
    var context = NavigationService.navigatorKey.currentContext;
    if (index == _selectedIndex) return;
    if (index == 1) {
      if(kDebugMode)
      displayTextInputDialog(context!);
      else
      Navigator.pushNamed(context!, ScreenRoutes.myGames);
    }
    if (index == 2) {
      Navigator.pushNamed(context!, ScreenRoutes.myAccountScreen);
    }

    // if (index == 1) {
    //   Navigator.pushNamed(context!, ScreenRoutes.cartScreen);
    // } else if (index == 2) {
    //   Navigator.pushNamed(context!, ScreenRoutes.myAccountScreen);
    // }
    // setState(() {
    //   _selectedIndex = index;
    // });
  }

  setEnvironmentAndResetApp(String environment, String localUrl){

    switch(environment){
      case Environment.PROD: {
        UiUtils.showToast("Prod Env Set,  Restart the app");
      }
      break;
      case Environment.LOCAL: {
        if(localUrl.isNotEmpty){
          EnvironmentDataHandler.setLocalBaseUrl(localUrl);
          UiUtils.showToast("Local Url set: "+ localUrl + " Restart the app");
        }
        else
          UiUtils.showToast("invalid url");
      }
      break;
      default : {
        UiUtils.showToast("Dev Env Set,  Restart the app");
      }
    }
    EnvironmentDataHandler.setDefaultEnvironment(environment);
    Navigator.pop(context);
    SystemNavigator.pop();
  }

 displayTextInputDialog(BuildContext context) async {
    var localUrl;
    return showDialog(
        context: context,
        builder: (context) {
          var _textFieldController = TextEditingController(text: EnvironmentDataHandler.getLocalBaseUrl());
          return AlertDialog(
            title: Text('Set Ngrok URL'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  tempLocalUrl = value;
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration( hintText: "Enter the local url"),
            ),
            actions: <Widget>[
              MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                child: const Text('Clear Data and Kill App'),
                onPressed: () {
                  setState(() {
                    UiUtils.showToast("Data Cleared, Restart the app");
                      PreferenceUtils.clearStorage();
                      SystemNavigator.pop();
                  });
                },
              ),
              MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                child: const Text('Set Prod'),
                onPressed: () {
                  setState(() {
                   setEnvironmentAndResetApp(Environment.PROD,"");
                  });
                },
              ),
              MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                child: const Text('Set Dev'),
                onPressed: () {
                  setState(() {
                    setEnvironmentAndResetApp(Environment.DEV,"");
                  });
                },
              ),
              MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('Set Lokal'),
                onPressed: () {
                  setState(() {
                    if(tempLocalUrl.isNotEmpty && tempLocalUrl.endsWith("ngrok.io"))
                   {
                     setEnvironmentAndResetApp(Environment.DEV,tempLocalUrl);
                   }
                    else
                      UiUtils.showToast("Invalid url");
                  });
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            _widgetOptions.elementAt(0),
            if (totalCartItems > 0)
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: BottomCartDetails(
                  totalItems: totalCartItems,
                  totalCost: 1000.0,
                ),
              ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "",
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(
            //     Icons.shopping_bag,
            //   ),
            //   label: "",
            // ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.gamepad,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "",
            )
          ],
        ),
      ),
    );
  }
}

class BottomCartDetails extends StatelessWidget {
  const BottomCartDetails({
    super.key,
    required this.totalItems,
    this.totalCost = 0.0,
  });

  final int totalItems;
  final double totalCost;

  void openCartScreen() {
    var context = NavigationService.navigatorKey.currentContext;
    // DeeplinkHandler.openPage(context!, uikAction.tap.data.url!);
    Navigator.pushNamed(context!, ScreenRoutes.cartScreen);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        openCartScreen();
      },
      child: Container(
        height: 37,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        color: const Color(0xFF6247FF),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$totalItems items | $totalCost",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            const Text(
              "View Cart",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
