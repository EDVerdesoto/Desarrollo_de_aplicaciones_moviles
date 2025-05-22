import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/foundation.dart';
import 'package:pry_loggin/model/user_model.dart';

class DataProvider {
  static const String _fileName = 'users.json';

  //Obtener la ruta del archivo
  static Future<File> _getFile() async{

    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');

  }
  //Guardar todos los usuarios
  static Future<void> saveUsers(List<User> users) async {
    try{
      final file= await _getFile();
      final usersJson = users.map((user)=> user.toJson()).toList();
      await file.writeAsString(jsonEncode(usersJson));
    }catch (e) {
      debugPrint('Error al guardar usuarios UnU : $e');
      throw Exception('No se pudo guardar usuarios UnU : $e');
    }
  }

  //Cargar todos los usuarios
  static Future<List<User>> loadUsers() async{
    try{
      final file = await _getFile();
      if(!await file.exists()) {
        //si el archivo no existe , crear uno con una Lista vacia
        await file.writeAsString(jsonEncode([]));
        return [];
      }
      final content = await file.readAsString();
      final List<dynamic> jsonData = jsonDecode(content);
      return jsonData.map((json) => User.fromJson(json)).toList();
    }catch (e) {
      debugPrint('Error al cargar usuarios UnU: $e');
      return [];
    }
  }

  // Agregar un nuevo usuario
  static Future<void> addUser(User user) async {
    final users = await loadUsers();
    users.add(user);
    await saveUsers(users);
  }

  // Verificar si existe un usuario con email específico
  static Future<bool> userExistsByEmail(String email) async {
    final users = await loadUsers();
    return users.any((user) => user.email.toLowerCase() == email.toLowerCase());
  }

  // Obtener un usuario por email y contraseña (para login)
  static Future<User?> getUserByCredentials(String email, String password) async {
    final users = await loadUsers();
    try {
      return users.firstWhere(
              (user) => user.email.toLowerCase() == email.toLowerCase() &&
              user.password == password
      );
    } catch (e) {
      return null; // No se encontró el usuario
    }
  }

  // Obtener un usuario por email (para recuperación de contraseña)
  static Future<User?> getUserByEmail(String email) async {
    final users = await loadUsers();
    try {
      return users.firstWhere(
              (user) => user.email.toLowerCase() == email.toLowerCase()
      );
    } catch (e) {
      return null; // No se encontró el usuario
    }
  }

  // Actualizar un usuario
  static Future<void> updateUser(User updatedUser) async {
    final users = await loadUsers();
    final index = users.indexWhere((user) => user.user_id == updatedUser.user_id);

    if (index != -1) {
      users[index] = updatedUser;
      await saveUsers(users);
    } else {
      throw Exception('Usuario no encontrado.');
    }
  }

}
