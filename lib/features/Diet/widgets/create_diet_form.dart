import 'package:flutter/material.dart';
import 'package:food_diet/features/Diet/services/diet_service.dart';

class CreateDietForm extends StatefulWidget {
  const CreateDietForm({super.key});

  @override
  State<CreateDietForm> createState() => _CreateDietFormState();
}

class _CreateDietFormState extends State<CreateDietForm> {
  final DietService _dietService = DietService();

  int currentStep = 0;

  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController conditionController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  String? objective;
  List<Map<String, dynamic>> conditions = [];

  final formKeyStep1 = GlobalKey<FormState>();

  void _nextStep() {
    if (formKeyStep1.currentState!.validate()) {
      setState(() => currentStep = 1);
    }
  }

  Future<void> _addCondition() async {
    final condition = conditionController.text.trim();
    final notes = notesController.text.trim();
    if (condition.isEmpty && notes.isEmpty) return;

    // Aquí, por ejemplo, asignamos un id temporal (esto debería cambiar cuando uses un backend).
    final int id = DateTime.now().millisecondsSinceEpoch;

    await _dietService.addCondition({'condition': condition, 'notes': notes});

    setState(() {
      conditions.add({'id': id, 'condicion': condition, 'notas': notes});
      conditionController.clear();
      notesController.clear();
    });
  }

  Future<void> _submitForm() async {
    try {
      await _dietService.updateProfile({
        'age': ageController.text,
        'height': heightController.text,
        'weight': weightController.text,
        'objective': objective,
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dieta creada exitosamente')),
      );

      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error al guardar: $e')));
    }
  }

  void _editCondition(int index) {
    conditionController.text = conditions[index]['condicion'] ?? '';
    notesController.text = conditions[index]['notas'] ?? '';
    setState(() {
      conditions.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Dieta'),
        centerTitle: true,
        backgroundColor: const Color(0xFFD1D696),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: IndexedStack(
          index: currentStep,
          children: [
            Form(
              key: formKeyStep1,
              child: Column(
                children: [
                  TextFormField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Edad'),
                    validator: (v) => v!.isEmpty ? 'Campo requerido' : null,
                  ),
                  TextFormField(
                    controller: heightController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Altura (cm)'),
                    validator: (v) => v!.isEmpty ? 'Campo requerido' : null,
                  ),
                  TextFormField(
                    controller: weightController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Peso (kg)'),
                    validator: (v) => v!.isEmpty ? 'Campo requerido' : null,
                  ),
                  DropdownButtonFormField<String>( 
                    value: objective,
                    decoration: const InputDecoration(labelText: 'Objetivo'),
                    items: const [
                      DropdownMenuItem(
                        value: 'Perder peso',
                        child: Text('Perder peso'),
                      ),
                      DropdownMenuItem(
                        value: 'Mantener peso',
                        child: Text('Mantener peso'),
                      ),
                      DropdownMenuItem(
                        value: 'Ganar músculo',
                        child: Text('Ganar músculo'),
                      ),
                    ],
                    onChanged: (v) => setState(() => objective = v),
                    validator:
                        (v) => v == null ? 'Seleccione una opción' : null,
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: _nextStep,
                      child: const Text('Siguiente'),
                    ),
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Condiciones de salud',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: conditionController,
                  decoration: const InputDecoration(
                    labelText: 'Condición (ej. Diabetes)',
                  ),
                ),
                TextField(
                  controller: notesController,
                  decoration: const InputDecoration(
                    labelText: 'Notas (ej. alimentos restringidos)',
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _addCondition,
                  child: const Text('Agregar condición'),
                ),
                const SizedBox(height: 10),
                if (conditions.isNotEmpty)
                  ...conditions.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    return ListTile(
                      leading: const Icon(Icons.check),
                      title: Text(item['condicion'] ?? ''),
                      subtitle: Text(item['notas'] ?? ''),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _editCondition(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              final conditionId = item['id'];
                              await _dietService.deleteCondition(conditionId);
                              setState(() {
                                conditions.removeWhere(
                                  (c) => c['id'] == conditionId,
                                );
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  }),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () =>
                          setState(() => currentStep = currentStep - 1),
                      child: const Text('Atrás'),
                    ),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Guardar'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
