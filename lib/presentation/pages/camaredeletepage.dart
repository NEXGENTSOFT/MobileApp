import 'package:flutter/material.dart';
import 'dart:io';

class ConfirmDeletePage extends StatelessWidget {
  final File imageFile;

  const ConfirmDeletePage({Key? key, required this.imageFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eliminar imagen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.file(imageFile),
          SizedBox(height: 20),
          Text('¿Desea eliminar esta imagen?', style: TextStyle(fontSize: 18,),),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, true); // Confirmar eliminación
                },
                child: Text('Sí'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, false); // Cancelar eliminación
                },
                child: Text('No'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
