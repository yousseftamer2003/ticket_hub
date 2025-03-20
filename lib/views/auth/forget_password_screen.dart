import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_hub/constant/colors.dart';
import 'package:ticket_hub/constant/widgets/custom_appbar_widget.dart';
import 'package:ticket_hub/controller/auth/otp_provider.dart';
import 'package:ticket_hub/views/auth/otp_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  ForgetPasswordScreenState createState() => ForgetPasswordScreenState();
}

class ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Forget Password?'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Consumer<ForgotPasswordProvider>(
          builder: (context, provider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Please enter your email or phone number to reset your password.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF7C7C7C),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Email or Phone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  ),
                ),
                const SizedBox(height: 30),
                if (provider.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      provider.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                if (provider.message != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      provider.message!,
                      style: const TextStyle(color: Colors.green),
                    ),
                  ),
                Center(
                  child: ElevatedButton(
                    onPressed: provider.isLoading
                        ? null
                        : () async {
                            String email = _emailController.text.trim();
                            if (email.isNotEmpty) {
                              await provider.sendEmail(email);
                              if (provider.message != null) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) => OtpPasswordScreen(
                                      email: email,
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blackColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 100),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: provider.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Reset Password',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
