import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../utils/router/app_router.dart';
import '../../../../utils/router/route_paths.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>{
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _generalError;

  bool _isLoading=false;

  void _validateAndSubmit() {
    setState(() {
      _generalError = null;
      _nameError = null;
      _emailError = null;
      _passwordError = null;
      _confirmPasswordError = null;
    });

    // Variation 2: Empty Validation
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      setState(() {
        if (_nameController.text.isEmpty) {
          _nameError = 'Full name required';
        }
        if (_emailController.text.isEmpty) {
          _emailError = 'Email required';
        }
        if (_passwordController.text.isEmpty) {
          _passwordError = 'Password required';
        }
        if (_confirmPasswordController.text.isEmpty) {
          _confirmPasswordError = 'Please confirm your password';
        }
        _generalError = 'Please fill in all fields';
      });
      return;
    }

    // Variation 3: Invalid Name
    if (_nameController.text.length < 2) {
      setState(() {
        _nameError = 'Name must be at least 2 characters';
      });
      return;
    }

    // Variation 4: Wrong Email
    if (!_isValidEmail(_emailController.text)) {
      setState(() {
        _emailError = 'Enter a valid email (e.g., name@domain.com)';
      });
      return;
    }

    // Variation 5: Password Mismatch
    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _confirmPasswordError = 'Passwords do not match';
      });
      return;
    }

    // Password strength check (optional)
    if (_passwordController.text.length < 6) {
      setState(() {
        _passwordError = 'Password must be at least 6 characters';
      });
      return;
    }

    // Simulate API call
    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account created successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        // Navigate to login screen
        context.pushReplacement(RoutePaths.login);
      }
    });
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context ){
    return Scaffold (
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Create Account'),
        backgroundColor: const Color(0xFF1C3E1B),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(child: Text('hi')),
    );
  }


}