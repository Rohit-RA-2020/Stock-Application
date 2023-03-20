import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';


class MyStocksList extends ConsumerWidget {
  const MyStocksList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Hero(
                        tag: 'image$index',
                        child: Image.network(
                          'https://www.freepnglogos.com/uploads/company-logo-png/company-logo-transparent-png-19.png',
                          height: 60,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sample Stock',
                            style: GoogleFonts.robotoMono(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'SPLE',
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
                            '\$ 100',
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '90%',
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
