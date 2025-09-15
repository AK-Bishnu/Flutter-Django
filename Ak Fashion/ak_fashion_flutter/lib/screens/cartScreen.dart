import 'package:ak_fashion_flutter/screens/orderNowScreen.dart';
import 'package:ak_fashion_flutter/state/cartState.dart';
import 'package:ak_fashion_flutter/widgets/app_Drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/CartScreen';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _cart = Provider.of<CartState>(context).cart;

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Your cart'),
        actions: [
          Row(
            children: [
              const Icon(Icons.shopping_cart),
              const SizedBox(width: 5),
              Text((_cart.cartproducts?.length ?? 0).toString()),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          // Cart summary
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Total Price: ₹${_cart.total ?? 0}'),
                Text('Date: ${_cart.date ?? ''}'),
              ],
            ),
          ),

          // Order / Delete buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () {
                Navigator.pushNamed(context, OrderNowScreen.routeName);
              }, child: const Text('Order')),
              ElevatedButton(onPressed: () {
                Provider.of<CartState>(context,listen: false).deleteCart(_cart.id!.toInt());
              }, child: const Text('Delete')),
            ],
          ),

          // Cart items list
          Expanded(
            child: (_cart.cartproducts == null || _cart.cartproducts!.isEmpty)
                ? const Center(child: Text('Your cart is empty'))
                : ListView.builder(
              itemCount: _cart.cartproducts!.length,
              itemBuilder: (context, index) {
                final cartItem = _cart.cartproducts![index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(cartItem.product?.title ?? 'No title'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Price: ₹${cartItem.price ?? 0}'),
                        Text('Quantity: ${cartItem.quantity ?? 1}'),
                      ],
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Provider.of<CartState>(context,listen: false).deleteCartProduct(cartItem.id!.toInt());
                      },
                      child: const Text('Delete'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
