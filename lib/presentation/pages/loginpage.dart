import 'package:flutter/material.dart';
import 'package:TopoSmart/presentation/pages/signuppage.dart';
import 'package:TopoSmart/presentation/pages/homepage.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key, required this.title});

  final String title;

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  Color colorpage = Color(0xFF4A4E69);
  Color buttonIN = Color(0xFFD2A351);
  Color letraA = Color(0xFF22223B);
  Color uno = Color(0xFFF2E9E4);
  Color label = Color(0xFFB78471);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
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

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su contraseña';
    }
    if (value.length < 8 || value.length > 12) {
      return 'La contraseña debe tener entre 8 y 12 caracteres';
    }
    final passwordExp = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).+$');
    if (!passwordExp.hasMatch(value)) {
      return 'La contraseña debe contener al menos una letra y un número';
    }
    return null;
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                height: screenHeigh * 0.26,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/img/Ellipse.png',
                      width: 180,
                      height: 180,
                    ),
                    Image.asset(
                      'assets/img/login.png',
                      width: 132,
                      height: 207,
                    ),
                  ],
                ),
              ),
              Text(
                'Inicio de sesión',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeigh * 0.05),
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
              SizedBox(height: screenHeigh * 0.01),
              TextFormField(
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
                validator: _validateName,
              ),
              SizedBox(height: screenHeigh * 0.03),
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
              SizedBox(height: screenHeigh * 0.01),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined,
                      color: letraA,
                    ),
                    onPressed: _toggleObscureText,
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
                validator: _validatePassword,
              ),
              SizedBox(height: screenHeigh * 0.1),
              Container(
                height: screenHeigh * 0.1,
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyHomePage(title: '')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonIN,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        'Iniciar sesión',
                        style: TextStyle(color: Colors.white, fontFamily: "Lato-Regular", fontSize: 15),
                      ),
                    ),
                    SizedBox(height: screenHeigh * 0.01),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MySignUpPage(title: '')),
                        );
                      },
                      child: Text(
                        '¿No tienes cuenta? Regístrate',
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
