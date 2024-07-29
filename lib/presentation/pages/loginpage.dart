import 'package:TopoSmart/presentation/pages/principalpage.dart';
import 'package:flutter/material.dart';
import 'package:TopoSmart/presentation/pages/signuppage.dart';
import 'package:TopoSmart/presentation/pages/homepage.dart';
import 'package:TopoSmart/presentation/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';  // Para manejar JSON
import 'package:shared_preferences/shared_preferences.dart';

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
  final TextEditingController _emailController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool _obscureText = true;

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su correo electrónico';
    }
    final emailExp = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailExp.hasMatch(value)) {
      return 'Por favor ingrese un correo electrónico válido';
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

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus(); // Eliminar caché del teclado

      final email = _emailController.text;
      final password = _passwordController.text;

      final response = await http.post(
        Uri.parse('https://servidor-toposmart.zapto.org/usersmanagement/users/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Guardar el token y los datos del usuario en SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['data']['token']);
        await prefs.setString('user', jsonEncode(data['data']['user']));

        // Navegar a la página principal
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage(title: '')),
        );
      } else {
        // Si la respuesta no es 200 OK, muestra un mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error en el inicio de sesión')),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
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
                  'Correo electronico',
                  style: TextStyle(
                    fontFamily: 'Lato-Right',
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: screenHeigh * 0.01),
              TextFormField(
                controller: _emailController,
                focusNode: _emailFocusNode,
                decoration: InputDecoration(
                  labelText: 'Correo electronico',
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
                validator: _validateEmail,
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
                focusNode: _passwordFocusNode,
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
                      onPressed: _submitForm,
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
                        FocusScope.of(context).unfocus(); // Eliminar caché del teclado
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
