import 'package:e_commercey/blocs/cart/cart_bloc.dart';
import 'package:e_commercey/models/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/bloc/wishlist/wishlist_bloc.dart';
import '../blocs/checkout/bloc/checkout_bloc.dart';

class CustomNavBar extends StatelessWidget {
  final String screen;
  final Product? product;

  const CustomNavBar({Key? key, required this.screen, this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.orange,
      child: Container(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _selectNavBar(context, screen)!,
        ),
      ),
    );
  }

  List<Widget>? _selectNavBar(context, screen) {
    switch (screen) {
      case '/':
        return _buildNavBar(context);
      case '/catalog':
        return _buildNavBar(context);
      case '/wishlist':
        return _buildNavBar(context);
      case '/product':
        return _buildAddToCartNavBar(context, product);
      case '/cart':
        return _buildGoToCheckoutNavBar(context);
      case '/checkout':
        return _buildOrderNowNavBar(context);
      default:
        _buildNavBar(context);
    }
  }

  List<Widget>? _buildNavBar(context) {
    return [
      IconButton(
        onPressed: () {
          Navigator.pushNamed(context, '/');
        },
        icon: Icon(Icons.home, color: Colors.white),
      ),
      IconButton(
        onPressed: () {
          Navigator.pushNamed(context, '/cart');
        },
        icon: Icon(Icons.shopping_cart, color: Colors.white),
      ),
      IconButton(
        onPressed: () {
          Navigator.pushNamed(context, '/user');
        },
        icon: Icon(Icons.person, color: Colors.white),
      ),
    ];
  }

  List<Widget> _buildAddToCartNavBar(context, product) {
    return [
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.shopping_cart, color: Colors.white),
      ),
      BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoading) {
            return CircularProgressIndicator();
          }
          if (state is WishlistLoaded) {
            return IconButton(
              onPressed: () {
                final snackBar = SnackBar(
                  content: Text('Aggiunto alla tua Wishlist!'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                context.read<WishlistBloc>().add(AddWishlistProduct(product));
              },
              icon: Icon(Icons.favorite, color: Colors.white),
            );
          }
          return Text('Qualcosa è andato storto!');
        },
      ),
      BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return CircularProgressIndicator();
          }
          if (state is CartLoaded) {
            return ElevatedButton(
              onPressed: () {
                context.read<CartBloc>().add(CartProductAdded(product));
                Navigator.pushNamed(context, '/cart');
              },
              style: ElevatedButton.styleFrom(
                // ignore: deprecated_member_use
                primary: Colors.white,
                shape: RoundedRectangleBorder(),
              ),
              child: Text(
                'ADD TO CART',
                style: Theme.of(context).textTheme.headline3,
              ),
            );
          }
          return Text('Qualcosa è andato storto!');
        },
      )
    ];
  }

  List<Widget> _buildGoToCheckoutNavBar(context) {
    return [
      ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/checkout');
        },
        style: ElevatedButton.styleFrom(
          // ignore: deprecated_member_use
          primary: Colors.white,
          shape: RoundedRectangleBorder(),
        ),
        child: Text('VAI AL CHECKOUT',
            style: Theme.of(context).textTheme.headline3),
      ),
    ];
  }

  List<Widget> _buildOrderNowNavBar(context) {
    return [
      BlocBuilder<CheckoutBloc, CheckoutState>(builder: (context, state) {
        if (state is CheckoutLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CheckoutLoaded) {
          return ElevatedButton(
            onPressed: () {
              context
                  .read<CheckoutBloc>()
                  .add(ConfirmCheckout(checkout: state.checkout));
            },
            style: ElevatedButton.styleFrom(
              // ignore: deprecated_member_use
              primary: Colors.white,
              shape: RoundedRectangleBorder(),
            ),
            child: Text('ORDINA ADESSO',
                style: Theme.of(context).textTheme.headline3),
          );
        } else {
          return Text('Qualcosa è andato storto!');
        }
        ;
      }),
    ];
  }
}
