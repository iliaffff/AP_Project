import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'homepage.dart';
import 'sign_up_screen.dart';
import 'theme_controller.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? Center(
          child: SpinKitWaveSpinner(
            color: cs.primary,
            size: 50,
            waveColor: cs.secondary,
          ),
        )
            : SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppTopBar(title: 'ورود'),

              const SizedBox(height: 18),

              const Text(
                'خوش برگشتی',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              Text(
                'برای ادامه وارد شوید',
                style: TextStyle(color: Theme.of(context).hintColor),
              ),
              const SizedBox(height: 28),

              TextField(
                controller: _emailController,
                focusNode: _emailFocusNode,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.left,
                decoration: const InputDecoration(
                  labelText: 'ایمیل',
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onSubmitted: (_) {
                  _emailFocusNode.unfocus();
                  FocusScope.of(context).requestFocus(_passwordFocusNode);
                },
              ),
              const SizedBox(height: 14),

              TextField(
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.left,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'رمز عبور',
                  prefixIcon: Icon(Icons.lock),
                ),
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _passwordFocusNode.unfocus(),
              ),
              const SizedBox(height: 22),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomePage()),
                  );
                },
                child: const Text('ورود'),
              ),

              const SizedBox(height: 14),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'حساب کاربری ندارید؟ ',
                    style: TextStyle(color: Theme.of(context).hintColor),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SignUpScreen()),
                      );
                    },
                    child: Text(
                      'ثبت نام',
                      style: TextStyle(
                        color: cs.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
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
