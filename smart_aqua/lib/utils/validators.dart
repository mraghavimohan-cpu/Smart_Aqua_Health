class Validators {
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number required";
    }
    if (value.length != 10) {
      return "Phone number must be 10 digits";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password required";
    }
    if (value.length < 8) {
      return "Minimum 8 characters required";
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "Must contain one uppercase letter";
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return "Must contain one lowercase letter";
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "Must contain one number";
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return "Must contain one special character";
    }
    return null;
  }
}
