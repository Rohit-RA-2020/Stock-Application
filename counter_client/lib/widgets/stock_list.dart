import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';
import '../providers/provider.dart';
import '../screens/stock_detail.dart';

class MyStocksList extends ConsumerWidget {
  const MyStocksList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stocksList = ref.watch(stocksListProvider);
    return Center(
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => StockDetail(index: index),
              //   ),
              // );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: stockColors[index],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Hero(
                        tag: 'image$index',
                        child: Image.network(
                          stocksList[index].image,
                          height: 60,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            stocksList[index].name,
                            style: GoogleFonts.robotoMono(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            stocksList[index].symbol,
                            style: GoogleFonts.robotoMono(
                              color: Colors.grey.shade700,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '₹ ${stocksList[index].price}',
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            stocksList[index].status.toString(),
                            style: GoogleFonts.robotoMono(
                              color: Colors.grey.shade700,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
