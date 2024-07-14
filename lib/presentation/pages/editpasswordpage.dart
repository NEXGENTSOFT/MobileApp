import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as picker;
import 'package:intl/intl.dart';
import 'package:TopoSmart/presentation/pages/perfilpage.dart';

class MyEditPasswordPage extends StatefulWidget {
  const MyEditPasswordPage({super.key, required this.title});

  final String title;

  @override
  State<MyEditPasswordPage> createState() => _MyEditPasswordPageState();
}

class _MyEditPasswordPageState extends State<MyEditPasswordPage> {
  Color colorpage = Color(0xFF4A4E69);
  Color buttonIN = Color(0xFFD2A351);
  Color letraA = Color(0xFF22223B);
  Color uno = Color(0xFFF2E9E4);
  Color label = Color(0xFFB78471);
  Color buttonR = Color(0xFFFFA099);

  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;
  bool _obscureTextOldPassword = true;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _toggleObscureTextPassword() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  void _toggleObscureTextConfirmPassword() {
    setState(() {
      _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
    });
  }

  void _toggleObscureTextOldPassword() {
    setState(() {
      _obscureTextOldPassword = !_obscureTextOldPassword;
    });
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese una contraseña';
    }
    if (value.length < 8 || value.length > 12) {
      return 'La contraseña debe tener entre 8 y 12 caracteres';
    }
    final hasLetters = RegExp(r'[a-zA-Z]').hasMatch(value);
    final hasDigits = RegExp(r'\d').hasMatch(value);
    if (!hasLetters || !hasDigits) {
      return 'La contraseña debe contener letras y números';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor confirme la nueva contraseña';
    }
    if (value != _newPasswordController.text) {
      return 'Las contraseñas no coinciden';
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
                        'Editar Contraseña',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.15),
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
                  'Contraseña anterior',
                  style: TextStyle(
                    fontFamily: 'Lato-Thin',
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              TextFormField(
                controller: _oldPasswordController,
                obscureText: _obscureTextOldPassword,
                decoration: InputDecoration(
                  labelText: 'Contraseña anterior',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureTextOldPassword ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined,
                      color: letraA,
                    ),
                    onPressed: _toggleObscureTextOldPassword,
                  ),
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
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelStyle: TextStyle(
                    color: letraA,
                    fontFamily: 'Lato-Right',
                    fontSize: 13,
                  ),
                ),
                style: TextStyle(color: letraA, fontSize: 13, fontFamily: "Lato-Right"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la contraseña anterior';
                  }
                  return null;
                },
              ),
              SizedBox(height: screenHeight * 0.03),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Contraseña nueva',
                  style: TextStyle(
                    fontFamily: 'Lato-Thin',
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              TextFormField(
                controller: _newPasswordController,
                obscureText: _obscureTextPassword,
                decoration: InputDecoration(
                  labelText: 'Contraseña nueva',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureTextPassword ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined,
                      color: letraA,
                    ),
                    onPressed: _toggleObscureTextPassword,
                  ),
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
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelStyle: TextStyle(
                    color: letraA,
                    fontFamily: 'Lato-Right',
                    fontSize: 13,
                  ),
                ),
                style: TextStyle(color: letraA, fontSize: 13, fontFamily: "Lato-Right"),
                validator: _validatePassword,
              ),
              SizedBox(height: screenHeight * 0.03),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Confirmar contraseña nueva',
                  style: TextStyle(
                    fontFamily: 'Lato-Thin',
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureTextConfirmPassword,
                decoration: InputDecoration(
                  labelText: 'Confirmar contraseña nueva',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureTextConfirmPassword ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined,
                      color: letraA,
                    ),
                    onPressed: _toggleObscureTextConfirmPassword,
                  ),
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
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelStyle: TextStyle(
                    color: letraA,
                    fontFamily: 'Lato-Right',
                    fontSize: 13,
                  ),
                ),
                style: TextStyle(color: letraA, fontSize: 13, fontFamily: "Lato-Right"),
                validator: _validateConfirmPassword,
              ),
              SizedBox(height: screenHeight * 0.2),
              Row(
                children: [
                  ElevatedButton(
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
                  SizedBox(width: screenWidth * 0.06),
                  ElevatedButton(
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
