import 'package:lokal/utils/storage/preference_util.dart';
import 'samhita_data_constants.dart';

class SamhitaDataHandler {
  static void saveRequestId(String requestId) {
    PreferenceUtils.setString(REQUEST_ID, requestId);
  }

  static String getRequestId() {
    return PreferenceUtils.getString(REQUEST_ID);
  }

}
