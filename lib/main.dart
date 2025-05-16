import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  String? _sharedText;
  static const platform = MethodChannel('com.wishysa.wishy/channel');
    // Añade esta variable para controlar la vista
  bool showWishList = false;
   List<Wish> wishList = [
    Wish(id: 1, title: 'Deseo 1', description: 'Descripción 1', url: 'https://wwww.google.es', date: DateTime.now()),
    Wish(id: 2, title: 'Deseo 2', description: 'Descripción 2', url: 'https://wwww.google.es', date: DateTime.now()),
    Wish(id: 3, title: 'Deseo 3', description: 'Descripción 3', url: 'https://wwww.google.es', date: DateTime.now()),
    Wish(id: 4, title: 'Deseo 4', description: 'Descripción 4', url: 'https://wwww.google.es', date: DateTime.now()),
    Wish(id: 5, title: 'Deseo 5', description: 'Descripción 5', url: 'https://wwww.google.es', date: DateTime.now()),
    Wish(id: 6, title: 'Deseo 6', description: 'Descripción 6', url: 'https://wwww.google.es', date: DateTime.now()),
  ];

  @override
  void initState() {
    super.initState();
    platform.setMethodCallHandler(_handleMethodCalls);
  }

  Future<void> _handleMethodCalls(MethodCall call) async {
    if (call.method == 'onSharedText') {
      setState(() {
        _sharedText = call.arguments as String;
        showWishList = true;
        wishList.insert(
          0,
          Wish(
            id: DateTime.now().millisecondsSinceEpoch,
            title: 'Nuevo deseo',
            description: 'Añadido programáticamente',
            url: _sharedText ?? '',
            date: DateTime.now(),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 248, 187, 237),
        appBar: AppBar(
          title: const Text('Wish list'),
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        drawer: Drawer(
          child: Builder(
            builder: (navigationContext) => ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    'Menú Lateral',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Inicio'),
                  onTap: () {
                    Navigator.pop(navigationContext);
                    setState(() {
                      showWishList = false;
                    });
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.favorite),
                  title: const Text('Mis deseos'),
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
                  title: const Text('Es para...'),
                  onTap: () {
                    Navigator.pop(navigationContext);
                    showWishList = false;
                    // Acción para "Es para..."
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: const Text('Calendario'),
                  onTap: () {
                    Navigator.pop(context);
                    // Acción para "Calendario"
                  },
                ),
              ],
            ),
          ),
        ),
        body: showWishList
            ? FiveItemsList(
                items: wishList,
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