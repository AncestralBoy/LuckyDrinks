import '../../models/model.dart';

abstract class BaseProductRepository {
  Stream<List<Product>> getAllProducts();
}
