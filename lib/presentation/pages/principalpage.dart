import 'package:flutter/material.dart';
import 'package:TopoSmart/presentation/pages/loginpage.dart';
/*import 'package:TopoSmart/pages/signuppage.dart';*/


class MyPrincipalPage extends StatefulWidget {
  const MyPrincipalPage({super.key, required this.title});

  final String title;

  @override
  State<MyPrincipalPage> createState() => _MyPrincipalPageState();
}

class _MyPrincipalPageState extends State<MyPrincipalPage> {
  Color colorpage = Color(0xFF4A4E69);
  Color buttonI = Color(0xFFC9ADA7);
  Color letraA = Color(0xFF22223B);


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeigh = MediaQuery.of(context).size.height;

    return Scaffold(

      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: screenHeigh * 0.77,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/img/fondo.png',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Center(
                      child: Image.asset(
                        'assets/img/principal.png',
                        height: 225,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: screenHeigh * 0.2,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                       Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyLoginPage(title: '')), // Navega a la vista LoginPage
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonI,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        'Iniciar sesión',
                        style: TextStyle(color: letraA, fontFamily: 'Lato-Regular', fontSize: 15),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                       /* Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyLoginPage(title: 'Inicio de sesión')), // Navega a la vista LoginPage
                      );*/
                        },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorpage,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        'Registrarse',
                        style: TextStyle(color: Colors.white, fontFamily: 'Lato-Regular', fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),

        ],
      ),
    );
  }
}





