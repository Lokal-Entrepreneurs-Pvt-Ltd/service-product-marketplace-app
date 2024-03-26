
import '../constants/strings.dart';

class CodeUtils {

static String getUserTypeFromDisplay(String selectedUserType) {
  switch (selectedUserType) {
    case PARTNER:
      return PARTNER;
    case AGENT:
      return AGENT;
    case CANDIDATE:
      return CUSTOMER;
    default:
    // Default to CUSTOMER if selectedUserType is not recognized
      return CUSTOMER;
  }
}
}