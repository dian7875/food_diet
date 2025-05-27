import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:food_diet/features/Auth/services/auth_service.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}
class _MyProfileScreenState extends State<MyProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();

  String? _selectedObjective;

  final List<String> _objectives = [
    'Perder peso',
    'Mantener peso',
    'Ganar músculo',
    'Mejorar salud',
  ];
  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }
  Future<void> _loadProfileData() async {
    await Future.delayed(const Duration(seconds: 1));

    // Obtener email del usuario autenticado
    final userEmail = await _authService.getUserEmail();
    _emailController.text = userEmail ?? 'usuario@ejemplo.com';

    final profileData = {
      "edad": "29",
      "altura": "175",
      "peso": "70",
      "objetivo": "Mantener peso",
    };

    _edadController.text = profileData["edad"] ?? '';
    _alturaController.text = profileData["altura"] ?? '';
    _pesoController.text = profileData["peso"] ?? '';
    _selectedObjective = profileData["objetivo"];

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _updateProfileData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    final updatedData = {
      "edad": _edadController.text,
      "altura": _alturaController.text,
      "peso": _pesoController.text,
      "objetivo": _selectedObjective ?? '',
    };

    print('Datos enviados para actualizar: $updatedData');

    setState(() {
      _isSaving = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Perfil actualizado correctamente')),
    );
  }
  Future<void> _logout() async {
    // Mostrar diálogo de confirmación
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar sesión'),
        content: const Text('¿Estás seguro que deseas cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Cerrar sesión'),
          ),
        ],
      ),
    );
    
    if (confirm == true) {
      await _authService.logout();
      if (mounted) {
        context.go('/login');
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _edadController.dispose();
    _alturaController.dispose();
    _pesoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final greenHeight = size.height * 0.1;    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        backgroundColor: const Color(0xFFD1D696),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () => _logout(),
          ),
        ],
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            height: greenHeight,
            width: double.infinity,
            color: const Color(0xFFD1D696),
          ),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: greenHeight - 50),
                          Center(
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey.shade300,
                              child: const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                          ),                          const SizedBox(height: 32),
                          _buildEmailInfo(),
                          _buildInputField(
                            label: 'Edad',
                            controller: _edadController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingresa tu edad';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Ingresa un número válido';
                              }
                              return null;
                            },
                          ),
                          _buildInputField(
                            label: 'Altura (cm)',
                            controller: _alturaController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingresa tu altura';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Ingresa un número válido';
                              }
                              return null;
                            },
                          ),
                          _buildInputField(
                            label: 'Peso (kg)',
                            controller: _pesoController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingresa tu peso';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Ingresa un número válido';
                              }
                              return null;
                            },
                          ),
                          DropdownButtonFormField<String>(
                            value: _selectedObjective,
                            decoration: const InputDecoration(
                              labelText: 'Objetivo',
                              border: OutlineInputBorder(),
                            ),
                            items: _objectives
                                .map((objective) => DropdownMenuItem<String>(
                                      value: objective,
                                      child: Text(objective),
                                    ))
                                .toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedObjective = newValue;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor selecciona un objetivo';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(
                                      255,
                                      255,
                                      255,
                                      255,
                                    ),
                                    foregroundColor: Colors.black87,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                  ),
                                  onPressed: () {
                                      context.go('/MyProfile/special-needs');
                                  },
                                  child: const Text(
                                    'Mis necesidades especiales',
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFD1D696),
                                    foregroundColor: Colors.black87,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                  ),
                                  onPressed: _isSaving ? null : _updateProfileData,
                                  child: _isSaving
                                      ? const SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Text('Guardar cambios'),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        keyboardType: (label == 'Edad' ||
                label.contains('Altura') ||
                label.contains('Peso'))
            ? TextInputType.number
            : TextInputType.text,
        validator: validator,
      ),
    );
  }
  
  // Widget para mostrar la información del email
  Widget _buildEmailInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundColor: Color(0xFFD1D696),
            child: Icon(
              Icons.email,
              size: 22,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _emailController.text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
