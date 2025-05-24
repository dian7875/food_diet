import 'package:flutter/material.dart';

class SpecialNeedsScreen extends StatefulWidget {
  const SpecialNeedsScreen({super.key});

  @override
  State<SpecialNeedsScreen> createState() => _SpecialNeedsScreenState();
}

class _SpecialNeedsScreenState extends State<SpecialNeedsScreen> {
  List<Map<String, String>> specialNeeds = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSpecialNeeds();
  }

  Future<void> _fetchSpecialNeeds() async {
  
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      specialNeeds = [
        {'condition': 'Diabetes', 'notes': 'Evitar azúcares y harinas refinadas'},
        {'condition': 'Hipertensión', 'notes': 'Reducir sal y grasas saturadas'},
        {'condition': 'Alergia a gluten', 'notes': 'No consumir trigo, cebada ni centeno'},
      ];
      isLoading = false;
    });
  }

  Future<void> _addOrEditNeed({Map<String, String>? oldValue}) async {
    final conditionController = TextEditingController(text: oldValue?['condition'] ?? '');
    final notesController = TextEditingController(text: oldValue?['notes'] ?? '');

    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(oldValue == null ? 'Agregar necesidad especial' : 'Editar necesidad especial'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: conditionController,
                decoration: const InputDecoration(labelText: 'Condición'),
              ),
              TextField(
                controller: notesController,
                decoration: const InputDecoration(labelText: 'Notas'),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                final condition = conditionController.text.trim();
                if (condition.isEmpty) return;
                final notes = notesController.text.trim();
                Navigator.of(context).pop({'condition': condition, 'notes': notes});
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() {
        if (oldValue == null) {
          specialNeeds.add(result);
        } else {
          final index = specialNeeds.indexOf(oldValue);
          if (index != -1) {
            specialNeeds[index] = result;
          }
        }
      });
    }
  }

  Future<void> _confirmDelete(Map<String, String> value) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmar eliminación'),
          content: Text('¿Seguro que quieres eliminar "${value['condition']}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      setState(() {
        specialNeeds.remove(value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis necesidades especiales'),
        backgroundColor: const Color(0xFFD1D696),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : specialNeeds.isEmpty
              ? const Center(child: Text('No tienes necesidades especiales registradas.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: specialNeeds.length,
                  itemBuilder: (context, index) {
                    final need = specialNeeds[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text(need['condition'] ?? ''),
                        subtitle: Text(need['notes'] ?? ''),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blueAccent),
                              onPressed: () => _addOrEditNeed(oldValue: need),
                              tooltip: 'Editar',
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.redAccent),
                              onPressed: () => _confirmDelete(need),
                              tooltip: 'Eliminar',
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditNeed(),
        backgroundColor: const Color(0xFFD1D696),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        tooltip: 'Añadir necesidad especial',
      ),
    );
  }
}
