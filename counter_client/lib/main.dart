import 'package:counter_client/colors.dart';
import 'package:counter_client/providers/provider.dart';
import 'package:counter_client/screens/auth.dart';
import 'package:counter_client/screens/pages/pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'firebase_options.dart';

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

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dm = ref.watch(darkModeProvider);
    return MaterialApp(
      theme: dm ? darkTheme : lightTheme,
      home: FirebaseAuth.instance.currentUser == null
          ? const AuthScreen()
          : const HomePage(),
    );
  }
}

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
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
    const NewsPage(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            selectedColor: Colors.indigo,
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
      body: SafeArea(
        child: pageList[_currentIndex],
      ),
    );
  }
}
