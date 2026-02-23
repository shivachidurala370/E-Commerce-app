import 'package:e_commerce_app/core/common_widgets/custom_button.dart';
import 'package:e_commerce_app/core/constants/app_colors.dart';
import 'package:e_commerce_app/presentations/home/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class OtpPage extends StatefulWidget {
  final String phoneNumber;

  const OtpPage({super.key, required this.phoneNumber});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  OtpFieldController otpController = OtpFieldController();
  // final _focusNode = FocusNode();
  bool _loading = false;
  String enteredOtp = "";

  void _verifyOtp() async {
    setState(() {
      _loading = true;
    });
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));
    if (enteredOtp == "1234") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false,
      );
      otpController.clear();
    } else {
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Invalid OTP")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: SafeArea(
        bottom: true,
        top: true,
        child: Scaffold(
          backgroundColor: const Color(0xFFF4ECE9),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Center(
                    child: Image.asset(
                      "assets/images/otp.png",
                      height: MediaQuery.of(context).size.height * 0.24,
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "Verify Your Account",
                          style: AppColors.primary22bold,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Enter the 4-digit code sent to ${widget.phoneNumber}",
                          textAlign: TextAlign.center,
                          style: AppColors.primary14light,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: OTPTextField(
                      length: 4,
                      fieldWidth: 66,
                      style: AppColors.primary22bold.copyWith(fontSize: 30),
                      controller: otpController,
                      textFieldAlignment: MainAxisAlignment.spaceBetween,
                      fieldStyle: FieldStyle.box,
                      outlineBorderRadius: 10,
                      keyboardType: TextInputType.number,
                      otpFieldStyle: OtpFieldStyle(
                        backgroundColor: Colors.white,
                        borderColor: const Color(0xFF53482A),
                        focusBorderColor: const Color(0xFF53482A),
                        enabledBorderColor: Colors.grey.shade300,
                      ),
                      onCompleted: (pin) {
                        enteredOtp = pin; // ✅ Store entered OTP
                      },
                    ),
                  ),

                  /// ✅ OTP FIELD ADDED HERE
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                  _loading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        )
                      : CustomButton(text: "Verify OTP", onPressed: _verifyOtp),
                  const SizedBox(height: 16),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "Didn't receive the code? ",
                        style: AppColors.grey14medium,
                        children: [
                          TextSpan(
                            text: "Resend Code",
                            style: AppColors.primary14medium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
