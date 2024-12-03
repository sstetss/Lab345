bool isValidEmail(String email) {
  return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
}

bool isValidName(String name) {
  return RegExp(r'^[a-zA-Z\s]+$').hasMatch(name);
}

bool isValidPassword(String password) {
  return password.length >= 6;
}
