import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projeto_firebase/firebase_messaging/custom_firebase_messaging.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await CustomFirebaseMessaging().initialize();
  await CustomFirebaseMessaging().getTokenFirebase();

  runApp(const MainApp());
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
        "/home": (_) => const Scaffold(
              body: Center(
                child: Text("página 1"),
              ),
            ),
        "/hidden": (_) => const Scaffold(
              body: Center(
                child: Text("Página escondida"),
              ),
            )
      },
    );
  }
}
