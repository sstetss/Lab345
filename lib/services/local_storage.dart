import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

abstract class LocalStorage {
  Future<void> saveUser(User user);
  Future<User?> getUser();
  Future<void> deleteUser();
}

class LocalStorageImpl implements LocalStorage {
  final SharedPreferences prefs;

  LocalStorageImpl(this.prefs);

  @override
  Future<void> saveUser(User user) async {
    await prefs.setString('user_email', user.email);
    await prefs.setString('user_password', user.password);
    await prefs.setString('user_name', user.name);
  }

  @override
  Future<User?> getUser() async {
    final email = prefs.getString('user_email');
    final password = prefs.getString('user_password');
    final name = prefs.getString('user_name');

    if (email != null && password != null && name != null) {
      return User(email: email, password: password, name: name);
    }
    return null;
  }

  @override
  Future<void> deleteUser() async {
    await prefs.remove('user_email');
    await prefs.remove('user_password');
    await prefs.remove('user_name');
  }
}
