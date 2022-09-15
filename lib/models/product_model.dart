import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class Product extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String category;
  @HiveField(3)
  final String imageUrl;
  @HiveField(4)
  final double price;
  @HiveField(5)
  final bool isReccomended;
  @HiveField(6)
  final bool isPopular;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.isReccomended,
    required this.isPopular,
  });

  static Product fromSnapshot(DocumentSnapshot snap) {
    Product product = Product(
        id: snap.id,
        name: snap['name'],
        category: snap['category'],
        imageUrl: snap['imageUrl'],
        price: snap['price'],
        isReccomended: snap['isReccomended'],
        isPopular: snap['isPopular']);
    return product;
  }

  @override
  List<Object> get props =>
      [id, name, category, imageUrl, price, isPopular, isReccomended];

  static List<Product> products = [
    Product(
      id: '0',
      name: 'Soft Drink #1',
      category: 'Soft Drinks',
      imageUrl:
          'https://images.unsplash.com/photo-1610873167013-2dd675d30ef4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTl8fHNvZnQlMjBkcmlua3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=1100&q=60',
      price: 2.99,
      isReccomended: true,
      isPopular: false,
    ),
    Product(
      id: '1',
      name: 'Soft Drink #2',
      category: 'Soft Drinks',
      imageUrl:
          'https://images.unsplash.com/photo-1603394630850-69b3ca8121ca?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
      price: 2.99,
      isReccomended: false,
      isPopular: true,
    ),
    Product(
      id: '2',
      name: 'Soft Drink #3',
      category: 'Soft Drinks',
      imageUrl:
          'https://images.unsplash.com/photo-1598038990523-32bcaa29f679?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
      price: 2.99,
      isReccomended: false,
      isPopular: false,
    ),
    Product(
      id: '3',
      name: 'Smoothies #1',
      category: 'Smoothies',
      imageUrl:
          'https://images.unsplash.com/photo-1502741224143-90386d7f8c82?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1469&q=80',
      price: 2.99,
      isReccomended: true,
      isPopular: false,
    ),
    Product(
      id: '4',
      name: 'Smoothies #2',
      category: 'Smoothies',
      imageUrl:
          'https://images.unsplash.com/photo-1483918793747-5adbf82956c4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
      price: 2.99,
      isReccomended: false,
      isPopular: true,
    ),
    Product(
      id: '5',
      name: 'Smoothies #3',
      category: 'Smoothies',
      imageUrl:
          'https://images.unsplash.com/photo-1638176066359-7bcd6289c9d8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
      price: 2.99,
      isReccomended: false,
      isPopular: false,
    ),
    Product(
      id: '6',
      name: 'Water #1',
      category: 'Waters',
      imageUrl:
          'https://images.unsplash.com/photo-1633949698015-0f8a8b261c07?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
      price: 2.99,
      isReccomended: true,
      isPopular: false,
    ),
  ];
}
