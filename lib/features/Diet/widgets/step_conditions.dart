import 'package:flutter/material.dart';

class StepConditions extends StatefulWidget {
  final List<Map<String, String>> initialConditions;
  final void Function(List<Map<String, String>>) onConditionsChanged;

  const StepConditions({
    super.key,
    required this.initialConditions,
    required this.onConditionsChanged,
  });

  @override
  State<StepConditions> createState() => _StepConditionsState();
}

class _StepConditionsState extends State<StepConditions> {
  final conditionController = TextEditingController();
  final notesController = TextEditingController();

  late List<Map<String, String>> conditions;

  @override
  void initState() {
    super.initState();
    conditions = List.from(widget.initialConditions);
  }

  @override
  void dispose() {
    conditionController.dispose();
    notesController.dispose();
    super.dispose();
  }

  void _addCondition() {
    final condition = conditionController.text.trim();
    final notes = notesController.text.trim();
    if (condition.isEmpty) {
      return;
    }

    setState(() {
      conditions.add({'condition': condition, 'notes': notes});
      conditionController.clear();
      notesController.clear();
    });

    widget.onConditionsChanged(conditions);
  }

  void _editCondition(int index) {
    conditionController.text = conditions[index]['condition'] ?? '';
    notesController.text = conditions[index]['notes'] ?? '';
    setState(() {
      conditions.removeAt(index);
    });
    widget.onConditionsChanged(conditions);
  }

  void _removeCondition(int index) {
    setState(() {
      conditions.removeAt(index);
    });
    widget.onConditionsChanged(conditions);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Condiciones de salud', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          TextField(
            controller: conditionController,
            decoration: const InputDecoration(labelText: 'Condición (ej. Diabetes)'),
          ),
          TextField(
            controller: notesController,
            decoration: const InputDecoration(labelText: 'Notas (ej. alimentos restringidos)'),
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
                title: Text(item['condition'] ?? ''),
                subtitle: Text(item['notes'] ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _editCondition(index),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _removeCondition(index),
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }
}
