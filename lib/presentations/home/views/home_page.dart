import 'package:e_commerce_app/core/constants/app_colors.dart';
import 'package:e_commerce_app/presentations/home/view_model/home_provider.dart';
import 'package:e_commerce_app/presentations/home/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(productsProvider);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: SingleChildScrollView(
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(height: 24),
                  _buildHeader(),
                  SizedBox(height: 10),
                  _buildSearchField(context, searchcontroller),
                  SizedBox(height: 10),
                  _buildDiscountBanner(context),

                  SizedBox(height: 4),
                  Text("Featured Collection", style: AppColors.primary20bold),
                  SizedBox(height: 6),
                  productsAsync.when(
                    data: (products) => GridView.builder(
                      padding: EdgeInsets.only(bottom: 16),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) => ProductCard(
                        image: products[index].image,
                        title: products[index].title,
                        price: products[index].price,
                      ),
                    ),
                    loading: () => Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    error: (err, stack) => Center(child: Text("Error: $err")),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hii User", style: AppColors.primary22bold),
            SizedBox(height: 4),
            Text("Welcome Back", style: AppColors.primary14light),
          ],
        ),
        CircleAvatar(
          radius: 30,
          backgroundColor: Color(0xFF53482A),
          child: Text(
            "U",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField(
    BuildContext context,
    TextEditingController searchcontroller,
  ) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.05,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: searchcontroller,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search_sharp,
            color: AppColors.primaryColor,
            size: 18,
          ),
          hintText: "Search For Products",
          contentPadding: const EdgeInsets.only(bottom: 4, top: 4),
          hintStyle: AppColors.primary14light,
        ),
        keyboardType: TextInputType.text,
      ),
    );
  }

  Widget _buildDiscountBanner(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.2,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage("assets/images/discount_banner.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
