import 'package:lokal/screen_routes.dart';
import 'package:lokal/utils/NavigationUtils.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/network/retrofit/api_routes.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';

enum RouteMethod { pop, push, pushAndPopUntil, none }

enum WidgetType {
  textInputContainer,
  locationBox,
  state,
  district,
  block,
  selectionBox,
  selectableBox,
  uploadBox,
}

class FieldData {
  static bool validationLogic(String? type, String? value) {
    if (value != null && type != null) {
      switch (type) {
        case 'gst':
          return UiUtils.isGSTValid(value) || value.isEmpty;
        case 'phone':
          return UiUtils.isPhoneNoValid(value) || value.isEmpty;
        case 'email':
          return UiUtils.isEmailValid(value) || value.isEmpty;
        case 'ifsc':
          return UiUtils.isIFSCValid(value) || value.isEmpty;
        case 'number':
          return UiUtils.isNumberValid(value) || value.isEmpty;
        case 'pin':
          return UiUtils.isPINCodeValid(value) || value.isEmpty;
        case 'datetime':
          return UiUtils.isDateTimeValid(value) || value.isEmpty;
        default:
          return true;
      }
    }
    return true;
  }

  static WidgetType getWidgetType(String id) {
    switch (id) {
      case "textInputContainer":
        return WidgetType.textInputContainer;
      case "locationBox":
        return WidgetType.locationBox;
      case "state":
        return WidgetType.state;
      case "district":
        return WidgetType.district;
      case "block":
        return WidgetType.block;
      case "selectionBox":
        return WidgetType.selectionBox;
      case "selectableBox":
        return WidgetType.selectableBox;
      case "uploadBox":
        return WidgetType.uploadBox;
      default:
        throw Exception("Invalid widget type");
    }
  }

  static RouteMethod getRouteMethod(String? method) {
    switch (method) {
      case 'pop':
        return RouteMethod.pop;
      case 'push':
        return RouteMethod.push;
      case 'pushAndPopUntil':
        return RouteMethod.pushAndPopUntil;
      default:
        return RouteMethod.none;
    }
  }

  static void handleRoute(RouteMethod routeMethod, String pageRoute,
      String? popName, Map<String, dynamic>? args) {
    switch (routeMethod) {
      case RouteMethod.pop:
        NavigationUtils.pop();
        break;
      case RouteMethod.push:
        NavigationUtils.openScreen(pageRoute, args);
        break;
      case RouteMethod.pushAndPopUntil:
        NavigationUtils.pushAndPopUntil(pageRoute, popName, args);
        break;
      case RouteMethod.none:
        // Do nothing
        break;
    }
  }

  static dynamic joinValues(dynamic fromJoin, dynamic toJoin, String type) {
    if (toJoin == null && fromJoin == null) {
      return "";
    }
    if (toJoin == null) {
      return fromJoin;
    }
    if (fromJoin == null) {
      return toJoin;
    }
    List<String> values = [fromJoin, toJoin];
    switch (type) {
      case 'comma':
        return values.join(',');
      case 'space':
        return values.join(' ');
      case 'brackets':
        return values.map((value) => '{$value}').join(', ');
      default:
        return values.join(',');
    }
  }

  static dynamic getDataFromPath(Map<String, dynamic> json, String? path) {
    if (path == null || path.isEmpty) {
      return null;
    }

    final keys = path.split('.');
    dynamic value = json;

    for (final key in keys) {
      if (key.contains('[') && key.contains(']')) {
        final arrayKey = key.substring(0, key.indexOf('['));
        final indexString =
            key.substring(key.indexOf('[') + 1, key.indexOf(']'));

        if (value[arrayKey] is List) {
          final index = int.tryParse(indexString);
          if (index != null && value[arrayKey].length > index) {
            value = value[arrayKey][index];
          } else {
            return null;
          }
        } else {
          return null;
        }
      } else if (value[key] != null) {
        value = value[key];
      } else {
        return null;
      }
    }
    return value;
  }
}

class FieldScreenData {
  static Map<String, dynamic> mainData(String route) {
    Map<String, dynamic> emptyMap = {};
    switch (route) {
      case ScreenRoutes.addNewLeads1:
        return {
          "appBar": {"text": "Add New Leads"},
          "body": {
            "name": {
              "id": "textInputContainer",
              "name": "Name",
              "errorText": "Please Enter Name"
            },
            "mobile": {
              "id": "textInputContainer",
              "name": "Mobile Number",
              "type": "number",
              "validation": "phone",
              "errorText": "Please Enter Vaild Mobile Number",
            },
            "email": {
              "id": "textInputContainer",
              "name": "Email",
              "type": "email",
              "validation": "email",
              "errorText": "Please Enter Valid Email",
            },
            "submissionDateTime": {
              "id": "textInputContainer",
              "name": "Date & Time of submission",
              "type": "datetime",
              "hint": "YYYY-MM-DD HH:MM",
              "validation": "datetime",
              "errorText": "Please Enter Vaild Date Time",
            },
            "electricityConnectionNumber": {
              "id": "textInputContainer",
              "name": "Electricity Connection No",
              "type": "number",
            },
            "sanctionedLoad": {
              "id": "textInputContainer",
              "name": "Sanctioned Load (in kW)",
              "type": "number",
            },
            "proposedPvCapacity": {
              "id": "textInputContainer",
              "name": "Proposed PV Capacity (in kWp)",
              "type": "number",
            },
          },
          "footer": {
            "text": "Continue",
            "isTransferToNext": true,
            // "api": ApiRoutes.addNewLeads,
            //  "routeMethod": "push",
            "pageRoute": ScreenRoutes.addressOfCustomer,
            "successMessage": "Successfully submitted"
          }
        };
      case ScreenRoutes.addressOfCustomer:
        return {
          "appBar": {"text": "Address Of Customer"},
          "body": {
            "address": {
              "id": "textInputContainer",
              "name": "House/ Building No",
            },
            "box2": {
              "id": "textInputContainer",
              "name": "Street Address, Colony, Area",
              "joinTo": {"type": "comma", "field": "address"}
            },
            "state": {
              "id": "state",
              "text": "State",
            },
            "district": {
              "id": "district",
              "text": "District",
              "dependency": "state",
            },
            "pinCode": {
              "id": "textInputContainer",
              "name": "Pin Code",
              "type": "number",
              "validation": "pin",
              "errorText": "Please Enter Correct Pin Code"
            },
          },
          "footer": {
            "text": "Continue",
            "isTransferToNext": true,
            // "api": ApiRoutes.addNewLeads,
            // "routeMethod": "push",
            "pageRoute": ScreenRoutes.customerBankDetails,
            "successMessage": "Added Address Successfully"
          }
        };
      case ScreenRoutes.customerBankDetails:
        return {
          "appBar": {"text": "Customer Loan Details"},
          // "api": {
          //   ApiRoutes.getUserProfile: {
          //     "args": {},
          //     "populate": {"box0": "firstName","type":""}
          //   }
          // },
          "body": {
            "bankAccNo": {
              "id": "textInputContainer",
              "name": "Customer Bank Account Number",
              "validation": "bankAccountNumber",
              "type": "number",
              "errorText": "Please correct Account Number"
            },
            "ifsc": {
              "id": "textInputContainer",
              "name": "Bank Ifsc",
              "validation": "ifsc",
              "function": "updateBankInfo",
              "populateTo": ["branchAddress"],
              "errorText": "Please fill correct IFSC Code"
            },
            "branchAddress": {
              "id": "textInputContainer",
              "name": "Branch Address",
            },
            "cibilScore": {
              "id": "textInputContainer",
              "name": "Customer Cibil Score",
              "type": "number",
            },
            "isLoan": {
              "id": "selectableBox",
              "isSingleSelected": true,
              "list": ["Yes", "No"],
              "text": "Does Customer Needs a loan?"
            },
            // "box3": {
            //   "id": "locationBox",
            //   "text": "House/ Building No",
            // },
          },
          "footer": {
            "text": "Continue",
            "api": ApiRoutes.addNewLeads,
            // "condition": {
            //   "isLoan": "Yes",
            // },
            "routeMethod": "pushAndPopUntil",
            "isTransferToNext": false,
            // "elseRouteMethod": "pushAndPopUntil",
            "pageRoute": ScreenRoutes.partnerInfo,
            "successMessage": "Added Bank Details Successfully",
            // "elsepageRoute": ScreenRoutes.uikBottomNavigationBar,
            "popName": ScreenRoutes.partnerInfo,
            "additionalArgs": {"userId": UserDataHandler.getUserId()}
          }
        };
      case ScreenRoutes.customerUploadDocuments:
        return {
          "appBar": {"text": "Customer Loan Details"},
          // "api": {
          //   ApiRoutes.getUserProfile: {
          //     "args": {},
          //     "populate": {"box0": "data.firstName"}
          //   }
          // },
          "body": {
            "box1": {
              "id": "uploadBox",
              "text": "Last Month Electricity Bill. (Max Size 1 MB)"
            },
            "box2": {
              "id": "uploadBox",
              "text": "Vera Bill/ Index Copy. (Max Size 1 MB)"
            },
            "box3": {
              "id": "uploadBox",
              "text": "Aadhar Card Front. (Max Size 1 MB)"
            },
            "box4": {
              "id": "uploadBox",
              "text": "Aadhar Card Back. (Max Size 1 MB)"
            },
            "box5": {
              "id": "uploadBox",
              "text": "Upload Your Pan card Image. (Max Size 1 MB)"
            },
            "box6": {
              "id": "uploadBox",
              "text": "Passport size Photo. (Max Size 1 MB)"
            },
            "box7": {
              "id": "uploadBox",
              "text": "Cancelled Cheque. (Max Size 1 MB)"
            },
          },
          "footer": {
            "text": "Continue",
            "api": "",
            "routeMethod": "pop",
            "pageRoute": ScreenRoutes.customerLoanDetails
          }
        };
      case ScreenRoutes.customerLoanDetails:
        return {
          "appBar": {"text": "Customer Loan Details"},
          // "api": {
          //   ApiRoutes.getUserProfile: {
          //     "args": {},
          //     "populate": {"box0": "data.firstName"}
          //   }
          // },
          "body": {
            "box1": {
              "id": "selectionBox",
              "isSingleSelected": true,
              "list": ["ram", "ded", "wooh", "raso"],
              "hint": "fill tje value"
            },
            "box2": {
              "id": "selectionBox",
              "isSingleSelected": true,
              "list": ["ram", "ded", "wooh", "raso"],
              "hint": "fill tje value"
            },
          },
          "footer": {
            "text": "Continue",
            "api": "",
            "routeMethod": "pop",
            "screenRoute": "/fieldScreen/otherdata"
          }
        };

      default:
        return {
          "appBar": {"text": "Data"},
          "body": emptyMap,
          "footer": {
            "text": "Continue",
            "api": "",
            "routeMethod": "pop",
            "screenRoute": "/fieldScreen/otherdata"
          }
        };
    }
  }
}
