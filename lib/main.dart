import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'screen/loan.dart';

void main() async {
  ErrorWidget.builder = (FlutterErrorDetails details) => Container();
  WidgetsFlutterBinding.ensureInitialized();
  initializeNotifications();
  await GetStorage.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: h_screen(),
      //home: store.read("id") != null ? const h_screen() : login(),
      debugShowCheckedModeBanner: false,
    );
  }
}

Future<void> initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await FlutterLocalNotificationsPlugin().initialize(initializationSettings);
}
