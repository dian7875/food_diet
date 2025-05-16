
/* cuano este el api ajustar
import 'package:dio/dio.dart';
class foodService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://FALTATHIS.com/api',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
      // 'Authorization': 'Bearer TOKEN(NO SE SI VAMOS A TENER)',
    },
  ));

  Future<List<Map<String, dynamic>>> getRecipes() async {
    try {
      final response = await _dio.get('/recipes');
      final data = response.data;

      if (data is Map && data.containsKey('recipes')) {
        return List<Map<String, dynamic>>.from(data['recipes']);
      } else {
        throw Exception('Formato de respuesta inesperado');
      }
    } on DioException catch (e) {
      throw Exception('Error al cargar recetas: ${e.message}');
    }
  }
}
*/
class FoodService {
  Future<List<Map<String, dynamic>>> getRecipes() async {
    await Future.delayed(const Duration(seconds: 1)); // Simula tiempo de red

    return [
      {
        "name": "Ensalada tibia de quinoa con vegetales asados y aguacate",
        "description":
            "Una ensalada nutritiva con quinoa, pimientos, calabacín y cebolla asados, aderezada con aguacate cremoso.",
        "ingredients": [
          "Quinoa",
          "Pimiento rojo",
          "Pimiento amarillo",
          "Calabacín",
          "Cebolla morada",
          "Aguacate",
          "Aceite de oliva",
          "Jugo de limón",
          "Hierbas provenzales",
          "Sal",
          "Pimienta"
        ],
        "steps": [
          "Precalentar el horno a 200°C.",
          "Cortar los pimientos, el calabacín y la cebolla en trozos.",
          "Mezclar los vegetales con aceite de oliva, sal y hierbas provenzales. Hornear por 20-25 minutos o hasta que estén tiernos y ligeramente dorados.",
          "Cocinar la quinoa según las instrucciones del paquete.",
          "Cortar el aguacate en cubos o láminas.",
          "Combinar la quinoa tibia con los vegetales asados y el aguacate.",
          "Aderezar con jugo de limón, sal y pimienta al gusto.",
          "Servir."
        ],
        "dietary_info": ["Vegetariana", "Sin gluten"]
      },
      {
        "name": "Curry de garbanzos y espinacas con leche de coco",
        "description":
            "Un curry reconfortante y lleno de sabor con garbanzos, espinacas, tomate y leche de coco.",
        "ingredients": [
          "Garbanzos cocidos",
          "Espinacas frescas",
          "Tomate triturado",
          "Leche de coco",
          "Cebolla",
          "Ajo",
          "Jengibre",
          "Curry en polvo",
          "Comino",
          "Cilantro fresco",
          "Aceite vegetal",
          "Sal"
        ],
        "steps": [
          "Calentar aceite vegetal en una olla grande a fuego medio.",
          "Sofreír la cebolla picada hasta que esté transparente.",
          "Añadir el ajo y el jengibre rallados y cocinar por un minuto más.",
          "Incorporar el curry en polvo y el comino, cocinar por 30 segundos, revolviendo constantemente.",
          "Agregar el tomate triturado y cocinar por unos minutos.",
          "Verter la leche de coco y llevar a ebullición suave.",
          "Añadir los garbanzos cocidos y cocinar a fuego lento por 10-15 minutos para que los sabores se mezclen.",
          "Incorporar las espinacas y cocinar hasta que se marchiten.",
          "Sazonar con sal al gusto.",
          "Servir caliente, espolvoreado con cilantro fresco picado."
        ],
        "dietary_info": ["Vegetariana", "Sin gluten", "Sin lácteos"]
      }
    ];
  }
}
