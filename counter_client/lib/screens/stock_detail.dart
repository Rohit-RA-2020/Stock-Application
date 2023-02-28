import 'package:counter_client/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/provider.dart';

class StockDetail extends ConsumerWidget {
  const StockDetail({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stock = ref.watch(stocksListProvider);
    return Scaffold(
      bottomSheet: Container(
        height: 90,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF1C1C1A),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Available for buying',
                  style: GoogleFonts.robotoMono(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D2B32),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D2B32),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          stock[index].name,
                          style: GoogleFonts.robotoMono(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          stock[index].symbol,
                          style: GoogleFonts.robotoMono(
                            color: Colors.grey.shade600,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    // leave the space empty
                    const SizedBox(width: 60),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Hero(
                tag: 'image$index',
                child: Image.network(
                  stock[index].image,
                  height: 100,
                ),
              ),
              const SizedBox(height: 20),
              // Add Price
              Text(
                '₹ ${stock[index].price}.000',
                style: GoogleFonts.robotoMono(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                stock[index].status.toString(),
                style: GoogleFonts.robotoMono(
                  color: Colors.grey.shade500,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              LineChartWidget(index: index),
            ],
          ),
        ),
      ),
    );
  }
}
