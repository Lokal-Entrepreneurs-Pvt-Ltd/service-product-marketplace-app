import 'package:digia_ui/digia_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lokal/configs/env_utils.dart';
import 'package:lokal/configs/environment_data_handler.dart';
import 'package:lokal/constants/environment.dart';
import 'package:lokal/notifications/notification_controller.dart';
import 'package:lokal/screens/digia/DigiaMessageHandler.dart';

import 'package:lokal/utils/AppInitializer.dart';
import 'package:lokal/utils/Logs/eventsdk.dart';
import 'package:lokal/utils/UiUtils/UiUtils.dart';
import 'package:lokal/utils/go_router/app_router.dart';
import 'package:lokal/utils/payments/PaymentService.dart';
import 'package:lokal/utils/storage/preference_util.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shake_detector/shake_detector.dart';
import 'package:ui_sdk/ApiResponseState.dart';
import 'package:ui_sdk/utils/extensions.dart';
import 'package:uuid/uuid.dart';
import 'configs/environment.dart' as env;
import 'package:lokal/utils/storage/shared_prefs.dart';
import 'package:provider/provider.dart';
// import 'package:shake/shake.dart';

AppInitializer? appInit;

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  appInit = AppInitializer();
  await appInit?.init();
  WidgetsFlutterBinding.ensureInitialized();
  PaymentService().setup();
  // final appConfigDataHandler = AppConfigDataHandler();
  // await appConfigDataHandler.init();
  //Release(PrioritizeCache(), 'assets/digia_assets/app_config.json', 'assets/digia_assets/js_function.js')
  await DigiaUIClient.init(
  accessKey: "67ab17ed3da4ddfcd6cfea51",
  flavorInfo: Debug("main"),
  environment: Environment.development.name,
  baseUrl: "https://app.digia.tech/api/v1",
  networkConfiguration:
  NetworkConfiguration(defaultHeaders:  {}, timeout: 1000));


  await PreferenceUtils.init();
  String environment = String.fromEnvironment(
    ENVIRONMENT_KEY,
    defaultValue: EnvironmentDataHandler.getDefaultEnvironment(),
  );
  env.Environment().initConfig(environment);

  DUIFactory().initialize();

  runApp(
    DigiaUIScope(child:   MultiBlocProvider(
      providers: [
        BlocProvider<StandardScreenResponseCubit>(
          create: (context) => StandardScreenResponseCubit(),
        ),
        BlocProvider<ApiResponseCubit>(
          create: (context) => ApiResponseCubit(
            BlocProvider.of<StandardScreenResponseCubit>(context),
          ),
        ),
      ],
      child: const MaterialApp(home: LokalApp()),
    )),
  );

  //
  // FlutterError.onError = (errorDetails) {
  //   FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  // };
  //
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //   return true;
  // };
  //
  await FirebaseMessagingController().initNotifications();
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

class LokalApp extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  const LokalApp({Key? key}) : super(key: key);

  @override
  State<LokalApp> createState() => _LokalAppState();

  static void resetAppState() {
    final appContext = AppRoutes.rootNavigatorKey.currentContext;
    final _LokalAppState? appState =
        appContext!.findAncestorStateOfType<_LokalAppState>();
    appState?.resetState(); // Call resetState method on the current state
  }
}

late ShakeDetector detector;

class _LokalAppState extends State<LokalApp> with DigiaMessageHandlerMixin {
  @override
  void initState() {
    super.initState();
    initPlatformState();
    shakeInit();
    addMessageHandler(DigiaMessageType.logout.name, DigiaMessageHandler.logout);
    addMessageHandler(DigiaMessageType.openPage.name, DigiaMessageHandler.openPage);
    addMessageHandler(DigiaMessageType.executeAction.name, DigiaMessageHandler.executeAction);;
  }


  void resetState() {
    setState(() {});
    initPlatformState();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    detector.stopListening();
    super.dispose();
  }

  void shakeInit() {
    if (const bool.fromEnvironment('dart.vm.product')) {
      // Shake detection will only be initialized in debug mode
      return;
    }
    try {
      detector = ShakeDetector.autoStart(onShake: () {
        print('Shake detected'); // Add this line to verify shake detection
        displayTextInputDialog(context);
      });
      print(
          'Shake detection initialized'); // Add this line to verify initialization
      detector.startListening();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> initPlatformState() async {
    String? deviceId;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      await EventSDK.init();
      deviceId = Uuid().v4();
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }

    PreferenceUtils.setString("device_id", deviceId.toString());

    final packageInfo = await PackageInfo.fromPlatform();
    UserDataHandler.saveAppVersion(packageInfo.version);

    if (!mounted) return;
  }

  displayTextInputDialog(BuildContext context) async {
    print('Displaying text input dialog');
    var tempLocalUrl = EnvironmentDataHandler.getLocalBaseUrl();
    return showDialog(
        context: context,
        builder: (context) {
          var textFieldController = TextEditingController(
              text: EnvironmentDataHandler.getLocalBaseUrl());
          return AlertDialog(
            title: const Text('Set Ngrok URL'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  tempLocalUrl = value;
                });
              },
              controller: textFieldController,
              decoration:
                  const InputDecoration(hintText: "Enter the local url"),
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
                    EnvUtils.setEnvironmentAndResetApp(
                        context, env.Environment.PROD, "");
                  });
                },
              ),
              MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                child: const Text('Set Dev'),
                onPressed: () {
                  setState(() {
                    EnvUtils.setEnvironmentAndResetApp(
                        context, env.Environment.DEV, "");
                  });
                },
              ),
              MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: const Text('Set Lokal'),
                onPressed: () {
                  setState(() {
                    EnvUtils.setEnvironmentAndResetApp(
                        context, env.Environment.LOCAL, tempLocalUrl);
                  });
                },
              ),
            ],
          );
        });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final router = AppRoutes().router;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DarkThemeProvider(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationProvider: router.routeInformationProvider,
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        // navigatorKey: NavigationService.navigatorKey,
        // navigatorObservers: [ChuckerFlutter.navigatorObserver],
        theme: ThemeData(
            fontFamily: 'Georgia',
            scaffoldBackgroundColor: ("#ffffff").toColor(),
            appBarTheme: AppBarTheme(
              color: ("#ffffff").toColor(),
              surfaceTintColor: ("#ffffff").toColor(),
            )),
      ),
    );
  }
}
