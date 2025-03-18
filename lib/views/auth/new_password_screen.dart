import 'package:flutter/material.dart';
import 'package:ticket_hub/constant/widgets/custom_button_widget.dart';
import 'package:ticket_hub/constant/widgets/text_field_widget.dart';
import 'package:ticket_hub/constant/widgets/custom_appbar_widget.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  bool _obscurePassword = true;
  bool _confirmobscurePassword = true;

  @override
  Widget build(BuildContext context) {
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
              labelText: 'Password',
              obscureText: _confirmobscurePassword,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _confirmobscurePassword = !_confirmobscurePassword;
                  });
                },
                icon: Icon(_confirmobscurePassword
                    ? Icons.visibility_off
                    : Icons.visibility),
              ),
            ),
            const Spacer(),
            DarkCustomButton(text: 'confirm', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
