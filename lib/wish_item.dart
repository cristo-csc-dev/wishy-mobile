import 'package:flutter/material.dart';
import 'wish.dart';

class WishItem extends StatelessWidget {
  final Wish wish;

  const WishItem({super.key, required this.wish});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(wish.url),
      subtitle: Text((wish.description ?? '') + wish.url),
      trailing: wish.date != null
          ? Text(
              wish.date.toString(),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            )
          : null,
      // Puedes agregar más campos o personalizar el diseño aquí
    );
  }
}