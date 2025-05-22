import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../model/user_model.dart';
import '../services/data_provider.dart';

class AuthController with ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _currentUser != null;

  // Inicializar el controlador y verificar si hay una sesión guardada
  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _checkSavedSession();
    } catch (e) {
      _errorMessage = 'Error al inicializar la sesión';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Verificar si hay una sesión guardada (Remember me)
  Future<void> _checkSavedSession() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('saved_email');
    final savedPassword = prefs.getString('saved_password');
    final rememberMe = prefs.getBool('remember_me') ?? false;

    if (rememberMe && savedEmail != null && savedPassword != null) {
      await login(savedEmail, savedPassword, true);
    }
  }

  // Iniciar sesión
  Future<bool> login(String email, String password, bool rememberMe) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final user = await DataProvider.getUserByCredentials(email, password);

      if (user == null) {
        _errorMessage = 'Correo electrónico o contraseña incorrectos';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      _currentUser = user;
      _isLoading = false;

      // Guardar sesión si remember me está activado
      final prefs = await SharedPreferences.getInstance();
      if (rememberMe) {
        await prefs.setString('saved_email', email);
        await prefs.setString('saved_password', password);
        await prefs.setBool('remember_me', true);
      } else {
        // Limpiar datos guardados
        await prefs.remove('saved_email');
        await prefs.remove('saved_password');
        await prefs.setBool('remember_me', false);
      }

      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Error al iniciar sesión: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Registro de usuario
  Future<bool> register({
    required String nombre,
    required String apellido,
    required String email,
    required String password,
    required String direccion,
    required String ciudad,
    required String provincia,
    required String telefono,
    required String codigoPostal,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Verificar si el email ya está registrado
      final exists = await DataProvider.userExistsByEmail(email);
      if (exists) {
        _errorMessage = 'El correo electrónico ya está registrado';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      // Crear nuevo usuario
      final newUser = User(
        user_id: const Uuid().v4(), // Generar ID único
        firstName: nombre,
        lastName: apellido,
        email: email,
        password: password,
        address: direccion,
        city: ciudad,
        province: provincia,
        phone: telefono,
        zipCode: codigoPostal,
      );

      await DataProvider.addUser(newUser);
      _currentUser = newUser;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Error al registrar usuario: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Cerrar sesión
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      _currentUser = null;

      // Limpiar "remember me" si está activado
      final prefs = await SharedPreferences.getInstance();
      if (!(prefs.getBool('remember_me') ?? false)) {
        await prefs.remove('saved_email');
        await prefs.remove('saved_password');
      }
    } catch (e) {
      _errorMessage = 'Error al cerrar sesión: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Solicitar reseteo de contraseña
  Future<bool> requestPasswordReset(String email) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final user = await DataProvider.getUserByEmail(email);

      if (user == null) {
        _errorMessage = 'No existe una cuenta con este correo electrónico';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      // Aquí se implementaría el envío de email para resetear contraseña


      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Error al solicitar reseteo de contraseña: $e';
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
}