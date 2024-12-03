abstract class BaseUserRepository {
  Future<void> registerUser(String email, String password, String name);
  Future<bool> loginUser(String email, String password);
  Future<Map<String, String>> getUserData();
  Future<void> updateUserData(Map<String, String> newData);
  Future<void> deleteUser();
}
