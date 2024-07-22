import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as picker;
import 'package:intl/intl.dart';
import 'package:TopoSmart/presentation/pages/perfilpage.dart';

class MyEditPerfilPage extends StatefulWidget {
  const MyEditPerfilPage({super.key, required this.title});

  final String title;

  @override
  State<MyEditPerfilPage> createState() => _MyEditPerfilPageState();
}

class _MyEditPerfilPageState extends State<MyEditPerfilPage> {
  Color colorpage = Color(0xFF4A4E69);
  Color buttonIN = Color(0xFFD2A351);
  Color letraA = Color(0xFF22223B);
  Color uno = Color(0xFFF2E9E4);
  Color label = Color(0xFFB78471);
  Color buttonR = Color(0xFFFFA099);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  void _selectDate(BuildContext context) {
    picker.DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(1900, 1, 1),
      maxTime: DateTime.now(),
      onChanged: (date) {
        print('change $date');
      },
      onConfirm: (date) {
        setState(() {
          _selectedDate = date;
          _dateController.text = DateFormat('yyyy-MM-dd').format(date);
        });
      },
      currentTime: DateTime.now(),
      locale: picker.LocaleType.en, // Assuming you want English locale
    );
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su nombre';
    }
    final nameExp = RegExp(r'^[a-zA-Z]+$');
    if (!nameExp.hasMatch(value)) {
      return 'El nombre solo debe contener letras';
    }
    return null;
  }

  String? _validateSurname(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su apellido';
    }
    final nameExp = RegExp(r'^[a-zA-Z]+$');
    if (!nameExp.hasMatch(value)) {
      return 'El apellido solo debe contener letras';
    }
    return null;
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su nombre de usuario';
    }
    final usernameExp = RegExp(r'^[a-zA-Z0-9]+$');
    if (!usernameExp.hasMatch(value)) {
      return 'El nombre de usuario debe contener solo letras y números';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su correo electrónico';
    }
    final emailExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailExp.hasMatch(value)) {
      return 'Ingrese un correo electrónico válido';
    }
    return null;
  }

  String? _validateDateOfBirth(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor seleccione su fecha de nacimiento';
    }
    if (_selectedDate != null) {
      final today = DateTime.now();
      final eighteenYearsAgo = today.subtract(Duration(days: 365 * 18));
      if (_selectedDate!.isAfter(eighteenYearsAgo)) {
        return 'Debe tener al menos 18 años';
      }
    }
    return null;
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: screenHeight * 0.13,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      child: Text(
                        'Editar Perfil',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.3),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'assets/img/EllipseE.png',
                          width: 100,
                          height: 100,
                        ),
                        Image.asset(
                          'assets/img/3d-business-young-woman-looking-at-plan.png',
                          width: 80,
                          height: 80,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Nombre de usuario',
                  style: TextStyle(
                    fontFamily: 'Lato-Right',
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nombre de usuario',
                  filled: true,
                  fillColor: label,
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
                    color: uno,
                    fontFamily: 'Lato-Light',
                    fontSize: 13,
                  ),
                ),
                style: TextStyle(color: letraA, fontSize: 13, fontFamily: "Lato-Light"),
                validator: _validateUsername,
              ),
              Container(
                child: Row(
                  children: [
                    SizedBox(height: screenHeight * 0.2),
                    Container(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyPerfilPage(title: '')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonR,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          minimumSize: Size(160, 45),
                        ),
                        child: Text(
                          'Cancelar',
                          style: TextStyle(color: letraA, fontFamily: "Lato-Regular", fontSize: 15),
                        ),
                      ),
                    ),
                    SizedBox(width: screenHeight * 0.06),
                    Container(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyPerfilPage(title: '')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonIN,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          minimumSize: Size(160, 45),
                        ),
                        child: Text(
                          'Guardar datos',
                          style: TextStyle(color: uno, fontFamily: "Lato-Regular", fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
