import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food_diet/features/Auth/services/auth_service.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tempPassController = TextEditingController();
  final _newPassController = TextEditingController();
  final _confirmPassController = TextEditingController();


  final authService = AuthService();
  String? email;
  bool _isLoading = false;
  bool _showTempPass = false;
  bool _showNewPass = false;
  bool _showConfirmPass = false;

  @override
  void initState() {
    super.initState();
    _loadEmail();
  }

  Future<void> _loadEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('user_email');
    });
  }

  @override
  void dispose() {
    _tempPassController.dispose();
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate() || email == null) return;

    setState(() => _isLoading = true);

    final message = await authService.changePassword(
      email!,
      _tempPassController.text.trim(),
      _newPassController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (message.toLowerCase().contains('modificada') ||
        message.toLowerCase().contains('exito')) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Contraseña actualizada con éxito')),
        );
        context.go('/login');
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final lightGreen = const Color.fromARGB(255, 213, 213, 152);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cambiar Contraseña'),
        backgroundColor: lightGreen,
        centerTitle: true,
      ),
      body: email == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _tempPassController,
                      obscureText: !_showTempPass,
                      decoration: InputDecoration(
                        labelText: 'Contraseña temporal',
                        prefixIcon: const Icon(Icons.lock),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(_showTempPass ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() => _showTempPass = !_showTempPass);
                          },
                        ),
                      ),
                      validator: (value) =>
                          (value == null || value.isEmpty) ? 'Campo requerido' : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _newPassController,
                      obscureText: !_showNewPass,
                      decoration: InputDecoration(
                        labelText: 'Nueva contraseña',
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(_showNewPass ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() => _showNewPass = !_showNewPass);
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo requerido';
                        }
                        if (value.length < 6) {
                          return 'Debe tener al menos 6 caracteres';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _confirmPassController,
                      obscureText: !_showConfirmPass,
                      decoration: InputDecoration(
                        labelText: 'Confirmar contraseña',
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(_showConfirmPass ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() => _showConfirmPass = !_showConfirmPass);
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value != _newPassController.text) {
                          return 'Las contraseñas no coinciden';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: lightGreen,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Cambiar Contraseña',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () => context.go('/login'),
                      child: const Text(
                        'Volver al inicio de sesión',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}