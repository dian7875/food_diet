import 'package:flutter/material.dart';

class PreferenceCard extends StatelessWidget {
  final String name;
  final IconData iconData;
  final bool selected;
  final VoidCallback onTap;

  const PreferenceCard({
    super.key,
    required this.name,
    required this.iconData,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: selected ? Colors.green[400] : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? Colors.green : Colors.grey,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(iconData, color: selected ? Colors.white : Colors.black54),
            const SizedBox(width: 8),
            Text(
              name,
              style: TextStyle(
                color: selected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
