import 'base_config.dart';
import 'dev_config.dart';
import 'local_config.dart';
import 'prod_config.dart';
class Environment {

  factory Environment() {
    return _singleton;
  }
  Environment._internal();

  static final Environment _singleton = Environment._internal();

  static const String DEV = 'DEV';
  static const String PROD = 'PROD';
  static const String LOCAL = 'LOCAL';
  late BaseConfig config;

  initConfig(String environment) {
    config = _getConfig(environment);
  }

  BaseConfig _getConfig(String environment) {
    switch (environment) {
      case Environment.PROD:
        return ProdConfig();
      case Environment.LOCAL:
        return LocalConfig();
      default:
        return DevConfig();
    }
  }
}