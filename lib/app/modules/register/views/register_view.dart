import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modul_10/utils/app_color.dart';
import 'package:modul_10/widget/custom_input.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              height: MediaQuery.of(context).size.height * 30 / 100,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppColor.darkBlue,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 20,
                    top: 40,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () => Get.back(),
                    ),
                  ),
                  Positioned(
                    right: -30,
                    top: -30,
                    child: Icon(
                      Icons.person_add_rounded,
                      size: 180,
                      color: Colors.white.withAlpha(20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 32, bottom: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Daftar Akun",
                          style: GoogleFonts.poppins(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          "Bergabunglah dengan NEWZIA",
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Form Section
            Container(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Buat Akun Baru",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColor.darkBlue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Lengkapi data di bawah ini untuk mendaftar",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: AppColor.secondarySoft,
                    ),
                  ),
                  const SizedBox(height: 32),

                  CustomInput(
                    controller: controller.nameC,
                    label: "Nama Lengkap",
                    hint: "Masukkan nama lengkap Anda",
                  ),

                  CustomInput(
                    controller: controller.emailC,
                    label: "Email",
                    hint: "Masukkan email aktif Anda",
                  ),

                  Obx(
                    () => CustomInput(
                      controller: controller.passC,
                      label: "Kata Sandi",
                      hint: "*************",
                      obscureText: controller.obscureText.value,
                      margin: const EdgeInsets.only(bottom: 40),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.obscureText.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColor.secondarySoft,
                          size: 20,
                        ),
                        onPressed: () {
                          controller.obscureText.value =
                              !controller.obscureText.value;
                        },
                      ),
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: Obx(
                      () => ElevatedButton(
                        onPressed: () {
                          if (!controller.isLoading.value) {
                            controller.registration();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.darkBlue,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          controller.isLoading.value
                              ? "Memproses..."
                              : "Daftar Sekarang",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sudah punya akun? ",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: AppColor.secondarySoft,
                        ),
                      ),
                      InkWell(
                        onTap: () => Get.back(),
                        child: Text(
                          "Masuk",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: AppColor.accentRed,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
