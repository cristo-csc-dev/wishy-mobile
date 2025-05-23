import 'package:flutter/material.dart';
import 'package:wishy/app_colors.dart';
import 'package:wishy/wish.dart';
import 'package:wishy/wish_item.dart';

class FiveItemsList extends StatelessWidget {
  final List<Wish> items;

  const FiveItemsList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    // Calcula la altura de cada ítem para que quepan 5 en la pantalla
    final double itemHeight = MediaQuery.of(context).size.height / 5;

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return SizedBox(
          height: itemHeight,
          width: double.infinity,
          child: Card(
            color: sideMenuBackgroundColor, // Fondo magenta claro
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: WishItem(wish: items[index]),
          ),
        );
      },
    );
  }
}

class WishList  {

  List<Wish> wishList = [];

  static final WishList _instance = WishList._internal();
  WishList._internal();

  factory WishList() {
    return _instance;
  }

  get items => wishList;

}