import 'package:counter_client/screens/auth.dart';
import 'package:counter_client/screens/pages/all_stocks.dart';
import 'package:counter_client/screens/pages/dashboard.dart';
import 'package:counter_client/screens/pages/news.dart';
import 'package:counter_client/screens/pages/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'firebase_options.dart';
import 'models/stock_model.dart';
import 'providers/provider.dart';

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

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final channel = WebSocketChannel.connect(uri);

  int _currentIndex = 0;

  final iconList = <IconData>[
    Icons.home,
    Icons.search,
    Icons.add,
    Icons.favorite,
  ];

  final pageList = [
    const Dashboard(),
    const AllStocks(),
    const NewsSection(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
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
              return pageList[_currentIndex];
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
      bottomNavigationBar: SalomonBottomBar(
        itemShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Dashboard"),
            selectedColor: Colors.yellow,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.list_alt_rounded),
            title: const Text("All Stocks"),
            selectedColor: Colors.pink,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.newspaper),
            title: const Text("News"),
            selectedColor: Colors.orange,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.settings),
            title: const Text("Settings"),
            selectedColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}
