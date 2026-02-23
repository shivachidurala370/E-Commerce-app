import 'package:e_commerce_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String? text;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;

  const CustomButton({super.key, this.onPressed, this.text, this.textStyle});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onPressed?.call(),
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.064,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            widget.text ?? "",
            style: widget.textStyle ?? AppColors.white16medium,
          ),
        ),
      ),
    );
  }
}
