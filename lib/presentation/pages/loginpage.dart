import 'package:flutter/material.dart';
import 'package:TopoSmart/presentation/pages/signuppage.dart';

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

  bool _obscureText = true;

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });}


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeigh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: uno,
        title: Text(widget.title),
      ),
      body:  SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
         // mainAxisAlignment: MainAxisAlignment.center,
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
                  fontSize: 13
                ),
              ),
              style: TextStyle(color: letraA, fontSize: 13, fontFamily: "Lato-Light"),
            ),
            SizedBox(height: screenHeigh * 0.03),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Contraseña',
                style: TextStyle(
                   fontFamily: 'Lato-Thin',
                  fontSize: 18,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: screenHeigh * 0.01),
            TextField(
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
                  fontFamily: 'Lato-Right', fontSize: 13,
                ),
              ),
              style: TextStyle(color: letraA, fontSize: 13, fontFamily: "Lato-Right"),
            ),
            SizedBox(height: screenHeigh * 0.1),
            Container(
              height: screenHeigh * 0.1,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyLoginPage(title: '')),
                      );
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
                      '¿No tienes cuenta? Registrate',
                      style: TextStyle(color: letraA, fontFamily: "Lato-Italic", fontSize: 13),
                    ),
                  ),
                ],
              ),
            )
    ],
        ),
      ),
    );
  }
}
