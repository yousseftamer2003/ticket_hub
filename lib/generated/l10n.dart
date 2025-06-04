// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `mini-van`
  String get Hiace {
    return Intl.message('mini-van', name: 'Hiace', desc: '', args: []);
  }

  /// `Bus`
  String get Bus {
    return Intl.message('Bus', name: 'Bus', desc: '', args: []);
  }

  /// `Train`
  String get train {
    return Intl.message('Train', name: 'train', desc: '', args: []);
  }

  /// `One-Way`
  String get one_way {
    return Intl.message('One-Way', name: 'one_way', desc: '', args: []);
  }

  /// `Round-Trip`
  String get round_trip {
    return Intl.message('Round-Trip', name: 'round_trip', desc: '', args: []);
  }

  /// `From`
  String get from {
    return Intl.message('From', name: 'from', desc: '', args: []);
  }

  /// `To`
  String get to {
    return Intl.message('To', name: 'to', desc: '', args: []);
  }

  /// `Ticket Price`
  String get ticketPrice {
    return Intl.message(
      'Ticket Price',
      name: 'ticketPrice',
      desc: '',
      args: [],
    );
  }

  /// `No. of Travelers`
  String get noOfTravelers {
    return Intl.message(
      'No. of Travelers',
      name: 'noOfTravelers',
      desc: '',
      args: [],
    );
  }

  /// `Select Date`
  String get select_date {
    return Intl.message('Select Date', name: 'select_date', desc: '', args: []);
  }

  /// `Travel Date`
  String get travelDate {
    return Intl.message('Travel Date', name: 'travelDate', desc: '', args: []);
  }

  /// `Search`
  String get Search {
    return Intl.message('Search', name: 'Search', desc: '', args: []);
  }

  /// `Number Of Travelers`
  String get number_of_travelers {
    return Intl.message(
      'Number Of Travelers',
      name: 'number_of_travelers',
      desc: '',
      args: [],
    );
  }

  /// `Departure From`
  String get departure_from {
    return Intl.message(
      'Departure From',
      name: 'departure_from',
      desc: '',
      args: [],
    );
  }

  /// `Arrival To`
  String get arrival_to {
    return Intl.message('Arrival To', name: 'arrival_to', desc: '', args: []);
  }

  /// `Select a city`
  String get select_a_city {
    return Intl.message(
      'Select a city',
      name: 'select_a_city',
      desc: '',
      args: [],
    );
  }

  /// `Private`
  String get private {
    return Intl.message('Private', name: 'private', desc: '', args: []);
  }

  /// `Points`
  String get points {
    return Intl.message('Points', name: 'points', desc: '', args: []);
  }

  /// `Ticket Easy`
  String get ticketEasy {
    return Intl.message('Ticket Easy', name: 'ticketEasy', desc: '', args: []);
  }

  /// `Comfortable and easy trips, book now and enjoy a unique travel experience!`
  String get comfortableAndEasyTrips {
    return Intl.message(
      'Comfortable and easy trips, book now and enjoy a unique travel experience!',
      name: 'comfortableAndEasyTrips',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `My Trips`
  String get myTrips {
    return Intl.message('My Trips', name: 'myTrips', desc: '', args: []);
  }

  /// `Profile`
  String get Profile {
    return Intl.message('Profile', name: 'Profile', desc: '', args: []);
  }

  /// `Upcoming`
  String get upcoming {
    return Intl.message('Upcoming', name: 'upcoming', desc: '', args: []);
  }

  /// `Previous`
  String get previous {
    return Intl.message('Previous', name: 'previous', desc: '', args: []);
  }

  /// `No trips available`
  String get noTripsAvailable {
    return Intl.message(
      'No trips available',
      name: 'noTripsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Wallet`
  String get wallet {
    return Intl.message('Wallet', name: 'wallet', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message('Get Started', name: 'getStarted', desc: '', args: []);
  }

  /// `Travel with Ease`
  String get travelWithEase {
    return Intl.message(
      'Travel with Ease',
      name: 'travelWithEase',
      desc: '',
      args: [],
    );
  }

  /// `Enjoy a fast and convient booking experience for modern and safe buses`
  String get enjoyAFastAndConvientBookingExperienceForModernAndSafeBuses {
    return Intl.message(
      'Enjoy a fast and convient booking experience for modern and safe buses',
      name: 'enjoyAFastAndConvientBookingExperienceForModernAndSafeBuses',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Welcome Back`
  String get WelcomeBack {
    return Intl.message(
      'Welcome Back',
      name: 'WelcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Login to your account`
  String get loginToYourAccount {
    return Intl.message(
      'Login to your account',
      name: 'loginToYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Or login with`
  String get orLoginWith {
    return Intl.message(
      'Or login with',
      name: 'orLoginWith',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dontHaveAnAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message('Sign Up', name: 'signUp', desc: '', args: []);
  }

  /// `Welcome`
  String get welcome {
    return Intl.message('Welcome', name: 'welcome', desc: '', args: []);
  }

  /// `Create a new account`
  String get createANewAccount {
    return Intl.message(
      'Create a new account',
      name: 'createANewAccount',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Phone`
  String get phone {
    return Intl.message('Phone', name: 'phone', desc: '', args: []);
  }

  /// `Gender`
  String get gender {
    return Intl.message('Gender', name: 'gender', desc: '', args: []);
  }

  /// `Nationality`
  String get nationality {
    return Intl.message('Nationality', name: 'nationality', desc: '', args: []);
  }

  /// `Please select departure and arrival`
  String get selectdeparturearrival {
    return Intl.message(
      'Please select departure and arrival',
      name: 'selectdeparturearrival',
      desc: '',
      args: [],
    );
  }

  /// `Go to Login`
  String get goToLogin {
    return Intl.message('Go to Login', name: 'goToLogin', desc: '', args: []);
  }

  /// `Ticket Price`
  String get ticket_price {
    return Intl.message(
      'Ticket Price',
      name: 'ticket_price',
      desc: '',
      args: [],
    );
  }

  /// `CONFIRMED`
  String get confirmed {
    return Intl.message('CONFIRMED', name: 'confirmed', desc: '', args: []);
  }

  /// `CANCELLED`
  String get cancelled {
    return Intl.message('CANCELLED', name: 'cancelled', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Forget Password?`
  String get forgetPasswordTitle {
    return Intl.message(
      'Forget Password?',
      name: 'forgetPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter Email or Phone`
  String get emailOrPhonePlaceholder {
    return Intl.message(
      'Enter Email or Phone',
      name: 'emailOrPhonePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPasswordButton {
    return Intl.message(
      'Reset Password',
      name: 'resetPasswordButton',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email or phone number to reset your password.`
  String get forgotPasswordMessage {
    return Intl.message(
      'Please enter your email or phone number to reset your password.',
      name: 'forgotPasswordMessage',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get new_password {
    return Intl.message(
      'New Password',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `Create a new password`
  String get create_new_password {
    return Intl.message(
      'Create a new password',
      name: 'create_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Please fill all fields`
  String get password_empty {
    return Intl.message(
      'Please fill all fields',
      name: 'password_empty',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get password_mismatch {
    return Intl.message(
      'Passwords do not match',
      name: 'password_mismatch',
      desc: '',
      args: [],
    );
  }

  /// `OTP Verification`
  String get otp_verification {
    return Intl.message(
      'OTP Verification',
      name: 'otp_verification',
      desc: '',
      args: [],
    );
  }

  /// `Check your email`
  String get check_email {
    return Intl.message(
      'Check your email',
      name: 'check_email',
      desc: '',
      args: [],
    );
  }

  /// `We sent a reset link to {email}. Enter the 6-digit code mentioned in the email.`
  String enter_otp_code(Object email) {
    return Intl.message(
      'We sent a reset link to $email. Enter the 6-digit code mentioned in the email.',
      name: 'enter_otp_code',
      desc: '',
      args: [email],
    );
  }

  /// `Invalid OTP`
  String get invalid_otp {
    return Intl.message('Invalid OTP', name: 'invalid_otp', desc: '', args: []);
  }

  /// `Please enter a valid 6-digit code`
  String get valid_otp_prompt {
    return Intl.message(
      'Please enter a valid 6-digit code',
      name: 'valid_otp_prompt',
      desc: '',
      args: [],
    );
  }

  /// `Don’t receive code?`
  String get dont_receive_code {
    return Intl.message(
      'Don’t receive code?',
      name: 'dont_receive_code',
      desc: '',
      args: [],
    );
  }

  /// `Re-send`
  String get resend {
    return Intl.message('Re-send', name: 'resend', desc: '', args: []);
  }

  /// `Reset Password`
  String get reset_password {
    return Intl.message(
      'Reset Password',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `My Points`
  String get myPoints {
    return Intl.message('My Points', name: 'myPoints', desc: '', args: []);
  }

  /// `Your Current Points`
  String get currentPoints {
    return Intl.message(
      'Your Current Points',
      name: 'currentPoints',
      desc: '',
      args: [],
    );
  }

  /// `Conversion Options`
  String get conversionOptions {
    return Intl.message(
      'Conversion Options',
      name: 'conversionOptions',
      desc: '',
      args: [],
    );
  }

  /// `No data available`
  String get noDataAvailable {
    return Intl.message(
      'No data available',
      name: 'noDataAvailable',
      desc: '',
      args: [],
    );
  }

  /// `No conversion options available`
  String get noConversionOptions {
    return Intl.message(
      'No conversion options available',
      name: 'noConversionOptions',
      desc: '',
      args: [],
    );
  }

  /// `Select Currency`
  String get selectCurrency {
    return Intl.message(
      'Select Currency',
      name: 'selectCurrency',
      desc: '',
      args: [],
    );
  }

  /// `Choose a currency`
  String get chooseCurrency {
    return Intl.message(
      'Choose a currency',
      name: 'chooseCurrency',
      desc: '',
      args: [],
    );
  }

  /// `Redeem My Points`
  String get redeemMyPoints {
    return Intl.message(
      'Redeem My Points',
      name: 'redeemMyPoints',
      desc: '',
      args: [],
    );
  }

  /// `Currency`
  String get currency {
    return Intl.message('Currency', name: 'currency', desc: '', args: []);
  }

  /// ` points ➜ `
  String get pointsConversion {
    return Intl.message(
      ' points ➜ ',
      name: 'pointsConversion',
      desc: '',
      args: [],
    );
  }

  /// `Points converted successfully`
  String get successfulConversion {
    return Intl.message(
      'Points converted successfully',
      name: 'successfulConversion',
      desc: '',
      args: [],
    );
  }

  /// `Private Booking`
  String get private_booking {
    return Intl.message(
      'Private Booking',
      name: 'private_booking',
      desc: '',
      args: [],
    );
  }

  /// `Which city are you from?`
  String get select_your_city {
    return Intl.message(
      'Which city are you from?',
      name: 'select_your_city',
      desc: '',
      args: [],
    );
  }

  /// `Select your city`
  String get select_city_hint {
    return Intl.message(
      'Select your city',
      name: 'select_city_hint',
      desc: '',
      args: [],
    );
  }

  /// `Address From`
  String get address_from {
    return Intl.message(
      'Address From',
      name: 'address_from',
      desc: '',
      args: [],
    );
  }

  /// `Enter your address`
  String get address_from_hint {
    return Intl.message(
      'Enter your address',
      name: 'address_from_hint',
      desc: '',
      args: [],
    );
  }

  /// `Which city are you to?`
  String get select_city_to {
    return Intl.message(
      'Which city are you to?',
      name: 'select_city_to',
      desc: '',
      args: [],
    );
  }

  /// `Address To`
  String get address_to {
    return Intl.message('Address To', name: 'address_to', desc: '', args: []);
  }

  /// `Enter your destination`
  String get address_to_hint {
    return Intl.message(
      'Enter your destination',
      name: 'address_to_hint',
      desc: '',
      args: [],
    );
  }

  /// `Select Car Brand`
  String get select_car_brand {
    return Intl.message(
      'Select Car Brand',
      name: 'select_car_brand',
      desc: '',
      args: [],
    );
  }

  /// `Select Car Brand`
  String get select_car_brand_hint {
    return Intl.message(
      'Select Car Brand',
      name: 'select_car_brand_hint',
      desc: '',
      args: [],
    );
  }

  /// `Travelers Count`
  String get travelers_count {
    return Intl.message(
      'Travelers Count',
      name: 'travelers_count',
      desc: '',
      args: [],
    );
  }

  /// `Book`
  String get book_button {
    return Intl.message('Book', name: 'book_button', desc: '', args: []);
  }

  /// `Booking successful!`
  String get booking_successful {
    return Intl.message(
      'Booking successful!',
      name: 'booking_successful',
      desc: '',
      args: [],
    );
  }

  /// `Booking failed. Try again later.`
  String get booking_failed {
    return Intl.message(
      'Booking failed. Try again later.',
      name: 'booking_failed',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load user data`
  String get failed_to_load_user_data {
    return Intl.message(
      'Failed to load user data',
      name: 'failed_to_load_user_data',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Edit Profile`
  String get edit_profile {
    return Intl.message(
      'Edit Profile',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get enter_name {
    return Intl.message(
      'Enter your name',
      name: 'enter_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get enter_email {
    return Intl.message(
      'Enter your email',
      name: 'enter_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone`
  String get enter_phone {
    return Intl.message(
      'Enter your phone',
      name: 'enter_phone',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get edit_profile_button {
    return Intl.message(
      'Edit Profile',
      name: 'edit_profile_button',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully!`
  String get profile_updated {
    return Intl.message(
      'Profile updated successfully!',
      name: 'profile_updated',
      desc: '',
      args: [],
    );
  }

  /// `Failed to update profile.`
  String get profile_update_failed {
    return Intl.message(
      'Failed to update profile.',
      name: 'profile_update_failed',
      desc: '',
      args: [],
    );
  }

  /// `Wallet Recharge`
  String get wallet_recharge {
    return Intl.message(
      'Wallet Recharge',
      name: 'wallet_recharge',
      desc: '',
      args: [],
    );
  }

  /// `Enter Amount`
  String get enter_amount {
    return Intl.message(
      'Enter Amount',
      name: 'enter_amount',
      desc: '',
      args: [],
    );
  }

  /// `Select Payment Method`
  String get select_payment_method {
    return Intl.message(
      'Select Payment Method',
      name: 'select_payment_method',
      desc: '',
      args: [],
    );
  }

  /// `Upload Image`
  String get upload_image {
    return Intl.message(
      'Upload Image',
      name: 'upload_image',
      desc: '',
      args: [],
    );
  }

  /// `No image selected`
  String get no_image_selected {
    return Intl.message(
      'No image selected',
      name: 'no_image_selected',
      desc: '',
      args: [],
    );
  }

  /// `Image selected and converted to Base64`
  String get image_selected {
    return Intl.message(
      'Image selected and converted to Base64',
      name: 'image_selected',
      desc: '',
      args: [],
    );
  }

  /// `Submit Recharge`
  String get submit_recharge {
    return Intl.message(
      'Submit Recharge',
      name: 'submit_recharge',
      desc: '',
      args: [],
    );
  }

  /// `Please fill all fields and upload an image`
  String get error_fill_fields {
    return Intl.message(
      'Please fill all fields and upload an image',
      name: 'error_fill_fields',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success_dialog_title {
    return Intl.message(
      'Success',
      name: 'success_dialog_title',
      desc: '',
      args: [],
    );
  }

  /// `Wallet recharge request submitted successfully.`
  String get success_dialog_message {
    return Intl.message(
      'Wallet recharge request submitted successfully.',
      name: 'success_dialog_message',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error_message {
    return Intl.message('Error', name: 'error_message', desc: '', args: []);
  }

  /// `Wallet`
  String get wallet_screen_title {
    return Intl.message(
      'Wallet',
      name: 'wallet_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `User Balance`
  String get user_balance {
    return Intl.message(
      'User Balance',
      name: 'user_balance',
      desc: '',
      args: [],
    );
  }

  /// `Transaction History`
  String get transaction_history {
    return Intl.message(
      'Transaction History',
      name: 'transaction_history',
      desc: '',
      args: [],
    );
  }

  /// `No transactions available.`
  String get no_transactions {
    return Intl.message(
      'No transactions available.',
      name: 'no_transactions',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
