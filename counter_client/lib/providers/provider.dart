import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/stock_model.dart';

final stocksListProvider = StateProvider<List<StocksList>>((ref) => []);
