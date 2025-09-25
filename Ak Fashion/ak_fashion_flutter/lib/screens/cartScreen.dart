import 'package:ak_fashion_flutter/screens/orderNowScreen.dart';
import 'package:ak_fashion_flutter/state/cartState.dart';
import 'package:ak_fashion_flutter/widgets/app_Drawer.dart';
import 'package:ak_fashion_flutter/widgets/custom_button.dart';
import 'package:ak_fashion_flutter/widgets/custom_card.dart';
import 'package:ak_fashion_flutter/widgets/custom_text.dart';
import 'package:ak_fashion_flutter/theme/colors.dart';
import 'package:ak_fashion_flutter/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/CartScreen';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _cart = Provider.of<CartState>(context).cart;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: CustomText(
          'Your Cart',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 1.5,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Row(
              children: [
                const Icon(Icons.shopping_cart),
                const SizedBox(width: 4),
                CustomText(
                  (_cart.cartproducts?.length ?? 0).toString(),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: _cart.cartproducts == null || _cart.cartproducts!.isEmpty
          ? Center(
        child: CustomText(
          'Your cart is empty',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
        ),
      )
          : Padding(
        padding: Spacing.pagePadding,
        child: Column(
          children: [
            // Cart summary
            CustomCard(
              padding: Spacing.cardPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    'Total: ₹${_cart.total ?? 0}',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  CustomText(
                    'Date: ${_cart.date ?? ''}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Spacing.md),

            // Order / Clear Cart buttons
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Order Now',
                    type: ButtonType.primary,
                    onPressed: () {
                      Navigator.pushNamed(
                          context, OrderNowScreen.routeName);
                    },
                  ),
                ),
                SizedBox(width: Spacing.sm),
                Expanded(
                  child: CustomButton(
                    text: 'Clear Cart',
                    type: ButtonType.secondary,
                    onPressed: () {
                      Provider.of<CartState>(context, listen: false)
                          .deleteCart(_cart.id!.toInt());
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: Spacing.lg),

            // Cart items list
            Expanded(
              child: ListView.builder(
                itemCount: _cart.cartproducts!.length,
                itemBuilder: (context, index) {
                  final cartItem = _cart.cartproducts![index];
                  return CustomCard(
                    margin:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                cartItem.product?.title ?? 'No title',
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                              SizedBox(height: Spacing.xs),
                              CustomText(
                                'Price: ₹${cartItem.price ?? 0}',
                                style: theme.textTheme.bodyMedium,
                              ),
                              CustomText(
                                'Quantity: ${cartItem.quantity ?? 1}',
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Delete button
                        CustomButton(
                          text: 'Delete',
                          type: ButtonType.secondary,
                          onPressed: () {
                            Provider.of<CartState>(context, listen: false)
                                .deleteCartProduct(cartItem.id!.toInt());
                          },
                          icon: Icons.delete,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
