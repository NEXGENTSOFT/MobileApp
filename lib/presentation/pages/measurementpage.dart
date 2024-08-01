import 'package:TopoSmart/presentation/pages/newmeasurement.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Para manejar JSON

class MyMeasurementPage extends StatefulWidget {
  const MyMeasurementPage({Key? key, required this.title, required this.id});

  final String title;
  final String id;

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
    ]);
    super.dispose();
  }

  Future<void> _fetchMeasurementData() async {
    try {
      final response = await http.get(
        Uri.parse('https://servidor-toposmart.zapto.org/projectsmanagement/measurements/list/${widget.id}'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> measurements = data['data'];
        setState(() {
          measurementData = measurements.map((item) {
            return {
              'uuid': item['uuid'], // Añadir el UUID de la medición
              'station': item['station'] ?? '',
              'plus': item['plus']?.toString() ?? '',
              'fixedLevel': item['fixedLevel']?.toString() ?? '',
              'minus': item['minus']?.toString() ?? '',
              'notes': item['note'] ?? '',
              'height': item['height']?.toString() ?? '',
            };
          }).toList();
        });
      } else {
        throw Exception('Error al cargar los datos');
      }
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

  Future<void> _navigateToNewMeasurementPage(BuildContext context) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyNewMeaPage(title: 'Nueva medición', projectId: widget.id,),
      ),
    );

    if (result != null) {
      _updateMeasurementData(result);
    }
  }

  Future<void> _deleteMeasurement(String measurementUuid, int index) async {
    try {
      var response = await http.delete(
        Uri.parse('https://servidor-toposmart.zapto.org/projectsmanagement/measurements/$measurementUuid'),
      );

      if (response.statusCode == 200) {
        setState(() {
          measurementData.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Medición eliminada')),
        );
      } else {
        print('Error al eliminar la medición: ${response.reasonPhrase}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al eliminar la medición')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al eliminar la medición')),
      );
    }
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
                  _buildHeaderCell('T', backgroundColor: enca), // Nueva columna 'Height'
                  _buildHeaderCell(''),
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
                    _buildDataCell(data['height']?.toString() ?? '', backgroundColor: com), // Nueva columna 'Height'
                    _buildActionCell(data['uuid'], index), // Pasar el UUID y el índice
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
              onPressed: () => _navigateToNewMeasurementPage(context),
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

  Widget _buildActionCell(String measurementUuid, int index) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.transparent,
      child: IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Confirmar eliminación'),
                  content: Text('¿Estás seguro de que deseas eliminar esta medición?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _deleteMeasurement(measurementUuid, index);
                      },
                      child: Text('Eliminar'),
                    ),
                  ],
                );
              }
          );
        },
      ),
    );
  }
}
