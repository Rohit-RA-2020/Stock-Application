import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import '../stock_detail.dart';

class AllStocks extends ConsumerStatefulWidget {
  const AllStocks({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<AllStocks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'All Stocks',
          style: GoogleFonts.robotoMono(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('stocks').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StockDetail(
                          docId: snapshot.data!.docs[index].id,
                        ),
                      ),
                    );
                  },
                  child: SizedBox(
                    height: 120,
                    child: Card(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 90,
                            height: 90,
                            child: Hero(
                              tag: snapshot.data!.docs[index].id,
                              child: CachedNetworkImage(
                                imageUrl: snapshot.data!.docs[index]['image'],
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data!.docs[index]['name'],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                snapshot.data!.docs[index]['symbol'],
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '\$ ${snapshot.data!.docs[index]['price'].toString()}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )),
    );
  }
}
