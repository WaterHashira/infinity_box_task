import 'package:flutter/material.dart';
import 'package:infinity_box_task/features/product_details.dart/model/product.dart';
import 'package:infinity_box_task/features/product_details.dart/view/product_details_screen.dart';
import 'package:infinity_box_task/theme/app_theme.dart';
import 'package:infinity_box_task/utils/route_generator.dart';
import 'package:infinity_box_task/widgets/custom_text_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  Product product = Product(
      3,
      'Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops',
      109.95,
      'Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday',
      "men's clothing",
      'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
      {"rate": 3.9, "count": 120});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      onGenerateRoute: RouteGenerator.generateRoute,
      //initialRoute: RouteGenerator.initialRoute,
      home: ,
    );
  }
}
