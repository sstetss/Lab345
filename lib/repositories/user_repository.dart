import 'package:shared_preferences/shared_preferences.dart';
import 'base_user_repository.dart';

class UserRepository extends BaseUserRepository {
  final SharedPreferences _prefs;

  UserRepository(this._prefs);

  @override
  Future<void> registerUser(String email, String password, String name) async {
    await _prefs.setString('email', email);
    await _prefs.setString('password', password);
    await _prefs.setString('name', name);
  }

  @override
  Future<bool> loginUser(String email, String password) async {
    final storedEmail = _prefs.getString('email');
    final storedPassword = _prefs.getString('password');
    return storedEmail == email && storedPassword == password;
  }

  @override
  Future<Map<String, String>> getUserData() async {
    return {
      'email': _prefs.getString('email') ?? '',
      'name': _prefs.getString('name') ?? '',
    };
  }

  @override
  Future<void> updateUserData(Map<String, String> newData) async {
    await _prefs.setString('name', newData['name'] ?? '');
  }

  @override
  Future<void> deleteUser() async {
    await _prefs.clear();
  }
}
