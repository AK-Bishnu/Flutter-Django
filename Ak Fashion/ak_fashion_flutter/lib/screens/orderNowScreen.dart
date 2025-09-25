import 'package:ak_fashion_flutter/screens/cartScreen.dart';
import 'package:ak_fashion_flutter/screens/orderScreen.dart';
import 'package:ak_fashion_flutter/state/cartState.dart';
import 'package:ak_fashion_flutter/utils/spacing.dart';
import 'package:ak_fashion_flutter/widgets/custom_button.dart';
import 'package:ak_fashion_flutter/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderNowScreen extends StatefulWidget {
  const OrderNowScreen({super.key});
  static const routeName = '/orderNowScreen';

  @override
  State<OrderNowScreen> createState() => _OrderNowScreenState();
}

class _OrderNowScreenState extends State<OrderNowScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _phone = '';
  String _address = '';
  bool _isOrdering = false;

  Future<void> orderNow() async {
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) return;
    _formKey.currentState?.save();

    setState(() => _isOrdering = true);
    final cart = Provider.of<CartState>(context, listen: false).cart;

    Map<String, dynamic> data = {
      'id': cart.id,
      'email': _email,
      'phone': _phone,
      'address': _address,
    };

    final res =
    await Provider.of<CartState>(context, listen: false).orderCart(data);

    setState(() => _isOrdering = false);

    if (res) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cart ordered successfully'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pushReplacementNamed(context, OrderScreen.routeName);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Order failed'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // Reusable decoration with theme-aware coloring
  InputDecoration _inputDecoration(BuildContext context, String hint) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: isDark ? Colors.white70 : Colors.grey[600],
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: isDark ? Colors.white38 : Colors.grey.shade400,
          width: 1.2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: theme.primaryColor,
          width: 1.4,
        ),
      ),
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          'Order Now',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).primaryColor,
          ),
        ),
        elevation: 1.5,
      ),
      body: SingleChildScrollView(
        padding: Spacing.pagePadding,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Email Field
              TextFormField(
                decoration: _inputDecoration(context, "Email"),
                validator: (v) {
                  if (v == null || v.isEmpty) return "Enter your email";
                  final emailRegex =
                  RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(v)) return "Enter a valid email";
                  return null;
                },
                onSaved: (v) => _email = v!,
              ),
              SizedBox(height: Spacing.md),

              // Phone Field
              TextFormField(
                decoration: _inputDecoration(context, "Phone"),
                validator: (v) {
                  if (v == null || v.isEmpty) return "Enter your phone";
                  if (!RegExp(r'^\d{10,15}$').hasMatch(v)) {
                    return "Enter a valid phone number";
                  }
                  return null;
                },
                onSaved: (v) => _phone = v!,
              ),
              SizedBox(height: Spacing.md),

              // Address Field
              TextFormField(
                decoration: _inputDecoration(context, "Address"),
                maxLines: 3,
                validator: (v) => v == null || v.isEmpty
                    ? "Enter your address"
                    : null,
                onSaved: (v) => _address = v!,
              ),
              SizedBox(height: Spacing.lg),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    text: _isOrdering ? 'Ordering...' : 'Order',
                    onPressed: _isOrdering ? null : orderNow,
                    icon: Icons.check,
                  ),
                  CustomButton(
                    text: 'Edit Cart',
                    type: ButtonType.secondary,
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, CartScreen.routeName);
                    },
                    icon: Icons.edit,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
