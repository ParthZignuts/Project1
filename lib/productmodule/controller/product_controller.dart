import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class ListController {
  User? get _user => FirebaseAuth.instance.currentUser;
  final _firestore = FirebaseFirestore.instance;
//add new wishlist on wishlist collection
  Future<void> addWishlistItem({
    required String title,
    required String priority,
    void Function(String uuid)? onSuccess,
    void Function(dynamic error)? onError,
  }) async {
    try {
      var item = {
        'id': const Uuid().v4(),
        'user_id': _user?.uid ?? '',
        'title': title,
        'priority': priority,
      };

      await _firestore.collection('wishlist').add(item);
      if (onSuccess != null) onSuccess(item['id'] ?? '');
    } catch (e) {
      if (onError != null) onError(e);
    }
  }
//it's use for fetch data from wishlist collection
  Stream<QuerySnapshot<Map<String, dynamic>>> getWishList() => _firestore
      .collection('wishlist')
      .where('user_id', isEqualTo: _user?.uid)
      .snapshots();

//it's for fetch the total quantity and price from product collection
  Stream<Map<String, int>> getTotalQuantityPrice({
    required String wishlistId,
  }) =>
      _firestore
          .collection('product')
          .where('wishlist_id', isEqualTo: wishlistId)
          .snapshots()
          .map((event) {
        var result = {
          'quantity': 0,
          'price': 0,
        };

        for (var element in event.docs) {
          result['quantity'] = result['quantity']! + (element.get('quantity') as int);

          result['price'] = result['price']! +
                ((element.get('price') as int) *
                  (element.get('quantity') as int));
        }

        return result;
      });

  //it's use for increment an decrement product quantity in product collection

  Future<void> increaseDecreaseProductQuantity({
    required String productId,
    required String wishlistId,
    required int price,
    required bool isIncrease,
    void Function(int quantity)? onSuccess,
    void Function(dynamic error)? onError,
  }) async {
    try {
      var snapshot = await _firestore
          .collection('product')
          .where('wishlist_id', isEqualTo: wishlistId)
          .where('id', isEqualTo: productId)
          .get();

      if (snapshot.docs.isEmpty) {
        int quantity = isIncrease ? 1 : 0;

        await _firestore.collection('product').add({
          'id': productId,
          'wishlist_id': wishlistId,
          'quantity': quantity,
          'price': price,
        });

        if (onSuccess != null) onSuccess(quantity);
      } else {
        String id = snapshot.docs.first.id;
        int quantity = snapshot.docs.first.get('quantity');
        isIncrease ? quantity++ : quantity--;
        if (quantity < 0) quantity = 0;

        await _firestore
            .collection('product')
            .doc(id)
            .update({'quantity': quantity});

        if (onSuccess != null) onSuccess(quantity);
      }
    } catch (e) {
      if (onError != null) onError(e);
    }
  }
//it's use for getting total quantity from product collection
  Stream<int> getProductQuantity({
    required String productId,
    required String wishlistId,
  }) =>
      _firestore
          .collection('product')
          .where('wishlist_id', isEqualTo: wishlistId)
          .where('id', isEqualTo: productId)
          .snapshots()
          .map((event) {
        if (event.docs.isEmpty) {
          return 0;
        } else {
          return event.docs.first.get('quantity');
        }
      });
}
