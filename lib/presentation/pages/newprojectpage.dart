import 'package:flutter/material.dart';

class MyNewProjectPage extends StatefulWidget {
  const MyNewProjectPage({super.key, required this.title});

  final String title;

  @override
  State<MyNewProjectPage> createState() => _MyNewProjectPageState();
}

class _MyNewProjectPageState extends State<MyNewProjectPage> {
  Color colorpage = Color(0xFF4A4E69);
  Color buttonIN = Color(0xFFD2A351);
  Color letraA = Color(0xFF22223B);
  Color uno = Color(0xFFF2E9E4);
  Color label = Color(0xFFB78471);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeigh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: uno,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: screenHeigh * 0.1,
              child: Stack(
                children: [
                  Text(
                    'Nuevo proyecto',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Nombre del proyecto',
                style: TextStyle(
                  fontFamily: 'Lato-Right',
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: screenHeigh * 0.01),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nombre del proyecto',
                filled: true,
                fillColor: label.withOpacity(0.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: label),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: label),
                ),
                labelStyle: TextStyle(
                  color: letraA,
                  fontFamily: 'Lato-Light',
                  fontSize: 13,
                ),
              ),
              style: TextStyle(
                color: letraA,
                fontSize: 13,
                fontFamily: "Lato-Light",
              ),
            ),
            SizedBox(height: screenHeigh * 0.04),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Descripción del proyecto',
                style: TextStyle(
                  fontFamily: 'Lato-Right',
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: screenHeigh * 0.01),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Descripción del proyecto',
                filled: true,
                fillColor: label.withOpacity(0.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: label),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: label),
                ),
                labelStyle: TextStyle(
                  color: letraA,
                  fontFamily: 'Lato-Light',
                  fontSize: 13,
                ),
              ),
              style: TextStyle(
                color: letraA,
                fontSize: 13,
                fontFamily: "Lato-Light",
              ),
            ),
            SizedBox(height: screenHeigh * 0.1),
            Container(
              child: Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_nameController.text.isNotEmpty && _descriptionController.text.isNotEmpty) {
                        Navigator.pop(context, {
                          'name': _nameController.text,
                          'description': _descriptionController.text,
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonIN,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      'Guardar',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Lato-Regular",
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

