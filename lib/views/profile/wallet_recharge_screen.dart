import 'package:flutter/material.dart';
import 'package:ticket_hub/constant/widgets/custom_appbar_widget.dart';
import 'package:ticket_hub/constant/widgets/custom_button_widget.dart';
import 'package:ticket_hub/constant/widgets/text_field_widget.dart';
import 'package:ticket_hub/controller/data_list_provider.dart';
import 'package:ticket_hub/controller/wallet/wallet_provider.dart';
import 'package:ticket_hub/model/wallet/list_model.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../../generated/l10n.dart' show S;

class WalletRechargeScreen extends StatefulWidget {
  const WalletRechargeScreen({super.key, required this.walletid});
  final int walletid;

  @override
  WalletRechargeScreenState createState() => WalletRechargeScreenState();
}

class WalletRechargeScreenState extends State<WalletRechargeScreen> {
  final TextEditingController _amountController = TextEditingController();
  String? _selectedPaymentMethod;
  File? _selectedImage;
  String? _base64Image;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<PaymentProvider>(context, listen: false)
        .fetchPaymentData(context));
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64String = base64Encode(imageBytes);

      setState(() {
        _selectedImage = imageFile;
        _base64Image = base64String;
      });
    }
  }

  Future<void> _submitRecharge(BuildContext context) async {
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);

    if (_amountController.text.isEmpty ||
        _selectedPaymentMethod == null ||
        _base64Image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          S.of(context).error_fill_fields,
        )),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      await walletProvider.chargeWallet(
        context,
        widget.walletid.toString(),
        double.parse(_amountController.text),
        _selectedPaymentMethod!,
        _base64Image!,
      );

      _showSuccessDialog();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }

    setState(() {
      _isSubmitting = false;
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          S.of(context).success_dialog_message,
        ),
        content: Text(
          S.of(context).success_dialog_message,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        S.of(context).wallet_recharge,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<PaymentProvider>(
          builder: (context, paymentProvider, child) {
            if (paymentProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (paymentProvider.errorMessage != null) {
              return Center(child: Text(paymentProvider.errorMessage!));
            }
            List<PaymentMethod> paymentMethods =
                paymentProvider.paymentData?.paymentMethods ?? [];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: _amountController,
                  labelText: S.of(context).enter_amount,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).enter_amount;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedPaymentMethod,
                  decoration: InputDecoration(
                    labelText: S.of(context).select_payment_method,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.payment),
                  ),
                  items: paymentMethods
                      .map((method) => DropdownMenuItem<String>(
                            value: method.id.toString(),
                            child: Text(method.name),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: _pickImage,
                      icon: const Icon(Icons.upload),
                      label: Text(
                        S.of(context).upload_image,
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                      ),
                    ),
                    const SizedBox(width: 16),
                    _selectedImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              _selectedImage!,
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Text(
                            S.of(context).no_image_selected,
                            style: const TextStyle(color: Colors.grey),
                          ),
                  ],
                ),
                const SizedBox(height: 16),
                _base64Image != null
                    ? Text(
                        S.of(context).image_selected,
                        style: TextStyle(color: Colors.green),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 24),
                _isSubmitting
                    ? const Center(child: CircularProgressIndicator())
                    : DarkCustomButton(
                        text: S.of(context).submit_recharge,
                        onPressed: () => _submitRecharge(context),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
