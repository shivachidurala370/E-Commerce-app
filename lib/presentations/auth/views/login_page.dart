import 'package:e_commerce_app/core/common_widgets/custom_button.dart';
import 'package:e_commerce_app/core/constants/app_colors.dart';
import 'package:e_commerce_app/presentations/auth/views/otp_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _loading = false;

  void _logIn() async {
    String phone = _phoneController.text.trim();
    setState(() {
      _loading = true;
    });
    await Future.delayed(const Duration(seconds: 1));

    if (phone.length == 10 && RegExp(r'^[0-9]+$').hasMatch(phone)) {
      // Navigate to OTP Page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OtpPage(phoneNumber: phone)),
      );
      _phoneController.clear();
    } else {
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter valid 10 digit mobile number"),
        ),
      );
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
        top: true,
        bottom: true,
        child: Scaffold(
          body: Container(
            height: MediaQuery.sizeOf(context).height,
            width: double.infinity,
            decoration: BoxDecoration(color: AppColors.whiteColor),
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height * 0.76,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    image: DecorationImage(
                      image: AssetImage("assets/images/login_bg.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 26,
                      left: 20,
                      right: 20,
                    ),
                    height: MediaQuery.sizeOf(context).height * 0.32,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 10,
                          offset: const Offset(0, -10),
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      spacing: 20,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Log In or Sign Up", style: AppColors.black20bold),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          height: MediaQuery.sizeOf(context).height * 0.06,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            spacing: 10,
                            children: [
                              Icon(
                                Icons.phone,
                                color: Colors.grey.shade600,
                                size: 18,
                              ),
                              Container(
                                height: 20,
                                width: 1,
                                color: Colors.grey.shade400,
                              ),
                              Expanded(
                                child: TextField(
                                  style: AppColors.black14medium,
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                  maxLength: 10,
                                  decoration: InputDecoration(
                                    counterText: "",
                                    hintText: "Enter your mobile number",
                                    border: InputBorder.none,
                                    hintStyle: AppColors.grey14medium,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        _loading
                            ? const CircularProgressIndicator(
                                color: Color(0xFF53482A),
                              )
                            : CustomButton(text: "Continue", onPressed: _logIn),

                        Expanded(
                          child: Text(
                            "By continuing, you agree to our Terms of Service\nand Privacy Policy",
                            textAlign: TextAlign.center,
                            style: AppColors.grey12medium,
                          ),
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
    );
  }
}
