import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ak_fashion_flutter/state/userState.dart';
import 'package:ak_fashion_flutter/screens/HomeScreen.dart';
import 'package:ak_fashion_flutter/screens/registerScreen.dart';
import 'package:ak_fashion_flutter/widgets/custom_card.dart';
import 'package:ak_fashion_flutter/widgets/custom_text.dart';
import 'package:ak_fashion_flutter/widgets/custom_button.dart';
import 'package:ak_fashion_flutter/utils/spacing.dart';
import '../widgets/custom_textField.dart';
import '../theme/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = "/LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  Future<void> _onLogin() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save(); // calls onSaved of fields

    final success = await Provider.of<UserState>(context, listen: false)
        .loginNow(_username, _password);

    if (success) {
      Navigator.pushReplacementNamed(context, Homescreen.routeName);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login failed! Check your credentials.'),
          backgroundColor: AppColors.error,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          padding: Spacing.symmetric(
            horizontal: Spacing.lg,
            vertical: Spacing.xl,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Logo inside circular card
              CustomCard(
                padding: EdgeInsets.all(Spacing.lg),
                margin: EdgeInsets.zero,
                child: CircleAvatar(
                  radius: 36,
                  backgroundColor: isDark
                      ? AppColors.primaryDark
                      : AppColors.primaryLight,
                  child: Icon(
                    Icons.shopping_bag_rounded,
                    size: 48,
                    color: AppColors.lightTextLight,
                  ),
                ),
              ),
              SizedBox(height: Spacing.xl),

              /// Welcome text
              CustomText(
                "Welcome Back!",
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark
                      ? AppColors.darkTextLight
                      : AppColors.lightTextPrimary,
                ),
                align: TextAlign.center,
              ),
              SizedBox(height: Spacing.sm),
              CustomText(
                "Login to continue shopping",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
                align: TextAlign.center,
              ),
              SizedBox(height: Spacing.xl * 1.5),

              /// Form card
              CustomCard(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.all(Spacing.lg),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Username (uses validator + onSaved)
                      CustomTextField(
                        label: 'Username',
                        icon: Icons.person_outline,
                        validator: (value) =>
                        value == null || value.isEmpty
                            ? "Please enter username"
                            : null,
                        onSaved: (value) => _username = value ?? '',
                      ),
                      SizedBox(height: Spacing.lg),

                      // Password
                      CustomTextField(
                        label: 'Password',
                        icon: Icons.lock_outline,
                        obscureText: true,
                        validator: (value) =>
                        value == null || value.isEmpty
                            ? "Please enter password"
                            : null,
                        onSaved: (value) => _password = value ?? '',
                      ),
                      SizedBox(height: Spacing.xl),

                      /// Login button
                      CustomButton(
                        text: "Login",
                        icon: Icons.login,
                        onPressed: _onLogin,
                        type: ButtonType.primary,
                      ),
                      SizedBox(height: Spacing.md),

                      /// Register link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            "Don't have an account? ",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.lightTextSecondary,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RegisterScreen.routeName);
                            },
                            child: CustomText(
                              "Register",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
