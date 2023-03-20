import 'package:cached_network_image/cached_network_image.dart';
import 'package:counter_client/screens/news_section.dart';
import 'package:counter_client/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../providers/provider.dart';

class StockDetail extends ConsumerStatefulWidget {
  const StockDetail({
    super.key,
    required this.docId,
  });

  final String docId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StockDetailState();
}

class _StockDetailState extends ConsumerState<StockDetail> {
  // get doc with id
  DocumentSnapshot? doc;

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('stocks')
        .doc(widget.docId)
        .get()
        .then((value) => {doc = value});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final stock = ref.watch(stocksListProvider);
    return doc == null
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
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
                      // Add two buttons
                      SizedBox(
                        height: 100,
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: Text(
                            'Buy',
                            style: GoogleFonts.robotoMono(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: Text(
                            'Sell',
                            style: GoogleFonts.robotoMono(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
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
                        ),
                        Column(
                          children: [
                            Text(
                              doc!['name'],
                              style: GoogleFonts.robotoMono(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              doc!['symbol'],
                              style: GoogleFonts.robotoMono(
                                color: Colors.grey.shade600,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        // leave the space empty
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NewsSection(stock: stock[1].symbol),
                              ),
                            );
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: const Color(0xFF2D2B32),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: const Icon(
                              Icons.newspaper,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Hero(
                      tag: widget.docId,
                      child: CachedNetworkImage(
                        imageUrl: doc!['image'],
                        height: 90,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '\$${doc!['price']} ',
                      style: GoogleFonts.robotoMono(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '52 Week high: ',
                              style: GoogleFonts.robotoMono(
                                color: Colors.grey.shade600,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              '\$${doc!['high']}',
                              style: GoogleFonts.robotoMono(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '52 Week low: ',
                              style: GoogleFonts.robotoMono(
                                color: Colors.grey.shade600,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              '\$${doc!['low']}',
                              style: GoogleFonts.robotoMono(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Units Available: ',
                              style: GoogleFonts.robotoMono(
                                color: Colors.grey.shade600,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              doc!['volume'].toString(),
                              style: GoogleFonts.robotoMono(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    const LineChartWidget(index: 1),
                  ],
                ),
              ),
            ),
          );
  }
}
