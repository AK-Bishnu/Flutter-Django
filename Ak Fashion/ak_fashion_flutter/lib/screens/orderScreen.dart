import 'package:ak_fashion_flutter/state/cartState.dart';
import 'package:ak_fashion_flutter/widgets/app_Drawer.dart';
import 'package:ak_fashion_flutter/theme/colors.dart';
import 'package:ak_fashion_flutter/utils/spacing.dart';
import 'package:ak_fashion_flutter/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});
  static const routeName = '/orderScreen';

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<CartState>(context).orders;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Dynamic colors based on theme
    final primaryColor = AppColors.primary;
    final textPrimary =
    isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary =
    isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final surface =
    isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final shadow = AppColors.shadow(isDark);

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          'Your Orders',
          style: theme.textTheme.bodyLarge?.copyWith(color: primaryColor),
        ),
        elevation: 1.5,
      ),
      drawer: const AppDrawer(),
      body: data.isEmpty
          ? Center(
        child: CustomText(
          'No orders yet',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: textSecondary,
          ),
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(Spacing.md),
        itemCount: data.length,
        itemBuilder: (context, index) {
          final order = data[index];
          return Container(
            margin: EdgeInsets.symmetric(vertical: Spacing.sm),
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: shadow,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(Spacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order header
                  CustomText(
                    'Order #${index + 1}',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Divider(
                    height: Spacing.lg,
                    color: textSecondary.withOpacity(0.5),
                  ),

                  // Order details
                  CustomText(
                    'ID: ${order.id}',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: textPrimary),
                  ),
                  CustomText(
                    'Email: ${order.email}',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: textPrimary),
                  ),
                  CustomText(
                    'Phone: ${order.phone}',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: textPrimary),
                  ),
                  CustomText(
                    'Address: ${order.address}',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: textPrimary),
                  ),
                  SizedBox(height: Spacing.sm),

                  // Total price
                  CustomText(
                    'Total: ₹${order.cart?.total ?? 0}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
