import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/authentication_controller.dart';
import 'login_page.dart';
import 'home_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _direccionController = TextEditingController();
  final _ciudadController = TextEditingController();
  final _provinciaController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _codigoPostalController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _direccionController.dispose();
    _ciudadController.dispose();
    _provinciaController.dispose();
    _telefonoController.dispose();
    _codigoPostalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear cuenta'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.cyan,
              Colors.blue,
              Colors.purple,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Card(
                  elevation: 0,
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Título
                          const Text(
                            'Registro de nueva cuenta',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Datos personales
                          Row(
                            children: [
                              Expanded(
                                child: _buildTextField(
                                  controller: _nombreController,
                                  label: 'Nombre',
                                  icon: Icons.person,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Ingrese su nombre';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildTextField(
                                  controller: _apellidoController,
                                  label: 'Apellido',
                                  icon: Icons.person,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Ingrese su apellido';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Email
                          _buildTextField(
                            controller: _emailController,
                            label: 'Email',
                            icon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingrese su email';
                              }
                              if (!value.contains('@') || !value.contains('.')) {
                                return 'Ingrese un email válido';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Contraseña
                          _buildTextField(
                            controller: _passwordController,
                            label: 'Contraseña',
                            icon: Icons.lock,
                            obscureText: _obscurePassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility : Icons.visibility_off,
                                color: Colors.white70,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingrese una contraseña';
                              }
                              if (value.length < 6) {
                                return 'La contraseña debe tener al menos 6 caracteres';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Confirmar contraseña
                          _buildTextField(
                            controller: _confirmPasswordController,
                            label: 'Confirmar contraseña',
                            icon: Icons.lock,
                            obscureText: _obscureConfirmPassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                                color: Colors.white70,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword = !_obscureConfirmPassword;
                                });
                              },
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Confirme su contraseña';
                              }
                              if (value != _passwordController.text) {
                                return 'Las contraseñas no coinciden';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Dirección
                          _buildTextField(
                            controller: _direccionController,
                            label: 'Dirección',
                            icon: Icons.home,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingrese su dirección';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Ciudad y Provincia
                          Row(
                            children: [
                              Expanded(
                                child: _buildTextField(
                                  controller: _ciudadController,
                                  label: 'Ciudad',
                                  icon: Icons.location_city,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Ingrese su ciudad';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildTextField(
                                  controller: _provinciaController,
                                  label: 'Provincia',
                                  icon: Icons.map,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Ingrese su provincia';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Teléfono y Código Postal
                          Row(
                            children: [
                              Expanded(
                                child: _buildTextField(
                                  controller: _telefonoController,
                                  label: 'Teléfono',
                                  icon: Icons.phone,
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Ingrese su teléfono';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildTextField(
                                  controller: _codigoPostalController,
                                  label: 'Código Postal',
                                  icon: Icons.markunread_mailbox,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Ingrese su código postal';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Error message
                          if (authController.errorMessage != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Text(
                                authController.errorMessage!,
                                style: const TextStyle(color: Colors.red),
                                textAlign: TextAlign.center,
                              ),
                            ),

                          // Create account button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: authController.isLoading
                                  ? null
                                  : () async {
                                if (_formKey.currentState!.validate()) {
                                  final success = await authController.register(
                                    nombre: _nombreController.text,
                                    apellido: _apellidoController.text,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    direccion: _direccionController.text,
                                    ciudad: _ciudadController.text,
                                    provincia: _provinciaController.text,
                                    telefono: _telefonoController.text,
                                    codigoPostal: _codigoPostalController.text,
                                  );

                                  if (success && mounted) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HomeView(),
                                      ),
                                    );
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.blue,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: authController.isLoading
                                  ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                                  strokeWidth: 2,
                                ),
                              )
                                  : const Text(
                                'Create account',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Already have an account?
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                '¿Ya tienes una cuenta?',
                                style: TextStyle(color: Colors.white),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginView(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Iniciar sesión',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white70),
        suffixIcon: suffixIcon,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white70),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
        errorStyle: const TextStyle(color: Colors.orange),
      ),
      style: const TextStyle(color: Colors.white),
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
    );
  }
}