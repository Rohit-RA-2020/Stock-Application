import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/stock_list.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/profile.png',
                height: 60,
              ),
              const SizedBox(width: 20),
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
                  Icons.library_books_outlined,
                  color: Colors.white,
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Portfolio Balance',
            style: GoogleFonts.robotoMono(
              color: const Color(0xFF67666B),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            '₹ 1,24,790',
            style: GoogleFonts.robotoMono(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFF163632),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    '+12.1%',
                    style: GoogleFonts.robotoMono(
                      color: const Color(0xFF639F6A),
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'for today',
                style: GoogleFonts.robotoMono(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width * 0.44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFC2F640),
                    borderRadius: BorderRadius.circular(45),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(height: 20),
                        const Icon(
                          Icons.arrow_outward_outlined,
                          color: Colors.black,
                          size: 30,
                        ),
                        Text(
                          'Top Up',
                          style: GoogleFonts.robotoMono(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5.0),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width * 0.44,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2C2B30),
                    borderRadius: BorderRadius.circular(45),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(height: 20),
                        Transform.rotate(
                          angle: 3,
                          child: const Icon(
                            Icons.arrow_outward,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        Text(
                          'Withdraw',
                          style: GoogleFonts.robotoMono(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            'Your Stocks',
            style: GoogleFonts.robotoMono(
              color: Colors.grey,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Expanded(child: MyStocksList()),
        ],
      ),
    );
  }
}
