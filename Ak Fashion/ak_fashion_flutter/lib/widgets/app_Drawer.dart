import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/HomeScreen.dart';
import '../screens/cartScreen.dart';
import '../screens/favouriteScreen.dart';
import '../screens/loginScreen.dart';
import '../screens/orderScreen.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_text.dart';
import '../utils/spacing.dart';
import '../theme/colors.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  Future<void> onLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }

  Widget _drawerItem({
    required IconData icon,
    required String label,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return CustomCard(
      onTap: onTap,
      padding: EdgeInsets.symmetric(vertical: Spacing.sm, horizontal: Spacing.lg),
      margin: EdgeInsets.symmetric(vertical: Spacing.sm, horizontal: Spacing.md),
      borderRadius: 16,
      useShadow: true,
      child: SizedBox(
        height: 60, // uniform height for drawer items
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 28),
            SizedBox(width: Spacing.md),
            Expanded(
              child: CustomText(
                label,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600, // semiBold
                  fontSize: 16,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: iconColor.withOpacity(0.7), size: 26),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      child: Column(
        children: [
          // Drawer Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: Spacing.xl),
            color: theme.colorScheme.primary,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: AppColors.lightTextPrimary,
                  child: Icon(Icons.shopping_bag_rounded, size: 40, color: Colors.white),
                ),
                SizedBox(height: Spacing.sm),
                CustomText(
                  "AK Shop",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Drawer Items
          _drawerItem(
            icon: Icons.home,
            label: "Home",
            iconColor: theme.colorScheme.primary,
            onTap: () => Navigator.pushReplacementNamed(context, Homescreen.routeName),
          ),
          _drawerItem(
            icon: Icons.favorite_outlined,
            label: "Favourites",
            iconColor: Colors.red,
            onTap: () => Navigator.pushReplacementNamed(context, FavouriteScreen.routeName),
          ),
          _drawerItem(
            icon: Icons.shopping_cart,
            label: "Cart",
            iconColor: theme.colorScheme.secondary,
            onTap: () => Navigator.pushReplacementNamed(context, CartScreen.routeName),
          ),
          _drawerItem(
            icon: Icons.history,
            label: "Orders",
            iconColor: theme.colorScheme.secondary,
            onTap: () => Navigator.pushReplacementNamed(context, OrderScreen.routeName),
          ),

          const Spacer(),

          // Logout
          _drawerItem(
            icon: Icons.logout,
            label: "Logout",
            iconColor: Colors.red,
            onTap: onLogout,
          ),
        ],
      ),
    );
  }
}
