import 'package:flutter/material.dart';

class CountryDropdown extends StatelessWidget {
  final String? value;
  final List<String> countries;
  final ValueChanged<String?> onChanged;

  const CountryDropdown({
    super.key,
    required this.value,
    required this.countries,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        hint: const Text('Selecciona un país'),
        underline: Container(),
        icon: const Icon(Icons.keyboard_arrow_down),
        items:
            countries
                .map(
                  (country) =>
                      DropdownMenuItem(value: country, child: Text(country)),
                )
                .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
