import 'package:flutter/material.dart';
import 'package:food_diet/features/Diet/widgets/create_diet_form.dart';

class CreateDietButton extends StatelessWidget {
  const CreateDietButton({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => _navigateToCreateDiet(context),
            child: Container(
              height: 180,
              width: 170,
              decoration: BoxDecoration(
                color: const Color(0xD64C7031),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 58, 139, 87),
                    blurRadius: 120,
                    offset: Offset(8, 8),
                  ),
                ],
                borderRadius: BorderRadius.circular(100),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    bottom: 10,
                    child: Image.asset(
                      'assets/images/Logo.png',
                      height: 80,
                      width: 80,
                    ),
                  ),
                  Positioned(
                    top: 40,
                    child: const Text(
                      'Crear Dieta',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToCreateDiet(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateDietForm()),
    );
  }
}
