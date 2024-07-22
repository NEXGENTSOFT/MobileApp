import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as picker;
import 'package:intl/intl.dart';
import 'package:TopoSmart/presentation/pages/principalpage.dart';
import 'package:TopoSmart/presentation/pages/loginpage.dart';
import 'package:url_launcher/url_launcher.dart';


class MySignUpPage extends StatefulWidget {
  const MySignUpPage({super.key, required this.title});

  final String title;

  @override
  State<MySignUpPage> createState() => _MySignUpPageState();
}

class _MySignUpPageState extends State<MySignUpPage> {
  Color colorpage = const Color(0xFF4A4E69);
  Color buttonIN = const Color(0xFFD2A351);
  Color letraA = const Color(0xFF22223B);
  Color uno = const Color(0xFFF2E9E4);
  Color label = const Color(0xFFB78471);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;
  bool _isTermsAccepted = false;

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
      locale: picker.LocaleType.en,
    );
  }


  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'No se pudo lanzar $url';
    }
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

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su nombre de usuario';
    }
    final usernameExp = RegExp(r'^[a-zA-Z0-9]+$');
    if (!usernameExp.hasMatch(value)) {
      return 'El nombre de usuario solo debe contener letras y números';
    }
    return null;
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

  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su fecha de nacimiento';
    }
    final selectedDate = DateFormat('yyyy-MM-dd').parse(value);
    final currentDate = DateTime.now();
    final age = currentDate.year - selectedDate.year;
    if (age < 18) {
      return 'Debe tener al menos 18 años';
    }
    return null;
  }

  String? _validateTerms(bool value) {
    if (!value) {
      return 'Debe aceptar los términos y condiciones';
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
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
                TextFormField(
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
                  validator: _validateName,
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
                  validator: _validateUsername,
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
                TextFormField(
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
                  validator: _validateEmail,
                ),
                SizedBox(height: screenHeight * 0.03),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Contraseña',
                    style: TextStyle(
                      fontFamily: 'Lato-Right',
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                TextFormField(
                  controller: _passwordController,
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
                    ),
                    labelStyle: TextStyle(
                      color: letraA,
                      fontFamily: 'Lato-Light',
                      fontSize: 13,
                    ),
                  ),
                  style: TextStyle(color: letraA, fontSize: 13, fontFamily: "Lato-Light"),
                  validator: _validatePassword,
                ),
                SizedBox(height: screenHeight * 0.03),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Confirmar Contraseña',
                    style: TextStyle(
                      fontFamily: 'Lato-Thin',
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                TextFormField(
                  obscureText: _obscureTextConfirmPassword,
                  decoration: InputDecoration(
                    labelText: 'Confirmar Contraseña',
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
                    ),
                    labelStyle: TextStyle(
                      color: letraA,
                      fontFamily: 'Lato-Light',
                      fontSize: 13,
                    ),
                  ),
                  style: TextStyle(color: letraA, fontSize: 13, fontFamily: "Lato-Light"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, confirme su contraseña';
                    } else if (value != _passwordController.text) {
                      return 'Las contraseñas no coinciden';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.03),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Fecha de Nacimiento',
                    style: TextStyle(
                      fontFamily: 'Lato-Thin',
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                TextFormField(
                  controller: _dateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Fecha de Nacimiento',
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
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today, color: letraA),
                      onPressed: () => _selectDate(context),
                    ),
                  ),
                  style: TextStyle(color: letraA, fontSize: 13, fontFamily: "Lato-Light"),
                  validator: _validateDate,
                ),
                SizedBox(height: screenHeight * 0.03),
                CheckboxListTile(
                  title: Text("Aceptar términos y condiciones"),
                  value: _isTermsAccepted,
                  onChanged: (newValue) {
                    setState(() {
                      _isTermsAccepted = newValue!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Colors.blue,
                  checkColor: Colors.white,
                  subtitle: !_isTermsAccepted
                      ? Text(
                    'Debe aceptar los términos y condiciones',
                    style: TextStyle(color: Colors.red),
                  )
                      : null,
                ),
                TextButton(
                  onPressed: () {
                        _launchURL('https://nexgensoft.ddnsking.com');
                  },
                  child: Text(
                    'Políticas de Privacidad ',
                    style: TextStyle(
                      color: letraA,
                      fontFamily: 'Lato-Light',
                      fontSize: 13,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonIN,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Aquí puedes manejar el registro exitoso, por ejemplo, enviando los datos al servidor
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyPrincipalPage(title: '', message: '',)),
                      );
                    }
                  },
                  child: Text(
                    'Registrarse',
                    style: TextStyle(
                      color: uno,
                      fontFamily: 'Lato',
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyLoginPage(title: '')),
                    );
                  },
                  child: Text(
                    '¿Ya tienes una cuenta? Inicia sesión',
                    style: TextStyle(
                      color: letraA,
                      fontFamily: 'Lato-Light',
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
