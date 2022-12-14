import 'package:e_commercey/models/product_model.dart';
import 'package:e_commercey/repositories/local_storage/base_storage_repository.dart';
import 'package:hive/hive.dart';

class LocalStorageRepository extends BasedLocalStorageRpository {
  String boxName = 'wishlist_products';

  @override
  Future<Box> openBox() async {
    Box box = await Hive.openBox<Product>(boxName);
    return box;
  }

  @override
  List<Product> getWishList(Box box) {
    return box.values.toList() as List<Product>;
  }

  @override
  Future<void> addProductToWishlist(Box box, Product product) async {
    await box.put(product.id, product);
  }

  @override
  Future<void> removeProductFromWishlist(Box box, Product product) async {
    await box.delete(product.id);
  }

  @override
  Future<void> clearWishlist(Box box) async {
    await box.clear();
  }
}
