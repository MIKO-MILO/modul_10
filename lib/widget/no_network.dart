import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modul_10/utils/app_color.dart';

class NoNetwork extends StatelessWidget {
  final Function? onInit;
  const NoNetwork({super.key, required this.onInit});
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
          const Icon(Icons.wifi_off, size: 150, color: Color(0xffffca54)),
          const SizedBox(height: 20),
          Text(
            "Terputus",
            style: GoogleFonts.tajawal(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: AppColor.primary,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Text(
              "Maaf, koneksi internet tidak tersedia, periksa koneksi internet Anda dan coba lagi",
              style: GoogleFonts.cairo(color: AppColor.secondary),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 52,
            width: 160,
            child: ElevatedButton(
              onPressed: () async {
                if (onInit != null) {
                  await onInit!();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffffca54),
              ),
              child: Text("Muat Ulang", style: GoogleFonts.cairo(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
