import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/userState.dart';
import '../utils/spacing.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_textField.dart';
import 'loginScreen.dart';
import '../theme/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const routeName = "/RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var _username = '';
  var _password = '';
  var _confirmPass = '';

  final _form = GlobalKey<FormState>();

  Future<void> _onReg() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) return;

    _form.currentState?.save();

    final res = await Provider.of<UserState>(context, listen: false)
        .registerNow(_username, _password);

    if (res) {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Registration failed! Please check your credentials.'),
          backgroundColor: AppColors.error,
          duration: const Duration(seconds: 2),
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
          padding: Spacing.pagePadding,
          child: CustomCard(
            padding: Spacing.symmetric(vertical: Spacing.xl, horizontal: Spacing.lg),
            borderRadius: 20,
            useShadow: true, // uses AppColors.shadow internally
            child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Title
                  CustomText(
                    "Create Account",
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.darkTextLight : AppColors.lightTextPrimary,
                    ),
                    align: TextAlign.center,
                  ),
                  const SizedBox(height: Spacing.md),

                  CustomText(
                    "Join us and start shopping today!",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                    align: TextAlign.center,
                  ),
                  const SizedBox(height: Spacing.xl),

                  // Username
                  CustomTextField(
                    label: "Username",
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Please enter a username";
                      return null;
                    },
                    onSaved: (value) => _username = value!,
                  ),
                  const SizedBox(height: Spacing.md),

                  // Password
                  CustomTextField(
                    label: "Password",
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Please enter a password";
                      return null;
                    },
                    onSaved: (value) => _password = value!,
                  ),
                  const SizedBox(height: Spacing.md),

                  // Confirm Password
                  CustomTextField(
                    label: "Confirm Password",
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Please confirm your password";
                      if (value != _password) return "Passwords do not match";
                      return null;
                    },
                    onSaved: (value) => _confirmPass = value!,
                  ),
                  const SizedBox(height: Spacing.xl),

                  // Register button
                  CustomButton(
                    text: "Register",
                    onPressed: _onReg,
                    type: ButtonType.primary,
                  ),
                  const SizedBox(height: Spacing.lg),

                  // Login link
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        "Already have an account? ",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        ),
                      ),
                      CustomButton(
                        text: "Login",
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                        },
                        type: ButtonType.text,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
