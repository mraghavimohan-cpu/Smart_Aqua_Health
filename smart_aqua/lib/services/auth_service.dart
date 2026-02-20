class AuthService {
  static List<Map<String, String>> users = [];

  static bool register(String name, String phone, String password) {
    bool userExists =
        users.any((user) => user['phone'] == phone);

    if (userExists) {
      return false;
    }

    users.add({
      'name': name,
      'phone': phone,
      'password': password,
    });

    return true;
  }

  static bool login(String phone, String password) {
    return users.any((user) =>
        user['phone'] == phone &&
        user['password'] == password);
  }
}