import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:projeto_firebase/firebase_messaging/custom_firebase_messaging.dart';
import 'package:projeto_firebase/remote_config/custom_remote_config.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  /// Para fazer o teste de crash para ver se o crashlytics tá funcionando:
  // FirebaseCrashlytics.instance.crash();

  /// Para colocar um log com texto customizado:
  // FirebaseCrashlytics.instance.log("oi, esse é um log customizado");
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();

    /// nesta ordem para que consigamos fazer o exemplo remote + notification
    await CustomRemoteConfig().initialize();
    await CustomFirebaseMessaging()
        .initialize(() => CustomRemoteConfig().forceFetch());
    await CustomFirebaseMessaging().getTokenFirebase();

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    runApp(const MainApp());
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter demo",
      navigatorKey: navigatorKey,
      initialRoute: "/home",
      routes: {
        "/home": (_) => MyHomePage(title: "título"),
        "/hidden": (_) => Scaffold(
              appBar: AppBar(),
              body: const Center(
                child: Text("Página escondida"),
              ),
            )
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoading = false;

  void _incrementCounter() async {
    setState(() => _isLoading = true);
    await CustomRemoteConfig().forceFetch();
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: CustomRemoteConfig()
                    .getValueOrDefault(key: "isActiveBlue", defaultValue: false)
                ? Colors.blue
                : Colors.red),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      CustomRemoteConfig()
                          .getValueOrDefault(
                              key: "novaString", defaultValue: "defaultValue")
                          .toString(),
                      style: Theme.of(context).textTheme.headlineSmall,
                    )
                  ],
                ),
              ));
  }
}
