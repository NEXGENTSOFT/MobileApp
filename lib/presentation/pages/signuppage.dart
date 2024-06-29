import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as picker;
import 'package:intl/intl.dart';
import 'package:TopoSmart/presentation/pages/principalpage.dart';
import 'package:TopoSmart/presentation/pages/loginpage.dart';

class MySignUpPage extends StatefulWidget {
  const MySignUpPage({super.key, required this.title});

  final String title;

  @override
  State<MySignUpPage> createState() => _MySignUpPageState();
}

class _MySignUpPageState extends State<MySignUpPage> {
  Color colorpage = Color(0xFF4A4E69);
  Color buttonIN = Color(0xFFD2A351);
  Color letraA = Color(0xFF22223B);
  Color uno = Color(0xFFF2E9E4);
  Color label = Color(0xFFB78471);

  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;
  TextEditingController _dateController = TextEditingController();

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
        _dateController.text = DateFormat('yyyy-MM-dd').format(date);
      },
      currentTime: DateTime.now(),
      locale: picker.LocaleType.en, // Assuming you want English locale
    );
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                height: screenHeight * 0.24,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/img/EllipseSign.png',
                      width: 170,
                      height: 170,
                    ),
                    Image.asset(
                      'assets/img/signup.png',
                      width: 108,
                      height: 145,
                    ),
                  ],
                ),
              ),
              Text(
                'Registro',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Nombre',
                  style: TextStyle(
                    fontFamily: 'Lato-Right',
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nombre',
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
                style: TextStyle(color: letraA, fontSize: 13, fontFamily: "Lato-Light"),
              ),
              SizedBox(height: screenHeight * 0.03),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Apellido',
                  style: TextStyle(
                    fontFamily: 'Lato-Right',
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Apellido',
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
                style: TextStyle(color: letraA, fontSize: 13, fontFamily: "Lato-Light"),
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
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nombre de usuario',
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
                style: TextStyle(color: letraA, fontSize: 13, fontFamily: "Lato-Light"),
              ),
              SizedBox(height: screenHeight * 0.03),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Correo Electrónico',
                  style: TextStyle(
                    fontFamily: 'Lato-Right',
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Correo Electrónico',
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
                style: TextStyle(color: letraA, fontSize: 13, fontFamily: "Lato-Light"),
              ),
              SizedBox(height: screenHeight * 0.03),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Contraseña',
                  style: TextStyle(
                    fontFamily: 'Lato-Thin',
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              TextField(
                obscureText: _obscureTextPassword,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureTextPassword ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined,
                      color: letraA,
                    ),
                    onPressed: _toggleObscureTextPassword,
                  ),
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
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelStyle: TextStyle(
                    color: letraA,
                    fontFamily: 'Lato-Right',
                    fontSize: 13,
                  ),
                ),
                style: TextStyle(color: letraA, fontSize: 13, fontFamily: "Lato-Right"),
              ),
              SizedBox(height: screenHeight * 0.03),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Confirmar contraseña',
                  style: TextStyle(
                    fontFamily: 'Lato-Thin',
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              TextField(
                obscureText: _obscureTextConfirmPassword,
                decoration: InputDecoration(
                  labelText: 'Confirmar contraseña',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureTextConfirmPassword ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined,
                      color: letraA,
                    ),
                    onPressed: _toggleObscureTextConfirmPassword,
                  ),
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
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelStyle: TextStyle(
                    color: letraA,
                    fontFamily: 'Lato-Right',
                    fontSize: 13,
                  ),
                ),
                style: TextStyle(color: letraA, fontSize: 13, fontFamily: "Lato-Right"),
              ),
              SizedBox(height: screenHeight * 0.03),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Fecha de nacimiento',
                  style: TextStyle(
                    fontFamily: 'Lato-Right',
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Fecha de nacimiento',
                  style: TextStyle(
                    fontFamily: 'Lato-Right',
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              TextField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Fecha de nacimiento',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_month_outlined, color: letraA),
                    onPressed: () => _selectDate(context),
                  ),
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
                style: TextStyle(color: letraA, fontSize: 13, fontFamily: "Lato-Light"),
              ),
              SizedBox(height: screenHeight * 0.1),
              Container(
                height: screenHeight * 0.1,
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyPrincipalPage(title: '')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonIN,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        'Registrarse',
                        style: TextStyle(color: Colors.white, fontFamily: "Lato-Regular", fontSize: 15),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyLoginPage(title: '')),
                        );
                      },
                      child: Text(
                        '¿Ya tienes cuenta? Iniciar sesión',
                        style: TextStyle(color: letraA, fontFamily: "Lato-Italic", fontSize: 13),
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
