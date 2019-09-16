

Future<bool> verifyWithUsername(String userName, String pin) async {

  return false;
}

Future<bool> verify(String pin) {
  String userName;
  return verifyWithUsername(userName, pin);
}