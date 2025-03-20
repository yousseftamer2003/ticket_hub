import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_hub/constant/widgets/custom_button_widget.dart';
import 'package:ticket_hub/constant/widgets/text_field_widget.dart';
import 'package:ticket_hub/constant/widgets/custom_appbar_widget.dart';
import 'package:ticket_hub/controller/auth/list_provider.dart';
import 'package:ticket_hub/controller/auth/signup_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  String? _selectedGender;
  String? _selectedNationality;

  final List<String> _genders = ['male', 'female'];

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<NationalityProvider>(context, listen: false)
            .fetchNationalities());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Sign Up'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Create a new account',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF7C7C7C),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                      controller: _nameController, labelText: 'Name'),
                  const SizedBox(height: 20),
                  CustomTextField(
                      controller: _phoneController, labelText: 'Phone'),
                  const SizedBox(height: 20),
                  CustomTextField(
                      controller: _emailController, labelText: 'Email'),
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
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomDropdown(
                    label: 'Gender',
                    items: _genders,
                    selectedValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Consumer<NationalityProvider>(
                    builder: (context, provider, child) {
                      List<String> nationalities =
                          provider.nationalities.map((n) => n.name).toList();
                      return CustomDropdown(
                        label: 'Nationality',
                        items: nationalities,
                        selectedValue: _selectedNationality,
                        onChanged: (value) {
                          setState(() {
                            _selectedNationality = value;
                          });
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Consumer<SignUpProvider>(
              builder: (context, signUpProvider, child) {
                return signUpProvider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : DarkCustomButton(
                        text: 'Sign Up',
                        onPressed: () {
                          final nationalityProvider =
                              Provider.of<NationalityProvider>(context,
                                  listen: false);

                          final selectedNationalityId = nationalityProvider
                              .nationalities
                              .firstWhere((n) => n.name == _selectedNationality)
                              .id;

                          Provider.of<SignUpProvider>(context, listen: false)
                              .signupUser(
                            context: context,
                            name: _nameController.text,
                            email: _emailController.text,
                            phone: _phoneController.text,
                            password: _passwordController.text,
                            gender: _selectedGender ?? '',
                            nationalityId: selectedNationalityId.toString(), 
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
