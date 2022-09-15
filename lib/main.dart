import 'package:e_commercey/blocs/bloc/wishlist/wishlist_bloc.dart';
import 'package:e_commercey/blocs/category/bloc/category_bloc.dart';
import 'package:e_commercey/blocs/checkout/bloc/checkout_bloc.dart';
import 'package:e_commercey/blocs/product/bloc/product_bloc.dart';
import 'package:e_commercey/config/app_router.dart';
import 'package:e_commercey/models/model.dart';
import 'package:e_commercey/repositories/category/category_repository.dart';
import 'package:e_commercey/repositories/checkout/checkout_repository.dart';
import 'package:e_commercey/repositories/local_storage/local_storage_repository.dart';
import 'package:e_commercey/repositories/product/product_repository.dart';
import 'package:e_commercey/screens/screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'blocs/cart/cart_bloc.dart';
import 'config/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => WishlistBloc(
                  localStorageRepository: LocalStorageRepository(),
                )..add(StartWishlist())),
        BlocProvider(create: (_) => CartBloc()..add(CartStarted())),
        BlocProvider(
            create: (_) => CategoryBloc(
                  categoryRepository: CategoryRepository(),
                )..add(LoadCategories())),
        BlocProvider(
          create: (_) => ProductBloc(
            productRepository: ProductRepository(),
          )..add(
              LoadProducts(),
            ),
        ),
        BlocProvider(
          create: (context) => CheckoutBloc(
            cartBloc: context.read<CartBloc>(),
            checkoutRepository: CheckoutRepository(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'e_commercey',
        debugShowCheckedModeBanner: false,
        theme: theme(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}
