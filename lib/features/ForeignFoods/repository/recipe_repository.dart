import '../models/recipe.dart';

class RecipeRepository {
  static final List<Recipe> recipes = [
    // Japón 🇯🇵
    Recipe(
      name: 'Sushi Roll',
      country: 'Japón 🇯🇵',
      description: 'Rollos de arroz con pescado fresco y vegetales',
      imageUrl: 'https://i.ibb.co/KcHpYS6d/sushi.jpg',
      ingredients: [
        'Arroz para sushi',
        'Pescado fresco (salmón o atún)',
        'Alga nori',
        'Pepino',
        'Aguacate',
      ],
      steps: [
        'Cocinar el arroz para sushi según las instrucciones',
        'Cortar el pescado en tiras finas',
        'Extender el alga nori sobre la esterilla de bambú',
        'Cubrir con una capa uniforme de arroz',
        'Agregar los ingredientes en el centro',
        'Enrollar firmemente usando la esterilla',
        'Cortar en porciones iguales',
      ],
    ),
    Recipe(
      name: 'Tempura',
      country: 'Japón 🇯🇵',
      description: 'Vegetales y mariscos fritos en una ligera capa de masa',
      imageUrl: 'https://i.ibb.co/LhsjSFWs/imagen-2025-05-25-195812157.png',
      ingredients: [
        'Camarones',
        'Berenjena',
        'Zanahoria',
        'Harina para tempura',
        'Agua fría',
        'Aceite vegetal',
      ],
      steps: [
        'Preparar la mezcla de harina y agua',
        'Sumergir los ingredientes en la mezcla',
        'Freír en aceite caliente hasta dorar',
        'Escurrir el exceso de aceite',
        'Servir con salsa tentsuyu',
      ],
    ),

    // Italia 🇮🇹
    Recipe(
      name: 'Pasta Carbonara',
      country: 'Italia 🇮🇹',
      description: 'Pasta cremosa con panceta y queso pecorino',
      imageUrl: 'https://i.ibb.co/c0qN0vd/image.png',
      ingredients: [
        'Espaguetis',
        'Panceta',
        'Huevos',
        'Queso pecorino romano',
        'Pimienta negra',
      ],
      steps: [
        'Cocinar la pasta al dente',
        'Dorar la panceta en cubos',
        'Mezclar huevos con queso rallado',
        'Combinar la pasta caliente con la mezcla de huevo',
        'Agregar la panceta y pimienta',
      ],
    ),
    Recipe(
      name: 'Lasagna',
      country: 'Italia 🇮🇹',
      description: 'Capas de pasta con carne, salsa de tomate y bechamel',
      imageUrl: 'https://i.ibb.co/XksWHYv8/imagen-2025-05-25-200033503.png',
      ingredients: [
        'Láminas de lasaña',
        'Carne molida',
        'Salsa de tomate',
        'Bechamel',
        'Queso parmesano',
      ],
      steps: [
        'Cocinar la carne con la salsa',
        'Hervir las láminas de lasaña',
        'Alternar capas de pasta, carne y bechamel',
        'Cubrir con queso',
        'Hornear hasta gratinar',
      ],
    ),

    // Tailandia 🇹🇭
    Recipe(
      name: 'Pad Thai',
      country: 'Tailandia 🇹🇭',
      description: 'Fideos de arroz salteados con camarones y cacahuetes',
      imageUrl: 'https://i.ibb.co/Kxyz6dGx/imagen-2025-05-25-160307131.png',
      ingredients: [
        'Fideos de arroz',
        'Camarones',
        'Huevo',
        'Brotes de soja',
        'Cacahuetes triturados',
        'Salsa de pescado',
      ],
      steps: [
        'Remojar los fideos en agua caliente',
        'Saltear los camarones',
        'Agregar el huevo y revolverlo',
        'Incorporar los fideos y la salsa',
        'Servir con cacahuetes y limón',
      ],
    ),
    Recipe(
      name: 'Som Tam',
      country: 'Tailandia 🇹🇭',
      description: 'Ensalada picante de papaya verde rallada',
      imageUrl: 'https://i.ibb.co/kscJwH9c/imagen-2025-05-25-200120592.png',
      ingredients: [
        'Papaya verde rallada',
        'Ajo',
        'Chile rojo',
        'Jugo de lima',
        'Salsa de pescado',
        'Cacahuetes',
      ],
      steps: [
        'Machacar ajo y chile',
        'Añadir papaya rallada y mezclar',
        'Agregar jugo de lima y salsa de pescado',
        'Incorporar cacahuetes al final',
        'Servir fresca',
      ],
    ),

    // México 🇲🇽
    Recipe(
      name: 'Tacos al Pastor',
      country: 'México 🇲🇽',
      description: 'Tortillas con carne marinada, piña y cebolla',
      imageUrl: 'https://i.ibb.co/m51kxdDx/imagen-2025-05-25-200235035.png',
      ingredients: [
        'Tortillas de maíz',
        'Carne de cerdo marinada',
        'Piña',
        'Cebolla',
        'Cilantro',
        'Limón',
      ],
      steps: [
        'Cocinar la carne marinada',
        'Calentar las tortillas',
        'Servir la carne sobre las tortillas',
        'Agregar piña, cebolla y cilantro',
        'Rociar con jugo de limón',
      ],
    ),
    Recipe(
      name: 'Chiles en Nogada',
      country: 'México 🇲🇽',
      description: 'Chile poblano relleno con salsa de nuez y granada',
      imageUrl: 'https://i.ibb.co/byRgBQL/imagen-2025-05-25-200317202.png',
      ingredients: [
        'Chiles poblanos',
        'Picadillo de carne y frutas',
        'Nueces',
        'Leche o crema',
        'Granada',
        'Perejil',
      ],
      steps: [
        'Asar y pelar los chiles',
        'Preparar el picadillo y rellenar',
        'Licuar las nueces con crema para la nogada',
        'Cubrir los chiles con la salsa',
        'Decorar con granada y perejil',
      ],
    ),

    // Francia 🇫🇷
    Recipe(
      name: 'Ratatouille',
      country: 'Francia 🇫🇷',
      description: 'Estofado de vegetales provenzal',
      imageUrl: 'https://i.ibb.co/nNDqdrWh/imagen-2025-05-25-200358306.png',
      ingredients: [
        'Berenjena',
        'Calabacín',
        'Pimiento rojo',
        'Tomate',
        'Ajo',
        'Hierbas provenzales',
      ],
      steps: [
        'Cortar los vegetales en rodajas',
        'Saltear ajo y cebolla',
        'Agregar los vegetales en capas',
        'Condimentar con hierbas y cocinar a fuego lento',
        'Servir caliente con pan',
      ],
    ),
    Recipe(
      name: 'Crêpes',
      country: 'Francia 🇫🇷',
      description: 'Delgadas tortillas dulces o saladas',
      imageUrl: 'https://i.ibb.co/nNDZH72y/imagen-2025-05-25-200450743.png',
      ingredients: [
        'Harina',
        'Huevos',
        'Leche',
        'Mantequilla',
        'Sal',
        'Azúcar (si es dulce)',
      ],
      steps: [
        'Mezclar los ingredientes hasta formar una masa líquida',
        'Verter en una sartén caliente y extender',
        'Cocinar por ambos lados',
        'Rellenar con ingredientes dulces o salados',
        'Doblar y servir',
      ],
    ),
  ];

  static List<String> getCountries() {
    return recipes.map((recipe) => recipe.country).toSet().toList();
  }

  static List<Recipe> getRecipesByCountry(String country) {
    return recipes.where((recipe) => recipe.country == country).toList();
  }
}
