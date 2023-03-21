import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class MyStocksList extends ConsumerWidget {
  MyStocksList({
    super.key,
  });

  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
        child: StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('portfolio')
          .doc(userId)
          .snapshots(),
      builder: (context, portfolioSnapshot) {
        if (portfolioSnapshot.data == null) {
          return const Center(
            child: Text(
              'Try Adding some Stocks',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        } else if (portfolioSnapshot.connectionState ==
            ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (portfolioSnapshot.hasError) {
          return Center(
            child: Text(
              'Try Adding some Stocks',
              style: GoogleFonts.robotoMono(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: portfolioSnapshot.data!['stocks'].length,
            itemBuilder: (context, index) {
              String docid = portfolioSnapshot.data!['stocks'][index]['name'];
              return FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('stocks')
                    .doc(docid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return GestureDetector(
                    onTap: () {
                      // Remove the stock from the portfolio
                      // FirebaseFirestore.instance
                      //     .collection('portfolio')
                      //     .doc(userId)
                    },
                    child: SizedBox(
                      height: 100,
                      child: Card(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 60,
                              height: 60,
                              child: CachedNetworkImage(
                                imageUrl: snapshot.data!['image'],
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data!['name'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  snapshot.data!['symbol'],
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '\$ ${snapshot.data!['price'].toString()}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    index % 2 == 0
                                        ? const Padding(
                                            padding:
                                                EdgeInsets.only(right: 2.0),
                                            child: Icon(
                                              Icons
                                                  .arrow_drop_down_circle_outlined,
                                              color: Colors.red,
                                            ),
                                          )
                                        : const Padding(
                                            padding:
                                                EdgeInsets.only(right: 2.0),
                                            child: RotatedBox(
                                              quarterTurns: -2,
                                              child: Icon(
                                                Icons
                                                    .arrow_drop_down_circle_outlined,
                                                color: Colors.green,
                                              ),
                                            ),
                                          )
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(0.0),
                                      child: Text(
                                        'Units bought:',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        portfolioSnapshot.data!['stocks'][index]
                                                ['volume']
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        }
      },
    ));
  }
}
