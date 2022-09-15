import 'package:hive/hive.dart';

import '../../models/product_model.dart';

abstract class BasedLocalStorageRpository {
  Future<Box> openBox();
  List<Product> getWishList(Box box);
  Future<void> addProductToWishlist(Box box, Product product);
  Future<void> removeProductFromWishlist(Box box, Product product);
  Future<void> clearWishlist(Box box);
}
