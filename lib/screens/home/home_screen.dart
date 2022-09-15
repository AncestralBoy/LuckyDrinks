import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:e_commercey/widget/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/category/bloc/category_bloc.dart';
import '../../blocs/product/bloc/product_bloc.dart';
import '../../models/model.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName), builder: (_) => HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'LuckyDrinks'),
      bottomNavigationBar: CustomNavBar(
        screen: routeName,
      ),
      body: Column(
        children: [
          Container(
            child: BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is CategoryLoaded) {
                  return CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 1.8,
                      viewportFraction: 0.9,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                    ),
                    items: state.categories
                        .map((category) => HeroCaruselCard(category: category))
                        .toList(),
                  );
                } else {
                  return Text('Qualcosa è andato storto.');
                }
              },
            ),
          ),
          SectionTitle(title: 'RECOMENDED'),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ProductLoaded) {
                return ProductCarousel(
                    products: state.products
                        .where((product) => product.isReccomended)
                        .toList());
              } else {
                return (Text('Qualcosa è adnato storto.'));
              }
            },
          ),
          SectionTitle(title: 'MOST POPULAR'),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ProductLoaded) {
                return ProductCarousel(
                    products: state.products
                        .where((product) => product.isPopular)
                        .toList());
              } else {
                return (Text('Qualcosa è andato storto.'));
              }
            },
          ),
        ],
      ),
    );
  }
}
