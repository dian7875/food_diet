import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/recipe_service.dart';
import '../widgets/country_dropdown.dart';
import '../widgets/recipe_card.dart';
import '../widgets/recipe_detail_sheet.dart';

class ForeignFoodsScreen extends StatefulWidget {
  const ForeignFoodsScreen({super.key});

  @override
  State<ForeignFoodsScreen> createState() => _ForeignFoodsScreenState();
}

class _ForeignFoodsScreenState extends State<ForeignFoodsScreen> {
  final RecipeService _recipeService = RecipeService();
  String? selectedCountry;
  List<Recipe> recipes = [];
  List<String> countries = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  Future<void> _loadCountries() async {
    try {
      final loadedCountries = await _recipeService.getCountries();
      setState(() {
        countries = loadedCountries;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar los países: $e')),
        );
      }
    }
  }

  Future<void> _updateRecipes(String? country) async {
    setState(() {
      selectedCountry = country;
      isLoading = true;
    });

    if (country != null) {
      try {
        final loadedRecipes = await _recipeService.getRecipesByCountry(country);
        setState(() {
          recipes = loadedRecipes;
          isLoading = false;
        });
      } catch (e) {
        setState(() => isLoading = false);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al cargar las recetas: $e')),
          );
        }
      }
    } else {
      setState(() {
        recipes = [];
        isLoading = false;
      });
    }
  }

  void _showRecipeDetails(Recipe recipe) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => RecipeDetailSheet(recipe: recipe),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(
            'https://i.ibb.co/BhTNZx8/imagen-2025-05-25-160645331.png',
            height: 100,
            fit: BoxFit.contain,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const SizedBox(
                height: 100,
                child: Center(child: CircularProgressIndicator()),
              );
            },
          ),
          const SizedBox(height: 16),
          CountryDropdown(
            value: selectedCountry,
            countries: countries,
            onChanged: _updateRecipes,
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        SizedBox(height: 32),
        Text(
          '¡Explora sabores del mundo!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            'Selecciona un país para descubrir sus deliciosas recetas tradicionales',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    if (isLoading && countries.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (recipes.isEmpty) {
      return _buildWelcomeContent();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return RecipeCard(
          recipe: recipe,
          onTap: () => _showRecipeDetails(recipe),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAF0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD1D696),
        elevation: 0,
        title: Text(
          selectedCountry == null
              ? 'Comidas del Mundo'
              : 'Recetas de $selectedCountry',
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [_buildHeader(), Expanded(child: _buildContent())],
        ),
      ),
    );
  }
}
