import 'package:ak_fashion_flutter/state/cartState.dart';
import 'package:ak_fashion_flutter/widgets/app_Drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});
  static const routeName = '/orderScreen';

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<CartState>(context).orders;
    return Scaffold(
      appBar: AppBar(
        title: Text('Old Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Text('Order No. : ${index+1}'),
                Divider(),
                Text('ID : ${data[index].id}'),
                Text('Email : ${data[index].email}'),
                Text('Phone : ${data[index].phone}'),
                Text('Address : ${data[index].address}'),
                Text('Total : ${data[index].cart?.total}'),
              ],
            ),
          );
      },),
    );
  }
}
