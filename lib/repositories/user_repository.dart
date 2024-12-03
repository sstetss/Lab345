import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  final SharedPreferences _sharedPreferences;

  UserRepository(this._sharedPreferences);

  // Метод для перевірки, чи користувач вже авторизований
  Future<bool> checkIfLoggedIn() async {
    final email = _sharedPreferences.getString('email');
    final password = _sharedPreferences.getString('password');
    return email != null && password != null;
  }

  // Метод для логіну
  Future<bool> loginUser(String email, String password) async {
    // Імітуємо перевірку користувача на сервері
    final success = true; // Якщо все успішно, повертаємо true
    if (success) {
      await _sharedPreferences.setString('email', email);
      await _sharedPreferences.setString('password', password);
    }
    return success;
  }

  // Метод для реєстрації користувача
  Future<void> registerUser(String email, String password, String name) async {
    // Перевірка чи вже є зареєстрований користувач
    final existingEmail = _sharedPreferences.getString('email');
    if (existingEmail != null) {
      throw Exception('User already registered');
    }

    // Імітуємо реєстрацію (можна додати додаткову логіку)
    await _sharedPreferences.setString('email', email);
    await _sharedPreferences.setString('password', password);
    await _sharedPreferences.setString('name', name);
  }

  // Метод для виходу
  Future<void> logoutUser() async {
    await _sharedPreferences.remove('email');
    await _sharedPreferences.remove('password');
    await _sharedPreferences.remove('name'); // Видалення імені також
  }
}

