import 'dart:developer';

import 'package:wishy/client/firebase_store/wishes_store.dart';
import 'package:wishy/dao/wish_db.dart';
import 'package:wishy/wish.dart';

void storeAndSync(Wish wish) async {

  WishesStore.addWish(wish).then((addedWish) {
    WishDao().updateWish(wish);
    log('Deseo añadido a Firestore: ${addedWish.title}');
  }).catchError((error) {
    log('Error al añadir el deseo a Firestore: $error');
  });
}