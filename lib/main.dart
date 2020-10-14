import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mycatalog/common/theme.dart';

import 'package:mycatalog/models/cart.dart';
import 'package:mycatalog/models/catalog.dart';

import 'package:mycatalog/screens/login.dart';
import 'package:mycatalog/screens/catalog.dart';
import 'package:mycatalog/screens/cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
        Provider(create: (_) => CatalogModel()),
        // CartModel is implemented as a ChangeNotifier, which calls for the use
        // of ChangeNotifierProvider. Moreover, CartModel depends
        // on CatalogModel, so a Proxy is needed.
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (_) => CartModel(),
          update: (_, catalog, cart) {
            cart.catalog = catalog;
            return cart;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Catalog',
        theme: appTheme,
        routes: {
          '/': (_) => MyLogin(),
          '/catalog': (_) => MyCatalog(),
          '/cart': (_) => MyCart(),
        },
      ),
    );
  }
}
