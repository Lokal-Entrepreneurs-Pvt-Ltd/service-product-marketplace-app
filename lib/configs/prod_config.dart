
import 'base_config.dart';

class ProdConfig implements BaseConfig {
  @override
  String get BASE_URL => "https://prod.localee.co.in/api";
  @override
  String get razorPayKey => "rzp_live_5DXNxib2Kg5Zr1";

}