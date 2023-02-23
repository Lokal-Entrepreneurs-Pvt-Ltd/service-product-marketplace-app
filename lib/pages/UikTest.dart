import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:lokal/utils/deeplink_handler.dart';
import 'package:lokal/utils/network/ApiRepository.dart';
import 'package:lokal/utils/network/retrofit/api_routes.dart';
import 'package:ui_sdk/StandardPage.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sdk/props/ApiResponse.dart';
import 'package:ui_sdk/props/UikAction.dart';
import '../constants.dart';
import '../main.dart';
import '../actions.dart';


Map<String, dynamic> mockresponse = {
  "isSuccess": true,
  "data": {
    "response": {
      "widgets": [
        {
          "id": "titleNavbar",
          "uiType": "UikNavBar"
        },
        {
          "id": "titleContainerText",
          "uiType": "UikContainerText"
        },
        {
          "id": "titleTextField",
          "uiType": "UikTextField"
        },
        {
          "id": "titleContainerText1",
          "uiType": "UikContainerText"
        },
        {
          "id": "titleTwoComponentRow0",
          "uiType": "UikTwoComponentRow"
        },
        {
          "id": "titleTwoComponentRow1",
          "uiType": "UikTwoComponentRow"
        },
        {
          "id": "titleTwoComponentRow2",
          "uiType": "UikTwoComponentRow"
        }
      ],
      "dataStore": {
        "titleNavbar": {
          "id": "navBar",
          "leadingIcon": {
            "id": "backIcon",
            "iconVal": "0xe092",
            "iconSize": "20.0",
            "action": {
              "tap": {}
            }
          },
          "centerText": {},
          "rightElement": {},
          "sideMargin": "16",
          "topMargin": "20",
          "bottomMargin": "20"
        },
        "titleContainerText": {
          "id": "titleContainerText",
          "text": "Offers & Benifits",
          "width": "343",
          "height": "32",
          "size": "24",
          "fontWeight": "FontWeight.w600",
          "color": "0xFF212121",
          "leftMargin": "16",
          "topMargin": "15",
          "rightMargin": "30",
          "bottomMargin": "30",
          "isStrike": false,
          "isCenter": false,
          "striketext": "",
          "action": {
            "tap": {
              "type": "UIK_OPEN_WEB",
              "data": {
                "url": "https://sylhetmirror.com/2022/04/03/tesla-delivers-over-1-million-electric-cars-over-past-year/"
              }
            }
          }
        },
        "titleTextField": {
          "id": "titleTextField",
          "width": 343,
          "height": 66,
          "leftMargin": "16",
          "topMargin": "28",
          "rightElement": {
            "id": "titleIcon",
            "iconVal": "0xe79a",
            "iconColor": "0xFF212121",
            "iconSize": "20.0",
            "padding": "22.0",
            "action": {
              "tap": {
                "type": "UIK_OPEN_WEB",
                "data": {
                  "url": "https://sylhetmirror.com/2022/04/03/tesla-delivers-over-1-million-electric-cars-over-past-year/"
                }
              }
            }
          },
          "leftElement": {
            "id": "titleIcon",
            "iconVal": "0xef28",
            "iconColor": "0xFF212121",
            "iconSize": "20.0",
            "padding": "22.0",
            "action": {
              "tap": {
                "type": "UIK_OPEN_WEB",
                "data": {
                  "url": "https://sylhetmirror.com/2022/04/03/tesla-delivers-over-1-million-electric-cars-over-past-year/"
                }
              }
            }
          },
          "action": {
            "tap": {
              "type": "UIK_OPEN_WEB",
              "data": {
                "url": "https://sylhetmirror.com/2022/04/03/tesla-delivers-over-1-million-electric-cars-over-past-year/"
              }
            }
          }
        },
        "titleContainerText1": {
          "id": "titleContainerText",
          "text": "Bill Details",
          "width": "343",
          "height": "32",
          "size": "24",
          "fontWeight": "FontWeight.w600",
          "color": "0xFF212121",
          "leftMargin": "16",
          "topMargin": "15",
          "rightMargin": "30",
          "bottomMargin": "30",
          "isStrike": false,
          "isCenter": false,
          "striketext": "",
          "action": {
            "tap": {
              "type": "UIK_OPEN_WEB",
              "data": {
                "url": "https://sylhetmirror.com/2022/04/03/tesla-delivers-over-1-million-electric-cars-over-past-year/"
              }
            }
          }
        },
        "titleTwoComponentRow0": {
          "id": "titleTwoComponentRow",
          "marginLeft": "29",
          "marginTop": "29",
          "marginRight": "29",
          "height": "94",
          "bgcolor": "0xFFF5F5F5",
          "firstComponent": {
            "id": "text",
            "text": "Subtotal",
            "size": "16",
            "width": "68",
            "height": "24",
            "fontWeight": "FontWeight.w400",
            "action": {
              "tap": {
                "type": "UIK_OPEN_WEB",
                "data": {
                  "url": "https://sylhetmirror.com/2022/04/03/tesla-delivers-over-1-million-electric-cars-over-past-year/"
                }
              }
            }
          },
          "secondComponent": {
            "id": "text",
            "text": "0",
            "size": "16",
            "width": "68",
            "height": "24",
            "fontWeight": "FontWeight.w400",
            "action": {
              "tap": {
                "type": "UIK_OPEN_WEB",
                "data": {
                  "url": "https://sylhetmirror.com/2022/04/03/tesla-delivers-over-1-million-electric-cars-over-past-year/"
                }
              }
            }
          },
          "action": {
            "tap": {
              "type": "UIK_OPEN_WEB",
              "data": {
                "url": "https://sylhetmirror.com/2022/04/03/tesla-delivers-over-1-million-electric-cars-over-past-year/"
              }
            }
          }
        },
        "titleTwoComponentRow1": {
          "id": "titleTwoComponentRow",
          "marginLeft": "29",
          "marginTop": "29",
          "marginRight": "29",
          "height": "94",
          "bgcolor": "0xFFF5F5F5",
          "firstComponent": {
            "id": "text",
            "text": "Shipping Cost",
            "size": "16",
            "width": "68",
            "height": "24",
            "fontWeight": "FontWeight.w400",
            "action": {
              "tap": {
                "type": "UIK_OPEN_WEB",
                "data": {
                  "url": "https://sylhetmirror.com/2022/04/03/tesla-delivers-over-1-million-electric-cars-over-past-year/"
                }
              }
            }
          },
          "secondComponent": {
            "id": "text",
            "text": "0",
            "size": "16",
            "width": "68",
            "height": "24",
            "fontWeight": "FontWeight.w400",
            "action": {
              "tap": {
                "type": "UIK_OPEN_WEB",
                "data": {
                  "url": "https://sylhetmirror.com/2022/04/03/tesla-delivers-over-1-million-electric-cars-over-past-year/"
                }
              }
            }
          },
          "action": {
            "tap": {
              "type": "UIK_OPEN_WEB",
              "data": {
                "url": "https://sylhetmirror.com/2022/04/03/tesla-delivers-over-1-million-electric-cars-over-past-year/"
              }
            }
          }
        },
        "titleTwoComponentRow2": {
          "id": "titleTwoComponentRow",
          "marginLeft": "29",
          "marginTop": "29",
          "marginRight": "29",
          "height": "94",
          "bgcolor": "0xFFF5F5F5",
          "firstComponent": {
            "id": "text",
            "text": "Discount",
            "size": "16",
            "width": "68",
            "height": "24",
            "fontWeight": "FontWeight.w400",
            "action": {
              "tap": {
                "type": "UIK_OPEN_WEB",
                "data": {
                  "url": "https://sylhetmirror.com/2022/04/03/tesla-delivers-over-1-million-electric-cars-over-past-year/"
                }
              }
            }
          },
          "secondComponent": {
            "id": "text",
            "text": "0",
            "size": "16",
            "width": "68",
            "height": "24",
            "fontWeight": "FontWeight.w400",
            "action": {
              "tap": {
                "type": "UIK_OPEN_WEB",
                "data": {
                  "url": "https://sylhetmirror.com/2022/04/03/tesla-delivers-over-1-million-electric-cars-over-past-year/"
                }
              }
            }
          },
          "action": {
            "tap": {
              "type": "UIK_OPEN_WEB",
              "data": {
                "url": "https://sylhetmirror.com/2022/04/03/tesla-delivers-over-1-million-electric-cars-over-past-year/"
              }
            }
          }
        }
      }
    }
  }
};
class UikHome extends StandardPage {
  @override
  Set<String?> getActions() {
    Set<String?> actionList = Set();
    actionList.add(UIK_ACTION.OPEN_CATEGORY);
    actionList.add(UIK_ACTION.OPEN_ISP);
    actionList.add(UIK_ACTION.ADD_TO_CART);
    return actionList;
  }

  @override
  dynamic getData() {
    //return ApiRepository.getHomescreen;
    return getMockedApiResponse;
  }

  void onHomeScreenTapAction(UikAction uikAction) {
    switch (uikAction.tap.type) {
      case UIK_ACTION.ADD_TO_CART:
        addToCart(uikAction);
        break;
      case UIK_ACTION.OPEN_CATEGORY:
        openCategory(uikAction);
        break;
      default:
    }
  }

  @override
  getPageCallBackForAction() {
    return onHomeScreenTapAction;
  }

  @override
  getPageContext() {
    return UikHome;
  }
}

Future<ApiResponse> getMockedApiResponse(args) async {
  final queryParameter = {
    "id": "eb5f37b2-ca34-40a1-83ba-cb161eb55e6e",
  };
  print("entering lavesh");
  final response = await http.get(
    Uri.parse('http://demo2913052.mockable.io/home'),
    headers: {
      "ngrok-skip-browser-warning": "value",
    },
  );

  print(response.body);

  if (response.statusCode == 200) {
    return ApiResponse.fromJson(mockresponse);
  } else {
    throw Exception('Failed to load album');
  }
}

void addToCart(UikAction uikAction) async {
  // var skuId = uikAction.tap.data.skuId;
  //
  // //api call to update cart
  // final response =
  //     await getHttp().post(Uri.parse('${baseUrl}/cart/update'), headers: {
  //   "ngrok-skip-browser-warning": "value",
  // }, body: {
  //   "skuId": skuId,
  //   "cartId": "",
  //   "action": "add"
  // });
  //
  // //displaying response from update cart
  // print("statusCode ${response.body}");
}

void openCategory(UikAction uikAction) {
  //Navigation to the next screen through deepLink Handler
  print(
      "_____________________________Catalogue call___________________________");
  var context = NavigationService.navigatorKey.currentContext;
  DeeplinkHandler.openPage(context!, uikAction.tap.data.url!);
}
