import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wishy/wish.dart';

final firestore = FirebaseFirestore.instance;

class WishesStore {
  // Singleton pattern
  static final WishesStore _instance = WishesStore._internal();

  factory WishesStore() {
    return _instance;
  }

  WishesStore._internal();

  // Firestore instance
static final wishesRef = FirebaseFirestore.instance
  .collection('wishes')
  .withConverter<Wish>(
    fromFirestore: (snapshot, _) => Wish.fromJson(snapshot.data()!),
    toFirestore: (wish, _) => wish.toJson(),
  );

  // Method to add a wish
  static Future<Wish> addWish(Wish wish) async {
    DocumentReference<Wish> docReference = await wishesRef.add(wish);
    wish.docId = docReference.id;
    return wish;
  }
}
