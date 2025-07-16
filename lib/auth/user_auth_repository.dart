import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'password_hasher.dart';
import '../data/models/user.dart';

class UserAuthRepository extends ChangeNotifier {
  static const _usersKey = 'studies_users_json';
  static const _loggedInUserKey = 'logged_in_user';

  String? _currentUsername;

  String? get currentUsername => _currentUsername;

  UserAuthRepository() {
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    _currentUsername = prefs.getString(_loggedInUserKey);
    notifyListeners();
  }

  Future<List<User>> _readUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString(_usersKey);
    if (usersJson == null) {
      return [];
    }
    try {
      final List<dynamic> usersList = json.decode(usersJson);
      return usersList.map((json) => User.fromJson(json)).toList();
    } catch (e) {
      debugPrint("Erro ao decodificar usuários: $e");
      return [];
    }
  }

  Future<void> _writeUsers(List<User> users) async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = json.encode(users.map((user) => user.toJson()).toList());
    await prefs.setString(_usersKey, usersJson);
  }

  Future<bool> registerUser(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      debugPrint("Tentativa de registro com campos vazios.");
      return false;
    }

    final users = await _readUsers();
    if (users.any((user) => user.username.toLowerCase() == username.toLowerCase())) {
      debugPrint("Usuário '$username' já existe.");
      return false;
    }

    final passwordHash = PasswordHasher.hashPassword(password);
    users.add(User(username: username, passwordHash: passwordHash));
    await _writeUsers(users);
    debugPrint("Usuário '$username' registrado com sucesso.");
    return true;
  }

  Future<bool> loginUser(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      debugPrint("Tentativa de login com campos vazios.");
      return false;
    }

    final users = await _readUsers();
    final user = users.firstWhere(
      (user) => user.username.toLowerCase() == username.toLowerCase(),
      orElse: () => User(username: '', passwordHash: ''),
    );

    if (user.username.isEmpty) {
      debugPrint("Usuário '$username' não encontrado para login.");
      return false;
    }

    final passwordHash = PasswordHasher.hashPassword(password);
    if (user.passwordHash == passwordHash) {
      debugPrint("Login bem-sucedido para '$username'.");
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_loggedInUserKey, username);
      _currentUsername = username;
      notifyListeners();
      return true;
    } else {
      debugPrint("Senha incorreta para '$username'.");
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_loggedInUserKey);
    _currentUsername = null;
    notifyListeners();
    debugPrint("Usuário deslogado.");
  }
}