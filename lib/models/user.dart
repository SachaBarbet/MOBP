class User {
  static String id = '';
  static String name = '';
  static String lastname = '';
  static String login = '';
  static String password = '';

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'lastname': lastname,
    'login': login,
    'password': password,
  };
}