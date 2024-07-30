import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:TopoSmart/measurementservices.dart';

import 'newmeasurement.dart'; // Asegúrate de importar el servicio

class MyMeasurementPage extends StatefulWidget {
  const MyMeasurementPage({Key? key, required this.title});

  final String title;

  @override
  _MyMeasurementPageState createState() => _MyMeasurementPageState();
}

class _MyMeasurementPageState extends State<MyMeasurementPage> {
  Color colorpage = Color(0xFF4A4E69);
  Color enca = Color(0xFFFFA099);
  Color com = Color(0xFFC9ADA7);
  Color uno = Color(0xFFF2E9E4);

  List<Map<String, dynamic>> measurementData = [];

  @override
  void initState() {
    super.initState();
    // Forzar orientación horizontal
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _fetchMeasurementData(); // Obtener los datos al iniciar
  }

  @override
  void dispose() {
    // Restablecer orientación a la configuración por defecto cuando se salga de esta página
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  Future<void> _fetchMeasurementData() async {
    try {
      Measurementservices measurementServices = Measurementservices();
      final data = await measurementServices.getMeasurements();
      setState(() {
        measurementData = data;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar los datos: $e')),
      );
    }
  }

  void _updateMeasurementData(Map<String, String> newData) {
    setState(() {
      measurementData.add(newData);
    });
  }

  @override
  Widget build(BuildContext context) {
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
            Text(
              'Mediciones',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            Table(
              border: TableBorder.all(color: Colors.transparent),
              children: [
                _buildTableRow([
                  _buildHeaderCell('EST', backgroundColor: enca),
                  _buildHeaderCell('+', backgroundColor: enca),
                  _buildHeaderCell('ㅈ', backgroundColor: enca),
                  _buildHeaderCell('-', backgroundColor: enca),
                  _buildHeaderCell('Nota', backgroundColor: enca),
                  _buildHeaderCell('T', backgroundColor: enca),
                  _buildHeaderCell('', ),
                ]),
                ...measurementData.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> data = entry.value;
                  return _buildTableRow([
                    _buildDataCell(data['station']?.toString() ?? '', backgroundColor: com),
                    _buildDataCell(data['plus']?.toString() ?? '', backgroundColor: com),
                    _buildDataCell(data['fixedLevel']?.toString() ?? '', backgroundColor: com),
                    _buildDataCell(data['minus']?.toString() ?? '', backgroundColor: com),
                    _buildDataCell(data['notes'] ?? '', backgroundColor: com),
                    _buildDataCell('', backgroundColor: com),
                    _buildActionCell(index,),
                  ]);
                }),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: colorpage,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.add_circle_outline, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyNewMeaPage(title: 'Nuevo Proyecto'),
                  ),
                ).then((newData) {
                  if (newData != null) {
                    _updateMeasurementData(newData);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(List<Widget> children) {
    return TableRow(
      children: children.map((child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        );
      }).toList(),
    );
  }

  Widget _buildHeaderCell(String label, {Color backgroundColor = Colors.transparent}) {
    return Container(
      padding: EdgeInsets.all(8),
      color: backgroundColor,
      child: Center(
        child: label == 'T'
            ? Icon(Icons.arrow_drop_down, color: Colors.black)
            : Text(
          label,
          style: TextStyle(
            fontFamily: 'Lato-Right',
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget _buildDataCell(String value, {Color backgroundColor = Colors.transparent}) {
    return Container(
      padding: EdgeInsets.all(8),
      color: backgroundColor,
      child: Text(
        value,
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontFamily: "Lato-Light",
        ),
      ),
    );
  }

  Widget _buildActionCell(int index, {Color backgroundColor = Colors.transparent}) {
    return Container(
      padding: EdgeInsets.all(8),
      color: backgroundColor,
      child: IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: () {
          setState(() {
            measurementData.removeAt(index);
          });
        },
      ),
    );
  }
}
