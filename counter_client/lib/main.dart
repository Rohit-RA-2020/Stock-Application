import 'package:counter_client/screens/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'firebase_options.dart';
import 'model.dart';
import 'providers/provider.dart';
import 'screens/home_page.dart';

final uri = Uri.parse('ws://10.0.2.2:3000');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFF16151A),
          canvasColor: Colors.transparent,
          brightness: Brightness.dark),
      home: const AuthScreen(),
    );
  }
}

class HomePage extends ConsumerWidget {
  final channel = WebSocketChannel.connect(uri);

  HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: channel.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.data != 'connected to server, welcome client') {
              Future(() {
                ref.read(stocksListProvider.notifier).state =
                    stocksListFromJson(snapshot.data);
              });
              return const MyHomePage();
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Error connecting to server',
                  style: TextStyle(fontSize: 30),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
