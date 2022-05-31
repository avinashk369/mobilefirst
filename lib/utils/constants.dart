import 'package:flutter/material.dart';

/// A utility class that holds constants for useful and commonly
/// used values throughout the entire app.
/// This class has no constructor and all variables are `static`.
@immutable
class Constants {
  const Constants._();

  /// The regular expression for validating emails in the app.
  /// RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static RegExp emailRegex = RegExp(
    r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  /// The regular expression for validating contacts in the app.
  static RegExp contactRegex = RegExp(r"^\+?0[0-9]{10}$");

  /// The regular expression for validating full names in the app.
  static RegExp fullNameRegex = RegExp(r'^[a-zA-Z ]+$');

  /// The regular expression for validating zip codes in the app.
  static RegExp zipCodeRegex = RegExp(r'^\d{6}$');

  /// The regular expression for validating credit card numbers in the app.
  static RegExp creditCardNumberRegex =
      RegExp(r'^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14})$');

  /// The regular expression for validating credit card CVV in the app.
  static RegExp creditCardCVVRegex = RegExp(r'^[0-9]{3}$');

  /// The regular expression for validating credit card expiry in the app.
  static RegExp creditCardExpiryRegex =
      RegExp(r'(0[1-9]|10|11|12)/20[0-9]{2}$');

  /// The regular expression for validating credit card expiry in the app.
  static final RegExp otpDigitRegex = RegExp('^[0-9]{6}\$');

  /// invalid otp
  static const invalidOtp = "Please enter valid OTP";

  /// The error message for invalid email input.
  static const invalidEmailError = 'Please enter a valid email address';

  /// The error message for empty email input.
  static const emptyEmailInputError = 'Please enter an email';

  /// The error message for empty password input.
  static const emptyPasswordInputError = 'Please enter a password';

  /// The error message for invalid confirm password input.
  static const invalidConfirmPwError = "Passwords don't match";

  /// The error message for invalid current password input.
  static const invalidCurrentPwError = 'Invalid current password!';

  /// The error message for invalid new password input.
  static const invalidNewPwError = "Current and new password can't be same";

  /// The error message for invalid full name input.
  static const invalidFullNameError = 'Please enter a valid full name';

  /// The error message for empty address input.
  static const emptyAddressInputError = 'Please enter a address';

  /// The error message for empty cinema branch input.
  static const emptyBranchInputError = 'Please enter the branch name';

  /// The error message for invalid contact input.
  static const invalidContactError = 'Please enter a valid mobile number';

  /// The error message for invalid zip code input.
  static const invalidZipCodeError = 'Please enter a valid zip code';

  /// The error message for invalid promo code input.
  static const invalidPromoCodeError = 'Please enter a valid promo code';

  /// The error message for invalid credit card number input.
  static const invalidCreditCardNumberError = 'Invalid credit card number';

  /// The error message for invalid credit card CVV input.
  static const invalidCreditCardCVVError = 'Please enter a valid CVV';

  /// The error message for invalid credit card expiry input.
  static const invalidCreditCardExpiryError =
      'Please enter a valid expiry date';

  static T? toNull<T>(Object? _) => null;
}
