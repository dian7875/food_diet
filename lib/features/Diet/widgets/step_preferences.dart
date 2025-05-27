import 'package:flutter/material.dart';
import 'preference_card.dart';

class StepPreferences extends StatefulWidget {
  final List<String> selectedPreferences;
  final void Function(List<String>) onPreferencesChanged;

  const StepPreferences({
    super.key,
    required this.selectedPreferences,
    required this.onPreferencesChanged,
  });

  @override
  State<StepPreferences> createState() => _StepPreferencesState();
}

class _StepPreferencesState extends State<StepPreferences> {
  late List<String> selected;

  final Map<String, List<Map<String, dynamic>>> groupedFoodOptions = {
    'Proteínas y grasas': [
      {'name': 'Pollo', 'icon': 'assets/icons/pollo.png'},
      {'name': 'Res', 'icon': 'assets/icons/res.png'},
      {'name': 'Cerdo', 'icon': 'assets/icons/cerdo.png'},
      {'name': 'Atún', 'icon': 'assets/icons/atun.png'},
      {'name': 'Mariscos', 'icon': 'assets/icons/mariscos.png'},
      {'name': 'Pescado', 'icon': 'assets/icons/pescado.png'},
      {'name': 'Salmón', 'icon': 'assets/icons/salmon.png'},
      {'name': 'Huevo', 'icon': 'assets/icons/huevo.png'},
      {'name': 'Queso', 'icon': 'assets/icons/queso.png'},
    ],
    'Granos y carbohidratos': [
      {'name': 'Arroz', 'icon': 'assets/icons/arroz.png'},
      {'name': 'Quinoa', 'icon': 'assets/icons/quinoa.png'},
      {'name': 'Maíz', 'icon': 'assets/icons/maiz.png'},
      {'name': 'Lentejas', 'icon': 'assets/icons/lentejas.png'},
      {'name': 'Garbanzos', 'icon': 'assets/icons/garbanzos.png'},
      {'name': 'Frijoles', 'icon': 'assets/icons/frijoles.png'},
      {'name': 'Pastas', 'icon': 'assets/icons/pastas.png'},
      {'name': 'Avena', 'icon': 'assets/icons/avena.png'},
      {'name': 'Cereales', 'icon': 'assets/icons/cereales.png'},
      {'name': 'Frutos Secos', 'icon': 'assets/icons/frutos_secos.png'},
      {'name': 'Pan Blanco', 'icon': 'assets/icons/pan_blanco.png'},
      {'name': 'Pan Integral', 'icon': 'assets/icons/pan_integral.png'},
    ],
    'Frutas': [
      {'name': 'Manzana', 'icon': 'assets/icons/manzana.png'},
      {'name': 'Banano', 'icon': 'assets/icons/banano.png'},
      {'name': 'Mango', 'icon': 'assets/icons/mango.png'},
      {'name': 'Fresa', 'icon': 'assets/icons/fresa.png'},
      {'name': 'Maracuyá', 'icon': 'assets/icons/maracuya.png'},
      {'name': 'Papaya', 'icon': 'assets/icons/papaya.png'},
      {'name': 'Uvas', 'icon': 'assets/icons/uvas.png'},
      {'name': 'Naranja', 'icon': 'assets/icons/naranja.png'},
      {'name': 'Arándanos', 'icon': 'assets/icons/arandanos.png'},
      {'name': 'Piña', 'icon': 'assets/icons/pina.png'},
      {'name': 'Sandía', 'icon': 'assets/icons/sandia.png'},
      {'name': 'Pitahaya', 'icon': 'assets/icons/pitahaya.png'},
    ],
    'Verduras y vegetales': [
      {'name': 'Papa', 'icon': 'assets/icons/papa.png'},
      {'name': 'Chayote', 'icon': 'assets/icons/chayote.png'},
      {'name': 'Yuca', 'icon': 'assets/icons/yuca.png'},
      {'name': 'Camote', 'icon': 'assets/icons/camote.png'},
      {'name': 'Zanahoria', 'icon': 'assets/icons/zanahoria.png'},
      {'name': 'Elote', 'icon': 'assets/icons/elote.png'},
      {'name': 'Repollo', 'icon': 'assets/icons/repollo.png'},
      {'name': 'Lechuga', 'icon': 'assets/icons/lechuga.png'},
      {'name': 'Brocolí', 'icon': 'assets/icons/brocoli.png'},
      {'name': 'Coliflor', 'icon': 'assets/icons/coliflor.png'},
      {'name': 'Pepino', 'icon': 'assets/icons/pepino.png'},
      {'name': 'Tomate', 'icon': 'assets/icons/tomate.png'},
    ],
  };

  @override
  void initState() {
    super.initState();
    selected = List.from(widget.selectedPreferences);
  }

  void toggleSelection(String food) {
    setState(() {
      if (selected.contains(food)) {
        selected.remove(food);
      } else {
        selected.add(food);
      }
      widget.onPreferencesChanged(selected);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            groupedFoodOptions.entries.map((group) {
              final groupName = group.key;
              final options = group.value;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selecciona las $groupName de tu preferencia',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children:
                          options.map((item) {
                            final name = item['name'] as String;
                            final iconPath = item['icon'] as String;
                            final isSelected = selected.contains(name);

                            return PreferenceCard(
                              name: name,
                              iconPath: iconPath,
                              isSelected: isSelected,
                              onTap: () => toggleSelection(name),
                            );
                          }).toList(),
                    ),
                  ],
                ),
              );
            }).toList(),
      ),
    );
  }
}
