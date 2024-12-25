///Email Validation
String? validateEmail(String? value) {
  final RegExp regex = RegExp(r'^[a-zA-Z0-9]+(?:[._+-][a-zA-Z0-9]+)*@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}(?:\.[a-zA-Z]{2,})*$', caseSensitive: false);

  if (value == null || value.trim().isEmpty) {
    return 'Please enter an email';
  }

  if (!regex.hasMatch(value.trim())) {
    return 'Please enter a valid email';
  }

  return null;
}

///Password validation
String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter password.';
  } else if (value.length < 8) {
    return 'The password must be at least 8 characters long.';
  } else if (!RegExp(r'(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>])').hasMatch(value)) {
    return 'Password must contain at least 1 uppercase, 1 lowercase, 1 special character, and 1 digit.';
  }
  return null;
}

///Password validation
String? validateName(String? value) {
  RegExp regex = RegExp(r'^[a-zA-Z ]+$');
  if (value == null || value.isEmpty) {
    return 'Please enter name.';
  } else if (value.length < 2) {
    return 'The name must be at least 2 characters long.';
  }else if (!regex.hasMatch(value)) {
    return 'Only Alphabets accepted';
  }
  return null;
}

String? validateDob(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter Date of birth.';
  }
  return null;
}

