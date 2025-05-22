import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/authentication_controller.dart';
import 'login_page.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _resetRequested = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar contraseña'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
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
                          // Icon
                          const Icon(
                            Icons.lock_reset,
                            size: 80,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 24),

                          // Title
                          const Text(
                            'Recuperar contraseña',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Instructions
                          const Text(
                            'Ingresa tu dirección de correo electrónico y te enviaremos un enlace para restablecer tu contraseña.',
                            style: TextStyle(color: Colors.white70),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),

                          if (!_resetRequested) ...[
                            // Email field
                            TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(color: Colors.white70),
                                prefixIcon: Icon(Icons.email, color: Colors.white70),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white70),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white, width: 2),
                                ),
                                errorStyle: TextStyle(color: Colors.orange),
                              ),
                              style: const TextStyle(color: Colors.white),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor ingresa tu correo electrónico';
                                }
                                if (!value.contains('@') || !value.contains('.')) {
                                  return 'Por favor ingresa un correo electrónico válido';
                                }
                                return null;
                              },
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

                            // Submit button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: authController.isLoading
                                    ? null
                                    : () async {
                                  if (_formKey.currentState!.validate()) {
                                    final success = await authController.requestPasswordReset(
                                      _emailController.text,
                                    );

                                    if (success && mounted) {
                                      setState(() {
                                        _resetRequested = true;
                                      });
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
                                  'Enviar enlace',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ] else ...[
                            // Success message
                            const Icon(
                              Icons.check_circle_outline,
                              size: 60,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Hemos enviado un correo a ${_emailController.text} con instrucciones para recuperar tu contraseña.',
                              style: const TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                          ],

                          // Back to login
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginView(),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.arrow_back, color: Colors.white, size: 16),
                                SizedBox(width: 8),
                                Text(
                                  'Volver al inicio de sesión',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
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
}