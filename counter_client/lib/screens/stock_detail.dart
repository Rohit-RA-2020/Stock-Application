import 'package:cached_network_image/cached_network_image.dart';
import 'package:counter_client/screens/news_section.dart';
import 'package:counter_client/widgets/chart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

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
  double pricePay = 0.0;
  bool isValid = true;

  final TextEditingController _buyController = TextEditingController();
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('stocks')
          .doc(widget.docId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
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
                      // Add two buttons
                      SizedBox(
                        height: 100,
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            showAnimatedDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return StatefulBuilder(
                                  builder: (BuildContext context,
                                          StateSetter mySetState) =>
                                      AlertDialog(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(32.0))),
                                    contentPadding:
                                        const EdgeInsets.only(top: 10.0),
                                    content: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Buy Stock for ',
                                                style: GoogleFonts.robotoMono(
                                                  fontSize: 18,
                                                  color: Colors.grey.shade500,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                snapshot.data!['name'],
                                                style: GoogleFonts.robotoMono(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Available Units ',
                                                style: GoogleFonts.robotoMono(
                                                  fontSize: 18,
                                                  color: Colors.grey.shade500,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                '${snapshot.data!['volume']} ',
                                                style: GoogleFonts.robotoMono(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Price per unit ',
                                                style: GoogleFonts.robotoMono(
                                                  fontSize: 18,
                                                  color: Colors.grey.shade500,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                '\$ ${snapshot.data!['price']} ',
                                                style: GoogleFonts.robotoMono(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextField(
                                              controller: _buyController,
                                              onChanged: (value) {
                                                mySetState(
                                                  () {
                                                    if (double.parse(value) >
                                                        snapshot
                                                            .data!['volume']) {
                                                      isValid = false;
                                                    } else {
                                                      isValid = true;
                                                    }
                                                    pricePay =
                                                        double.parse(value) *
                                                            snapshot
                                                                .data!['price'];
                                                  },
                                                );
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                hintText:
                                                    'Enter number of units',
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                          ),
                                          // Add a button
                                          ElevatedButton(
                                            onPressed: isValid
                                                ? () {
                                                    // Add a transaction
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            'transactions')
                                                        .add({
                                                      'name': snapshot
                                                          .data!['name'],
                                                      'price': snapshot
                                                          .data!['price'],
                                                      'volume': double.parse(
                                                          _buyController.text),
                                                      'date': DateTime.now(),
                                                      'type': 'buy',
                                                      'user': userId,
                                                    });
                                                    FirebaseFirestore.instance
                                                        .collection('stocks')
                                                        .doc(widget.docId)
                                                        .update({
                                                      'volume': snapshot
                                                              .data!['volume'] -
                                                          double.parse(
                                                              _buyController
                                                                  .text),
                                                    });
                                                    FirebaseFirestore.instance
                                                        .collection('portfolio')
                                                        .doc(userId)
                                                        .update({
                                                      'stocks': FieldValue
                                                          .arrayUnion([
                                                        {
                                                          'id': widget.docId,
                                                          'name': snapshot
                                                              .data!['name'],
                                                          'price': snapshot
                                                              .data!['price'],
                                                          'volume':
                                                              double.parse(
                                                                  _buyController
                                                                      .text),
                                                        }
                                                      ])
                                                    });

                                                    Navigator.pop(context);
                                                  }
                                                : null,
                                            style: ElevatedButton.styleFrom(),
                                            child: Text(
                                              'Pay \$ $pricePay',
                                              style: GoogleFonts.robotoMono(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              animationType:
                                  DialogTransitionType.slideFromBottomFade,
                              curve: Curves.fastOutSlowIn,
                              duration: const Duration(milliseconds: 500),
                            );
                          },
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
                              snapshot.data!['name'],
                              style: GoogleFonts.robotoMono(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              snapshot.data!['symbol'],
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
                                    NewsSection(stock: snapshot.data!['name']),
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
                        imageUrl: snapshot.data!['image'],
                        height: 90,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '\$${snapshot.data!['price']}',
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
                              snapshot.data!['high'].toString(),
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
                              snapshot.data!['low'].toString(),
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
                              snapshot.data!['volume'].toString(),
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
      },
    );
  }
}
