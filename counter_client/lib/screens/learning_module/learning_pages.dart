import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../providers/provider.dart';
import '../../widgets/bullet_list.dart';

class Keywords extends ConsumerWidget {
  const Keywords({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
        Text(
          'Some Common keywords used in Stock Market Trading',
          style: GoogleFonts.robotoMono(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: ref.read(darkModeProvider)
                ? const Color.fromARGB(255, 245, 188, 188)
                : const Color.fromARGB(255, 240, 89, 89),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        LottieBuilder.asset(
          'assets/lottie/keywords.json',
          width: 300,
          height: 300,
        ),
        const Expanded(
          child: BulletList([
            'Open Price: The price at which a stock opens for trading at the beginning of a trading day.',
            'Closing Price: The price at which a stock closes at the end of a trading day.',
            'High Price: The highest price at which a stock has traded during the trading day.',
            'Low Price: The lowest price at which a stock has traded during the trading day.',
            'Volume: The number of shares traded during the trading day.',
            'Market Capitalization: The total value of a company’s outstanding shares.',
            'Market Cap: The total value of a company’s outstanding shares.',
            'EPS: Earnings per share is the portion of a company’s profit allocated to each outstanding share of common stock.',
            'P/E Ratio: The price-to-earnings ratio is the ratio for valuing a company that measures its current share price relative to its per-share earnings.',
            'Dividend: A dividend is a distribution of a portion of a company’s earnings, decided by the board of directors, to a class of its shareholders.',
          ]),
        ),
      ],
    );
  }
}

class InvestTechnique extends ConsumerWidget {
  const InvestTechnique({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
        Text(
          'Common Strategies Used in Stock Market Trading',
          style: GoogleFonts.robotoMono(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: ref.read(darkModeProvider)
                ? const Color.fromARGB(255, 245, 188, 188)
                : const Color.fromARGB(255, 240, 89, 89),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        LottieBuilder.asset(
          'assets/lottie/strat.json',
          width: 300,
          height: 300,
        ),
        const Expanded(
          child: BulletList([
            'Value Investing: This strategy involves finding undervalued stocks that are trading below their intrinsic value and holding them for the long term',
            'Growth Investing: This strategy involves investing in companies that are expected to grow at a faster rate than the overall market.',
            'Momentum Investing: This strategy involves buying stocks that are showing strong upward momentum, and selling them when they start to decline.',
            'Index Investing: This strategy involves investing in an index fund that tracks a specific market index like the S&P 500, providing a diversified exposure to the entire market'
          ]),
        ),
      ],
    );
  }
}

class HowInvest extends ConsumerWidget {
  const HowInvest({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
        Text(
          'How to invest in Stock Market?',
          style: GoogleFonts.robotoMono(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: ref.read(darkModeProvider)
                ? const Color.fromARGB(255, 245, 188, 188)
                : const Color.fromARGB(255, 240, 89, 89),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        LottieBuilder.asset(
          'assets/lottie/how.json',
          width: 300,
          height: 300,
        ),
        const Expanded(
          child: BulletList([
            'Individual Stocks: You can buy individual stocks of companies that you believe will perform well in the future.This requires a lot of research and analysis, as well as a strong understanding of the market.',
            'Mutual Funds: Mutual funds are professionally managed investment portfolios that pool money from multiple investors to invest in a diversified set of stocks. This is a good option for those who do not have the time or knowledge to manage their own investments.',
            'Exchange Traded Funds (ETFs): ETFs are similar to mutual funds but are traded like individual stocks on the stock exchange.'
          ]),
        ),
      ],
    );
  }
}

class WhyInvest extends ConsumerWidget {
  const WhyInvest({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
        Text(
          'Why Invest in Stocks Market?',
          style: GoogleFonts.robotoMono(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: ref.read(darkModeProvider)
                ? const Color.fromARGB(255, 245, 188, 188)
                : const Color.fromARGB(255, 240, 89, 89),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        LottieBuilder.asset(
          'assets/lottie/why.json',
          width: 300,
          height: 300,
        ),
        const Expanded(
          child: BulletList([
            'High Returns: Historically, the stock market has provided higher returns than other investment options like fixed deposits or bonds.',
            'Ownership in Companies: Investing in stocks allows you to own a small portion of a company, which can give you the right to vote on important decisions like electing board members',
            'Liquidity: The stock market is highly liquid, which means you can easily buy and sell stocks whenever you want',
            'Diversification: Investing in stocks allows you to diversify your portfolio, which can help you reduce the risk of losing all your money in case of a market downturn',
          ]),
        ),
      ],
    );
  }
}

class WhatStock extends ConsumerWidget {
  const WhatStock({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
        Text(
          'What is Stock Market?',
          style: GoogleFonts.robotoMono(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: ref.read(darkModeProvider)
                ? const Color.fromARGB(255, 245, 188, 188)
                : const Color.fromARGB(255, 240, 89, 89),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        LottieBuilder.asset(
          'assets/lottie/stock.json',
          width: 300,
          height: 300,
        ),
        Text(
          'The stock market is a platform where companies list their shares for public trading. It is a place where investors can buy and sell stocks, which represent ownership in a company. The stock market is a vital component of any economy, as it allows companies to raise funds for growth and expansion, while providing investors with the opportunity to earn profits from their investments.',
          style: GoogleFonts.robotoMono(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: ref.read(darkModeProvider)
                ? const Color.fromARGB(255, 245, 188, 188)
                : const Color.fromARGB(255, 240, 89, 89),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
