import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'homepage.dart';
import 'theme_controller.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool isLoading = false;

  void _showSnack(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(text),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(12),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AppTopBar(title: 'ثبت نام', showBack: false),
            Expanded(
              child: isLoading
                  ? Center(
                child: SpinKitWaveSpinner(
                  color: cs.primary,
                  size: 50,
                  waveColor: cs.secondary,
                ),
              )
                  : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    const Text(
                      'ایجاد حساب کاربری',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'اطلاعات خود را وارد کنید',
                      style: TextStyle(color: Theme.of(context).hintColor),
                    ),
                    const SizedBox(height: 22),
                    TextField(
                      controller: _emailController,
                      textDirection: TextDirection.ltr,
                      decoration: const InputDecoration(
                        labelText: 'ایمیل',
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'نام کاربری',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: _passwordController,
                      textDirection: TextDirection.ltr,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'رمز عبور',
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: _confirmPasswordController,
                      textDirection: TextDirection.ltr,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'تکرار رمز عبور',
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    const SizedBox(height: 22),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_emailController.text.trim().isEmpty) {
                            _showSnack('ایمیل را وارد کنید');
                            return;
                          }
                          if (_passwordController.text.length < 6) {
                            _showSnack('رمز عبور باید حداقل ۶ کاراکتر باشد');
                            return;
                          }
                          if (_passwordController.text != _confirmPasswordController.text) {
                            _showSnack('رمز عبور و تکرار آن یکسان نیست');
                            return;
                          }

                          setState(() => isLoading = true);
                          await Future.delayed(const Duration(milliseconds: 700));
                          if (!mounted) return;

                          setState(() => isLoading = false);
                          _showSnack('ثبت نام با موفقیت انجام شد');

                          await Future.delayed(const Duration(milliseconds: 500));
                          if (!mounted) return;

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const HomePage()),
                          );
                        },
                        child: const Text('ثبت نام'),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'حساب کاربری دارید؟ ',
                          style: TextStyle(color: Theme.of(context).hintColor),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Text(
                            'ورود',
                            style: TextStyle(
                              color: cs.primary,
                              fontWeight: FontWeight.w800,
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
    );
  }
}
