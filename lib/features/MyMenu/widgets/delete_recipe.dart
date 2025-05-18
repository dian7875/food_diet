import 'package:flutter/material.dart';

Future<void> showDeleteConfirmationDialog({
  required BuildContext context,
  required VoidCallback onConfirm,
}) async {
  return showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text('¿Eliminar receta?'),
        content: const Text('Esta acción no se puede deshacer. ¿Deseas continuar?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(), 
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white,),
            onPressed: () {
              Navigator.of(dialogContext).pop();
              onConfirm();
            },
            child: const Text('Eliminar'),
          ),
        ],
      );
    },
  );
}
