import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model.dart';

final stocksListProvider = StateProvider<List<StocksList>>((ref) => []);
