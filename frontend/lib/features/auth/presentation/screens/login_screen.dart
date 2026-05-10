import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/utils/router/route_paths.dart';
import 'package:frontend/shared/widgets/custom_text_field.dart';
import 'package:frontend/shared/widgets/custom_button.dart';
import '../../../../utils/theme/app_theme.dart';
class LoginScreen extends StatefulWidget {

  final String? role;

  const LoginScreen({super.key,this.role='user'});

  @override
  State<LoginScreen> createState()=> _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  final TextEditingController _emailController= TextEditingController();
  final TextEditingController _passwordController= TextEditingController();

  String? _emailError;
  String? _passwordError;
  String? _generalError;

  bool _isLoading = false;

  void _handleSignIn() async {
    setState(() {
      _generalError = null;
      _emailError = null;
      _passwordError = null;
    });


    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        if (_emailController.text.isEmpty) {
          _emailError = 'Email is required';
        }
        if (_passwordController.text.isEmpty) {
          _passwordError = 'Password is required';
        }
        _generalError = 'Please fill in all fields';
      });
      return;
    }


    if (!_isValidEmail(_emailController.text)) {
      setState(() {
        _emailError = 'Enter a valid email address';
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    // Demo credentials check
    // For demo purposes: email: user@test.com, password: 123456
    // For admin: email: admin@test.com, password: admin123
    final isAdmin = widget.role == 'admin';
    final isValidUser = _emailController.text == 'user@test.com' &&
        _passwordController.text == '123456';
    final isValidAdmin = _emailController.text == 'admin@test.com' &&
        _passwordController.text == 'admin123';

    if ((isAdmin && isValidAdmin) || (!isAdmin && isValidUser)) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Welcome back, ${_emailController.text.split('@')[0]}!'),
          backgroundColor: AppTheme.primaryGreenLight,
        ),
      );

      if (isAdmin) {
        context.pushReplacement(RoutePaths.adminItems);
      } else {
        context.pushReplacement(RoutePaths.items);
      }
    } else {
      setState(() {
        _isLoading = false;
        _generalError = isAdmin
            ? 'Invalid admin credentials. Please try again.'
            : 'Invalid email or password. Please try again.';
        _passwordError = 'Incorrect password';
      });
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext contex){
    final isAdmin = widget.role == 'admin';
    return Scaffold(
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
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.primaryGreen,
                  ),
                  textAlign: TextAlign.left,
                ),

                const SizedBox(height: 8),

                Text(
                  isAdmin
                      ? 'Access admin dashboard'
                      : 'Access your secure vault and track your items.',
                  style: const TextStyle(
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
                      border: Border.all(color: Colors.red.shade300),
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
                  controller: _emailController,
                  label: 'EMAIL ADDRESS',
                  hint: 'abebe@aau.edu.et',
                  keyboardType: TextInputType.emailAddress,
                  errorText: _emailError,
                ),

                const SizedBox(height: 16),

                CustomTextField(
                  controller: _passwordController,
                  label: 'PASSWORD',
                  hint: '·············',
                  obscureText: true,
                  errorText: _passwordError,
                ),

                const SizedBox(height: 24),

                CustomButton(
                  text: 'Sign in',
                  onPressed: _handleSignIn,
                  isLoading: _isLoading,
                ),

                const SizedBox(height: 24),

                if (!isAdmin)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'New to Reclaim?',
                        style: TextStyle(fontSize: 14, color: AppTheme.grayText),
                      ),
                      TextButton(
                        onPressed: () {
                          context.push(RoutePaths.register);
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                        child: const Text(
                          'Create an account',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryGreen,
                          ),
                        ),
                      ),
                    ],
                  ),

                if (isAdmin)
                  Center(
                    child: TextButton(
                      onPressed: () {
                        context.push(RoutePaths.login);
                      },
                      child: const Text(
                        '← User Sign In',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.primaryGreen,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          )),
    );
  }

}