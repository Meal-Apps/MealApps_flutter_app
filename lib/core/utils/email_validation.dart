bool validateEmail(String email) {
  String pattern = r'^[a-zA-Z0-9._%+-]+@gmail\.com$'; // adjust pattern as needed
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(email)) {
    return false;
  }
  return true;
}