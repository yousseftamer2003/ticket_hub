import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_hub/constant/widgets/custom_appbar_widget.dart';
import 'package:ticket_hub/constant/widgets/custom_button_widget.dart';
import 'package:ticket_hub/constant/widgets/text_field_widget.dart';
import 'package:ticket_hub/controller/profile/profile_provider.dart';

import '../../generated/l10n.dart' show S;

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
  });

  final String name;
  final String email;
  final String phone;

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    emailController = TextEditingController(text: widget.email);
    phoneController = TextEditingController(text: widget.phone);
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _editProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    await userProvider.updateUserProfile(
      context: context,
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      password:
          passwordController.text.isNotEmpty ? passwordController.text : null,
    );

    if (userProvider.user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          S.of(context).profile_updated,
        )),
      );

      // Return true to indicate successful update
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          S.of(context).profile_update_failed,
        )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: customAppBar(
        context,
        S.of(context).editProfile,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: nameController,
                  labelText: S.of(context).name,
                  validator: (value) =>
                      value!.isEmpty ? S.of(context).enter_name : null,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: emailController,
                  labelText: S.of(context).email,
                  validator: (value) =>
                      value!.isEmpty ? S.of(context).enter_email : null,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: phoneController,
                  labelText: S.of(context).phone,
                  validator: (value) =>
                      value!.isEmpty ? S.of(context).enter_phone : null,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: passwordController,
                  labelText: S.of(context).password,
                  obscureText: true,
                  suffixIcon: const Icon(Icons.visibility_off),
                ),
                const SizedBox(height: 20),
                userProvider.isLoading
                    ? const CircularProgressIndicator()
                    : DarkCustomButton(
                        text: S.of(context).editProfile,
                        onPressed: _editProfile,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
