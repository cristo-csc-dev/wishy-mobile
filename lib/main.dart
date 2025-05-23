import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wishy/dao/wish_db.dart';
import 'app_colors.dart';
import 'wish_list.dart';
import 'wish.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String _sharedLink = "{}";
  static const platform = MethodChannel('com.wishysa.wishy/channel');
    // Añade esta variable para controlar la vista
  bool showWishList = false;
  List<Wish> wishListItems = [];

  @override
  void initState() {
    super.initState();
    // WishDao().deleteAllWishes();
    platform.setMethodCallHandler(_handleMethodCalls);
  }

  Future<void> _handleMethodCalls(MethodCall call) async {
    if (call.method == 'onSharedText') {
      _sharedLink = call.arguments;
      final Map<String, dynamic> jsonData = jsonDecode(_sharedLink);
      WishDao().insertWish(Wish(
        title: jsonData['title'] ?? '',
        url: jsonData['link'] ?? '',
        description: jsonData['subject'] ?? '',
        date: DateTime.now(),
      ));
      wishListItems = await WishDao().getWishes();
      setState(() {
       showWishList = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: headersColor,
          title: const Text(
            'Wish list',
            style: TextStyle(
              color: backgroundColor,
              fontWeight: FontWeight.bold,
            ),
          ),
            leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: backgroundColor),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        drawer: Drawer(
          backgroundColor: sideMenuBackgroundColor,
          child: Builder(
            builder: (navigationContext) => ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: headersColor,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.favorite, // Elige el icono que prefieras
                      color: sideMenuBackgroundColor,
                      size: 64, // Tamaño grande
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.favorite),
                  title: const Text('Para mí'),
                  onTap: () {
                    Navigator.pop(navigationContext);
                    setState(() {
                      showWishList = true;
                    });
                    // Acción para "Mis deseos"
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.card_giftcard),
                  title: const Text('Para...'),
                  onTap: () {
                    Navigator.pop(navigationContext);
                    setState(() {
                      showWishList = false;
                    });
                    // Acción para "Es para..."
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: const Text('Eventos'),
                  onTap: () {
                    Navigator.pop(navigationContext);
                    setState(() {
                      showWishList = false;
                    });
                    // Acción para "Calendario"
                  },
                ),
              ],
            ),
          ),
        ),
        body: showWishList
            ? Padding(
              padding: const EdgeInsets.only(top: 16),
                child: FiveItemsList(
                  items: wishListItems,
                )
              )
            : const Center(
                child: Text('Contenido principal'),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Acción del botón flotante
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}