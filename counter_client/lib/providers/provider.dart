import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/stock_model.dart';

final stocksListProvider = StateProvider<List<StocksList>>((ref) => []);

// add a dark mode provider
final darkModeProvider = StateNotifierProvider<DarkModeProvider, bool>((ref) {
  return DarkModeProvider();
});

class DarkModeProvider extends StateNotifier<bool> {
  DarkModeProvider() : super(true);

  void toggleDarkMode() {
    state = !state;
  }
}
