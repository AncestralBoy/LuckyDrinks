import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commercey/blocs/bloc/wishlist/wishlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:e_commercey/widget/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/cart/cart_bloc.dart';
import '../../models/model.dart';

class ProductScreen extends StatelessWidget {
  static const String routeName = '/product';

  static Route route({required product}) {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (_) => ProductScreen(product: product));
  }

  final Product product;

  const ProductScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: product.name),
      bottomNavigationBar: BottomAppBar(
        color: Colors.amber,
        child: Container(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.share),
                color: Colors.white,
              ),
              BlocBuilder<WishlistBloc, WishlistState>(
                builder: (context, state) {
                  return IconButton(
                    onPressed: () {
                      context
                          .read<WishlistBloc>()
                          .add(AddWishlistProduct(product));
                      final snackBar = SnackBar(
                          content: Text('Aggiunto alla tua Wishlist!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    icon: Icon(Icons.favorite),
                    color: Colors.white,
                  );
                },
              ),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () {
                        context.read<CartBloc>().add(CartProductAdded(product));
                      },
                      child: Text(
                        'ADD TO CART',
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: Colors.white),
                      ));
                },
              )
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 1.8,
              viewportFraction: 0.9,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
            ),
            items: [HeroCaruselCard(product: product)],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  width: MediaQuery.of(context).size.width - 10,
                  height: 60,
                  alignment: Alignment.bottomCenter,
                  color: Colors.amber,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.name,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            '${product.price}',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: Colors.white),
                          ),
                        ]),
                  ),
                )
              ],
            ),
          ),
          //Informazioni sul prodotto:
          ExpansionTile(
            initiallyExpanded: true,
            title: Text(
              "Product Information",
              style: Theme.of(context).textTheme.headline3,
            ),
            children: <Widget>[
              ListTile(
                title: Text(
                  'Bella roba. Tutto bello e tutto fresco, se beve na meraviglia, a garganella come piace a noi. Bella fra!!',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              )
            ],
          ),
          ExpansionTile(
            title: Text(
              "Delivery Information",
              style: Theme.of(context).textTheme.headline3,
            ),
            children: <Widget>[
              ListTile(
                title: Text(
                  'Consegna veloce.',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
