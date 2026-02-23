import 'package:e_commerce_app/presentations/home/models/list_products_model.dart';
import 'package:e_commerce_app/presentations/home/repository/home_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProvider = Provider<HomeRepo>((ref) {
  return HomeRepo();
});


final productsProvider = FutureProvider<List<ProductsModel>>((ref) async {
  final homeRepo = ref.read(homeProvider);
  return await homeRepo.getProducts();
});