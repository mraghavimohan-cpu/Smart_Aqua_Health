class AuthService {
  static final List<Map<String, String>> _users = [];

  static bool register(String name, String phone, String password) {
    bool exists = _users.any((user) => user['phone'] == phone);
    if (exists) return false;

    _users.add({
      'name': name,
      'phone': phone,
      'password': password,
    });

    return true;
  }

  static String login(String phone, String password) {
    final user = _users.firstWhere(
      (u) => u['phone'] == phone,
      orElse: () => {},
    );

    if (user.isEmpty) {
      return "Phone number not registered";
    }

    if (user['password'] != password) {
      return "Incorrect password";
    }

    return "success";
  }
}