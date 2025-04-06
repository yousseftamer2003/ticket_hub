import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_hub/constant/colors.dart';
import 'package:ticket_hub/constant/widgets/custom_button_widget.dart';
import 'package:ticket_hub/constant/widgets/text_field_widget.dart';
import 'package:ticket_hub/controller/auth/login_provider.dart';
import 'package:ticket_hub/generated/l10n.dart' show S;
import 'package:ticket_hub/views/auth/forget_password_screen.dart';
import 'package:ticket_hub/views/auth/signup_screen.dart';
import 'package:ticket_hub/views/tabs_screen/screens/tabs_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          S.of(context).login,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    S.of(context).WelcomeBack,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    S.of(context).loginToYourAccount,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF7C7C7C),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _emailController,
                labelText: S.of(context).email,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _passwordController,
                labelText: S.of(context).password,
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const ForgetPasswordScreen()));
                    },
                    child: Text(
                      S.of(context).forgotPassword,
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        color: blackColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              DarkCustomButton(
                  text: S.of(context).login,
                  onPressed: () async {
                    final loginProvider =
                        Provider.of<LoginProvider>(context, listen: false);
                    await loginProvider.login(
                      _emailController.text,
                      _passwordController.text,
                    );

                    if (loginProvider.token != null) {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => const TabsScreen()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text(loginProvider.error ?? "Login failed")),
                      );
                    }
                  }),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Expanded(child: Divider(color: Colors.grey, thickness: 0)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      S.of(context).orLoginWith,
                      style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                  const Expanded(child: Divider(color: Colors.grey, thickness: 0)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.facebook,
                        color: Colors.grey, size: 40),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: Image.asset(
                        'assets/images/Instagram Icon Container.png',
                        width: 40),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(S.of(context).dontHaveAnAccount,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      )),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const SignupScreen()));
                    },
                    child: Text(
                      S.of(context).signUp,
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: blackColor,
                        fontSize: 16,
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
