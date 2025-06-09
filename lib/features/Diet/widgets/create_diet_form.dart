import 'package:flutter/material.dart';
import '../services/diet_service.dart';
import 'step_basic_info.dart';
import 'step_conditions.dart';
import 'step_preferences.dart';

class CreateDietForm extends StatefulWidget {
  const CreateDietForm({super.key});

  @override
  State<CreateDietForm> createState() => _CreateDietFormState();
}

class _CreateDietFormState extends State<CreateDietForm> {
  final DietService _dietService = DietService();

  int currentStep = 0;
  bool isLoading = false;

  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  String? objective;

  final formKeyStep1 = GlobalKey<FormState>();

  List<Map<String, String>> conditions = [];
  List<String> selectedPreferences = [];

  void _nextStep() {
    if (currentStep == 0) {
      if (formKeyStep1.currentState!.validate()) {
        setState(() => currentStep++);
      }
    } else if (currentStep == 1) {
      if (conditions.isNotEmpty) {
        setState(() => currentStep++);
      } else {
        setState(() => currentStep++);
      }
    } else {
      setState(() => currentStep++);
    }
  }

  void _prevStep() {
    if (currentStep > 0) {
      setState(() => currentStep--);
    }
  }

Future<void> _submitForm() async {
  setState(() => isLoading = true);
  try {
    final message = await _dietService.updateProfile({
      'age': ageController.text,
      'height': heightController.text,
      'weight': weightController.text,
      'objective': objective,
      'preferences': selectedPreferences,
      'conditions': conditions,
    });

    if (!mounted) return;
    Navigator.of(context).pop(true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  } catch (e) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error al crear la dieta: $e')),
    );
  } finally {
    if (mounted) setState(() => isLoading = false);
  }
}


  @override
  void dispose() {
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final steps = [
      StepBasicInfo(
        ageController: ageController,
        heightController: heightController,
        weightController: weightController,
        objective: objective,
        formKey: formKeyStep1,
        onObjectiveChanged: (val) => setState(() => objective = val),
      ),
      StepConditions(
        initialConditions: conditions,
        onConditionsChanged:
            (updatedConditions) =>
                setState(() => conditions = List.from(updatedConditions)),
      ),
      StepPreferences(
        selectedPreferences: selectedPreferences,
        onPreferencesChanged:
            (prefs) => setState(() => selectedPreferences = List.from(prefs)),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Dieta'),
        backgroundColor: const Color(0xFFD1D696),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(child: steps[currentStep]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentStep > 0)
                  OutlinedButton(
                    onPressed: isLoading ? null : _prevStep,
                    child: const Text('Atrás'),
                  ),
                ElevatedButton(
                  onPressed:
                      isLoading
                          ? null
                          : () {
                            if (currentStep == 0) {
                              if (formKeyStep1.currentState!.validate()) {
                                _nextStep();
                              }
                            } else if (currentStep == steps.length - 1) {
                              _submitForm();
                            } else {
                              _nextStep();
                            }
                          },
                  child:
                      isLoading
                          ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                          : Text(
                            currentStep == steps.length - 1
                                ? 'Guardar'
                                : 'Siguiente',
                          ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
