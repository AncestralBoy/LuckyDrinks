import 'package:e_commercey/models/category_model.dart';
import 'package:e_commercey/screens/identification/profile_screen.dart';
import 'package:e_commercey/screens/identification/signin_screen.dart';
import 'package:e_commercey/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/model.dart';
import '../screens/checkout/checkout_screen.dart';
import '../screens/identification/signup_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('This is route: ${settings.name}');

    switch (settings.name) {
      case '/':
        return HomeScreen.route();
      case SignUpScreen.routeName:
        return SignUpScreen.route();
      case ProfileScreen.routeName:
        return ProfileScreen.route();
      case SignInScreen.routeName:
        return SignInScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      case SplashScreen.routeName:
        return SplashScreen.route();
      case CartScreen.routeName:
        return CartScreen.route();
      case ProductScreen.routeName:
        return ProductScreen.route(product: settings.arguments as Product);
      case WishlistScreen.routeName:
        return WishlistScreen.route();
      case CatalogScreen.routeName:
        return CatalogScreen.route(category: settings.arguments as Category);
      case CheckoutScreen.routeName:
        return CheckoutScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
        settings: RouteSettings(name: '/error'),
        builder: (_) => Scaffold(
              appBar: AppBar(title: Text('Error')),
            ));
  }
}
