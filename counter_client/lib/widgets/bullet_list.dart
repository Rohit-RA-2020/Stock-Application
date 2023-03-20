import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/provider.dart';

class BulletList extends ConsumerWidget {
  final List<String> strings;

  const BulletList(this.strings, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(25, 15, 16, 25),
      child: ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: strings.map((str) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\u2022',
                style: GoogleFonts.robotoMono(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  str,
                  textAlign: TextAlign.left,
                  softWrap: true,
                  style: GoogleFonts.robotoMono(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: ref.read(darkModeProvider)
                        ? const Color.fromARGB(255, 245, 188, 188)
                        : const Color.fromARGB(255, 240, 89, 89),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
