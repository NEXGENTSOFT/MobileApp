import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MyEditProjectPage extends StatefulWidget {
  const MyEditProjectPage({
    super.key,
    required this.projectUUID,
    required this.name,
    required this.description,
    required this.title,
  });

  final String projectUUID;
  final String title;
  final String name;
  final String description;

  @override
  State<MyEditProjectPage> createState() => _MyEditProjectPageState();
}

class _MyEditProjectPageState extends State<MyEditProjectPage> {
  Color colorpage = Color(0xFF4A4E69);
  Color buttonIN = Color(0xFFD2A351);
  Color letraA = Color(0xFF22223B);
  Color uno = Color(0xFFF2E9E4);
  Color label = Color(0xFFB78471);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set initial values for the controllers
    _nameController.text = widget.name;
    _descriptionController.text = widget.description;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _updateProject() async {
    final String name = _nameController.text;
    final String description = _descriptionController.text;

    if (name.isEmpty || description.isEmpty) {
      return;
    }

    try {
      var url = Uri.parse('https://servidor-toposmart.zapto.org/projectsmanagement/projects');

      var response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "uuid": widget.projectUUID,
          "name": name,
          "description": description,
        }),
      );

      if (response.statusCode == 200) {
        print(response.body);
        Navigator.pop(context, {
          'name': name,
          'description': description,
        });
      } else {
        print('Failed to update project. Reason: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception while updating project: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
              height: screenHeight * 0.1,
              child: Stack(
                children: [
                  Text(
                    'Editar proyecto',
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
            SizedBox(height: screenHeight * 0.01),
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
            SizedBox(height: screenHeight * 0.04),
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
            SizedBox(height: screenHeight * 0.01),
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
            SizedBox(height: screenHeight * 0.1),
            Container(
              child: Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _updateProject,
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
