import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../utils/router/route_paths.dart';
import '../../../../utils/theme/app_theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>{
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


    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      setState(() {
        if (_nameController.text.isEmpty) {
          _nameError = 'Name field can not be empty';
        }
        if (_emailController.text.isEmpty) {
          _emailError = 'Email is required';
        }
        if (_passwordController.text.isEmpty) {
          _passwordError = 'Password is required';
        }
        if (_confirmPasswordController.text.isEmpty) {
          _confirmPasswordError = 'Please confirm your password';
        }
        _generalError = 'Please fill in all fields';
      });
      return;
    }

    if (_nameController.text.length < 2) {
      setState(() {
        _nameError = 'Name must be at least 2 characters';
      });
      return;
    }


    if (!_isValidEmail(_emailController.text)) {
      setState(() {
        _emailError = 'Invalid email format (e.g., name@domain.com)';
      });
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _confirmPasswordError = 'Passwords do not match';
      });
      return;
    }

    if (_passwordController.text.length < 6) {
      setState(() {
        _passwordError = 'Password must be at least 6 characters';
      });
      return;
    }

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
            backgroundColor: AppTheme.primaryGreenLight,
          ),
        );
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
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 40,
                    color:  Color(0xFF1C3E1B),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10,),
                const Text(
                  'Join our community to help reunite lost belongings with their owners.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 32),

                if (_generalError != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.accentRed),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline, color: AppTheme.accentRed, size: 18),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            _generalError!,
                            style: const TextStyle(color: AppTheme.accentRed, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                CustomTextField(
                  controller: _nameController,
                  label: 'FULL NAME',
                  hint: 'Enter your name.',
                  errorText:_nameError ,
                ),

                const SizedBox(height: 16),
                CustomTextField(
                  controller: _emailController,
                  label: 'EMAIL',
                  hint: 'abebe@aau.edu.et',
                  keyboardType: TextInputType.emailAddress,
                  errorText: _emailError,
                ),

                const SizedBox(height: 16),

                CustomTextField(
                  controller: _passwordController,
                  label: 'PASSWORD',
                  hint: '*********',
                  obscureText: true,
                  errorText: _passwordError,
                ),

                const SizedBox(height: 16),

                CustomTextField(
                  controller: _confirmPasswordController,
                  label: 'CONFIRM PASSWORD',
                  hint: '*********',
                  obscureText: true,
                  errorText: _confirmPasswordError,
                ),

                const SizedBox(height: 24),

                CustomButton(
                  text: 'Create Account',
                  onPressed: _validateAndSubmit,
                  isLoading: _isLoading,
                ),

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(fontSize: 14, color: AppTheme.grayText),
                    ),
                    TextButton(
                      onPressed: () {
                        context.push(RoutePaths.login);
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryGreen,
                        ),
                      ),
                    ),
                  ],
                )
              ],
              ),

    ),
      ),
        );
  }


}