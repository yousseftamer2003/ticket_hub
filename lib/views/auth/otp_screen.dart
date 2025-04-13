import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:ticket_hub/constant/colors.dart';
import 'package:ticket_hub/constant/widgets/custom_appbar_widget.dart';
import 'package:ticket_hub/controller/auth/otp_provider.dart';
import 'package:ticket_hub/views/auth/new_password_screen.dart';

import '../../generated/l10n.dart' show S;

class OtpPasswordScreen extends StatefulWidget {
  const OtpPasswordScreen({super.key, required this.email});
  final String email;

  @override
  State<OtpPasswordScreen> createState() => _OtpPasswordScreenState();
}

class _OtpPasswordScreenState extends State<OtpPasswordScreen> {
  int _countdown = 180;
  Timer? _timer;
  String _otpCode = "";

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          if (_countdown < 1) {
            timer.cancel();
          } else {
            _countdown--;
          }
        });
      },
    );
  }

  String get timerText {
    int minutes = _countdown ~/ 60;
    int seconds = _countdown % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void verifyOtp(BuildContext context) async {
    if (_otpCode.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          S.of(context).valid_otp_prompt,
        )),
      );
      return;
    }

    final provider =
        Provider.of<ForgotPasswordProvider>(context, listen: false);
    await provider.checkCode(widget.email, _otpCode);

    if (provider.message != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => NewPasswordScreen(
            email: widget.email,
            code: _otpCode,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(provider.errorMessage ?? S.of(context).invalid_otp)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 214, 212, 212),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: blackColor),
      ),
    );

    return Scaffold(
      appBar: customAppBar(context, S.of(context).otp_verification),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                S.of(context).check_email,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Text(
              'We sent a reset link to ${widget.email}. Enter the 6-digit code mentioned in the email.',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Color(0xFF7C7C7C),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: blackColor, width: 2),
                  ),
                ),
                onCompleted: (pin) => setState(() {
                  _otpCode = pin;
                }),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                timerText,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text.rich(
                TextSpan(
                  text: S.of(context).dont_receive_code,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF7C7C7C),
                  ),
                  children: [
                    TextSpan(
                      text: S.of(context).resend,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: blackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Consumer<ForgotPasswordProvider>(
                builder: (context, provider, child) {
                  return ElevatedButton(
                    onPressed:
                        provider.isLoading ? null : () => verifyOtp(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blackColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 100),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                    child: provider.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            S.of(context).reset_password,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
