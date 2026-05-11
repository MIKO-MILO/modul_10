import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoData extends StatelessWidget {
  const NoData({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.inbox, size: 150, color: Color(0xffffca54)),
          const SizedBox(height: 20),
          Text(
            "Data Kosong",
            style: GoogleFonts.tajawal(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: const Color(0xffffca54),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Text(
              "Data dari server masih belum ada nih ...",
              style: GoogleFonts.cairo(color: const Color(0xff777777)),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
