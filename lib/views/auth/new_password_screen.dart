import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_hub/constant/widgets/custom_button_widget.dart';
import 'package:ticket_hub/constant/widgets/text_field_widget.dart';
import 'package:ticket_hub/constant/widgets/custom_appbar_widget.dart';
import 'package:ticket_hub/controller/auth/otp_provider.dart';
import 'package:ticket_hub/views/auth/login_screen.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key, required this.email, required this.code});
  final String email;
  final String code;

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  bool _obscurePassword = true;
  bool _confirmObscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final forgotPasswordProvider = Provider.of<ForgotPasswordProvider>(context);

    return Scaffold(
      appBar: customAppBar(context, 'New Password'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const Row(
              children: [
                Text(
                  'New password',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Text(
                  'Create a new password',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: _passwordController,
              labelText: 'Password',
              obscureText: _obscurePassword,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
                icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility),
              ),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: _confirmpasswordController,
              labelText: 'Confirm Password',
              obscureText: _confirmObscurePassword,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _confirmObscurePassword = !_confirmObscurePassword;
                  });
                },
                icon: Icon(_confirmObscurePassword
                    ? Icons.visibility_off
                    : Icons.visibility),
              ),
            ),
            const Spacer(),
            if (forgotPasswordProvider.isLoading)
              const CircularProgressIndicator()
            else
              DarkCustomButton(
                text: 'Confirm',
                onPressed: () async {
                  if (_passwordController.text.isEmpty ||
                      _confirmpasswordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill all fields')),
                    );
                    return;
                  }

                  if (_passwordController.text !=
                      _confirmpasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Passwords do not match')),
                    );
                    return;
                  }

                  await forgotPasswordProvider.changePassword(
                    widget.email,
                    widget.code,
                    _passwordController.text,
                  );

                  if (forgotPasswordProvider.message != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(forgotPasswordProvider.message!)),
                    );
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => const LoginScreen()),
                    );
                  } else if (forgotPasswordProvider.errorMessage != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(forgotPasswordProvider.errorMessage!)),
                    );
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
