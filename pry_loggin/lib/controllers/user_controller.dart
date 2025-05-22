import 'package:flutter/material.dart';
import '../model/user_model.dart';
import '../services/data_provider.dart';

class UserController with ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Cargar perfil de usuario por ID
  Future<void> loadUserProfile(String userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final users = await DataProvider.loadUsers();
      _user = users.firstWhere((user) => user.user_id == userId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error al cargar perfil de usuario: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Actualizar perfil de usuario
  Future<bool> updateUserProfile({
    required String id,
    required String nombre,
    required String apellido,
    required String email,
    required String direccion,
    required String ciudad,
    required String provincia,
    required String telefono,
    required String codigoPostal,
    String? password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Obtener el usuario actual para preservar la contraseña actual si no se proporciona una nueva
      final currentUser = await DataProvider.getUserByEmail(email);
      if (currentUser == null) {
        _errorMessage = 'Usuario no encontrado';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final updatedUser = User(
        user_id: id,
        firstName: nombre,
        lastName: apellido,
        email: email,
        password: password ?? currentUser.password,
        address: direccion,
        city: ciudad,
        province: provincia,
        phone: telefono,
        zipCode: codigoPostal,
      );

      await DataProvider.updateUser(updatedUser);
      _user = updatedUser;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Error al actualizar perfil: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Cambiar contraseña
  Future<bool> changePassword(String currentPassword, String newPassword) async {
    if (_user == null) {
      _errorMessage = 'No hay usuario autenticado';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Verificar la contraseña actual
      final user = await DataProvider.getUserByCredentials(_user!.email, currentPassword);
      if (user == null) {
        _errorMessage = 'La contraseña actual es incorrecta';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      // Actualizar con la nueva contraseña
      final updatedUser = User(
        user_id: _user!.user_id,
        firstName: _user!.firstName,
        lastName: _user!.lastName,
        email: _user!.email,
        password: newPassword,
        address: _user!.address,
        city: _user!.city,
        province: _user!.province,
        phone: _user!.phone,
        zipCode: _user!.zipCode,
      );

      await DataProvider.updateUser(updatedUser);
      _user = updatedUser;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Error al cambiar contraseña: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Limpiar mensaje de error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Establecer usuario actual (útil cuando se recién se autentica)
  void setCurrentUser(User user) {
    _user = user;
    notifyListeners();
  }
}