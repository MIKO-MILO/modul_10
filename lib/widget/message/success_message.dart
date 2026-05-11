import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showSuccessMessage(String message) {
  BotToast.showCustomText(
    align: Alignment.center,
    toastBuilder: (close) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          color: Colors.black.withAlpha((0.45 * 255).toInt()),
          alignment: Alignment.center,
          child: Container(
            width: 300,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha((0.5 * 255).toInt()),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Green Bar
                Container(
                  height: 70,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xff90b06e),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(6),
                  child: const Icon(
                    Icons.check_circle_outline,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                // Title
                Container(
                  height: 56,
                  alignment: Alignment.center,
                  child: Text(
                    "Berhasil",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      color: const Color(0xFF52575f),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Message
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                  width: double.infinity,
                  child: Text(
                    message,
                    style: GoogleFonts.poppins(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
                // Close Button
                Container(
                  height: 44,
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: OutlinedButton(
                    onPressed: close,
                    child: Text(
                      "Oke",
                      style: GoogleFonts.poppins(
                        color: const Color(0xff90b06e),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
    duration: null,
    onClose: () {},
    onlyOne: false,
  );
}
