import 'package:flutter/material.dart';

class DietList extends StatelessWidget {
  DietList({super.key});

  final List<Map<String, String>> dietList = [
    {
      'nombre': 'Ensalada de pollo',
      'descripcion':
          'Ensalada fresca con pollo a la plancha, lechuga, tomate, y aguacate.',
    },
    {
      'nombre': 'Sopa de verduras',
      'descripcion': 'Sopa caliente con zanahorias, papas, cebolla y especias.',
    },
    {
      'nombre': 'Tacos de pescado',
      'descripcion':
          'Tacos con filete de pescado, repollo rallado, y salsa picante.',
    },
    {
      'nombre': 'Batido de frutas',
      'descripcion': 'Batido refrescante con fresas, plátano y yogur natural.',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Recetas disponibles', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,)),
          const SizedBox(height: 20),
          if (dietList.isEmpty)
            const Text('No hay recetas disponibles')
          else
            ...dietList.map((receta) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8),
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFFCA838), width: 4),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        receta['nombre'] ?? 'Nombre no disponible',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        receta['descripcion'] ?? 'Descripción no disponible',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
        ],
      ),
    );
  }
}
