import 'package:flutter/material.dart';
import 'package:infinity_box_task/features/login/view/login_screen.dart';
import 'package:infinity_box_task/features/product_details.dart/view/product_details_screen.dart';
import 'package:infinity_box_task/features/product_list.dart/view/product_list_screen.dart';

import 'package:infinity_box_task/utils/logger.dart';

class RouteGenerator {
  static const initialRoute = ProductListScreen.id;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as dynamic;
    log<RouteGenerator>(msg: "Pushed ${settings.name}(${args ?? ''})");
    switch (settings.name) {
      case LoginScreen.id:
        return _route(LoginScreen());
      case ProductListScreen.id:
        return _route(ProductListScreen());
      case ProductDetailsScreen.id:
        return _route(ProductDetailsScreen(
          product: args['product'],
        ));

      default:
        return _errorRoute(settings.name);
    }
  }

  static MaterialPageRoute _route(Widget widget) => MaterialPageRoute(
        builder: (_) => widget,
      );

  static Route<dynamic> _errorRoute(String? name) {
    return _route(
      Scaffold(
        body: Center(
          child: Text('ROUTE\n\n$name\n\nNOT FOUND'),
        ),
      ),
    );
  }
}
