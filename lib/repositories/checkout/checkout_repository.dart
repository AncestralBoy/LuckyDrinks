import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commercey/models/checkout_model.dart';
import 'package:e_commercey/repositories/checkout/base_checkout_repository.dart';
import 'package:firebase_core/firebase_core.dart';

class CheckoutRepository extends BaseCheckoutRepository {
  final FirebaseFirestore _firebaseFirestore;
  CheckoutRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> addCheckout(Checkout checkout) {
    throw _firebaseFirestore.collection('checkout').add(checkout.toDocument());
  }
}
