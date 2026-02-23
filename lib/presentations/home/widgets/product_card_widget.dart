import 'package:e_commerce_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String? image;
  final String? title;
  final double? price;
  const ProductCard({this.image, this.title, this.price, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                image ?? "",
                fit: BoxFit.contain,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppColors.primary14medium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "\$${price?.toStringAsFixed(2) ?? "0.00"}",
                  style: AppColors.primary14light,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
