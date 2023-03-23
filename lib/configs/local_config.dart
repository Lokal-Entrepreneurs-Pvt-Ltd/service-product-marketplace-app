
import 'base_config.dart';
import 'environment_data_handler.dart';

class LocalConfig implements BaseConfig {
  @override
  String get BASE_URL => EnvironmentDataHandler.getLocalBaseUrl();
  @override
  String get razorPayKey => "rzp_test_L2YR9Eo4N7KP03";

}