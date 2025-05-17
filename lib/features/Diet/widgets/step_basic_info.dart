import 'package:flutter/material.dart';

class StepBasicInfo extends StatelessWidget {
  final TextEditingController ageController;
  final TextEditingController heightController;
  final TextEditingController weightController;
  final String? objective;
  final GlobalKey<FormState> formKey;
  final ValueChanged<String?> onObjectiveChanged;

  const StepBasicInfo({
    super.key,
    required this.ageController,
    required this.heightController,
    required this.weightController,
    required this.objective,
    required this.formKey,
    required this.onObjectiveChanged,
  });

  @override
  Widget build(BuildContext context) {
    const objectives = [
      'Perder peso',
      'Mantener peso',
      'Ganar músculo',
      'Mejorar salud',
    ];

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Información básica', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 16),

          // Edad
          TextFormField(
            controller: ageController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Edad',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Ingrese su edad';
              final n = int.tryParse(value);
              if (n == null || n < 1 || n > 120) return 'Edad inválida';
              return null;
            },
          ),
          const SizedBox(height: 12),

          // Altura
          TextFormField(
            controller: heightController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Altura (cm)',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Ingrese su altura';
              final n = double.tryParse(value);
              if (n == null || n < 50 || n > 300) return 'Altura inválida';
              return null;
            },
          ),
          const SizedBox(height: 12),

          // Peso
          TextFormField(
            controller: weightController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Peso (kg)',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Ingrese su peso';
              final n = double.tryParse(value);
              if (n == null || n < 10 || n > 500) return 'Peso inválido';
              return null;
            },
          ),
          const SizedBox(height: 12),

          // Objetivo
          DropdownButtonFormField<String>(
            value: objective,
            decoration: const InputDecoration(
              labelText: 'Objetivo',
              border: OutlineInputBorder(),
            ),
            items: objectives
                .map((obj) => DropdownMenuItem(
                      value: obj,
                      child: Text(obj),
                    ))
                .toList(),
            onChanged: onObjectiveChanged,
            validator: (value) =>
                (value == null || value.isEmpty) ? 'Seleccione un objetivo' : null,
          ),
        ],
      ),
    );
  }
}
