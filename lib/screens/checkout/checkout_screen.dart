import 'package:flutter/material.dart';
import 'package:e_commercey/widget/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/checkout/bloc/checkout_bloc.dart';

class CheckoutScreen extends StatelessWidget {
  static const String routeName = '/checkout';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => CheckoutScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Checkout'),
      bottomNavigationBar: CustomNavBar(screen: routeName),
      body: BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          if (state is CheckoutLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CheckoutLoaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'INFORMAZIONI CLIENTE',
                  style: Theme.of(context).textTheme.headline3,
                ),
                _buildTextFormField((value) {
                  context
                      .read<CheckoutBloc>()
                      .add(UpdateCheckout(email: value));
                }, context, 'Email'),
                _buildTextFormField((value) {
                  context
                      .read<CheckoutBloc>()
                      .add(UpdateCheckout(fullName: value));
                }, context, 'Nome e Congome'),
                Text(
                  'INFORMAZIONI CONSEGNA',
                  style: Theme.of(context).textTheme.headline3,
                ),
                _buildTextFormField((value) {
                  context
                      .read<CheckoutBloc>()
                      .add(UpdateCheckout(address: value));
                }, context, 'Address'),
                _buildTextFormField((value) {
                  context.read<CheckoutBloc>().add(UpdateCheckout(city: value));
                }, context, 'City'),
                _buildTextFormField((value) {
                  context
                      .read<CheckoutBloc>()
                      .add(UpdateCheckout(country: value));
                }, context, 'Contry'),
                _buildTextFormField((value) {
                  context
                      .read<CheckoutBloc>()
                      .add(UpdateCheckout(zipCode: value));
                }, context, 'Zip Code'),
                Text(
                  'RIEPILOGO ORDINE',
                  style: Theme.of(context).textTheme.headline3,
                ),
                OrderSummary(),
              ],
            );
          } else {
            return Text('Qualcosa è andato storto!');
          }
        },
      ),
    );
  }

  Padding _buildTextFormField(
    Function(String)? onChanged,
    BuildContext context,
    String labelText,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        SizedBox(
          width: 75,
          child: Text(labelText, style: Theme.of(context).textTheme.bodyText1),
        ),
        Expanded(
          child: TextFormField(
            onChanged: onChanged,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.only(left: 10),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
