import 'package:flutter/material.dart';

class MyReportPage extends StatefulWidget {
  const MyReportPage({super.key, required this.title});

  final String title;

  @override
  State<MyReportPage> createState() => _MyReportPageState();
}

class _MyReportPageState extends State<MyReportPage> {
  Color colorpage = Color(0xFF4A4E69);
  Color buttonIN = Color(0xFFD2A351);
  Color letraA = Color(0xFF22223B);
  Color uno = Color(0xFFF2E9E4);
  Color label = Color(0xFFB78471);
  Color buttonR = Color(0xFFFFA099);


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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: screenHeight * 0.16,  // Ajusta según sea necesario
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,  // Alinea al inicio
                children: [
                  Container(
                    height: 100,  // Ajusta la altura para que coincida con la imagen
                    child: Text(
                      'Tipo de reporte',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.2,),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/img/EllipseR.png',
                        width: 100,
                        height: 100,
                      ),
                      Image.asset(
                        'assets/img/props-financial-reports.png',
                        width: 80,
                        height: 80,
                      ),
                    ],
                  ),

                ],
              ),

            ),
            // Resto de tu código...
            Container(
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        child: Text(
                          'Reporte 1',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02,),
                      Container(
                        child:
                        Text(
                          'Reporte que incluye \n imagenes ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 13,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: screenWidth * 0.22,),
                  ElevatedButton(
                    onPressed: () {
                     /* Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage(title: '')),
                      );*/
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonR,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Generar reporte',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 15),
                    ),
                  ),
                 ],
              ),
            ),
            SizedBox(height: screenHeight * 0.07,),
            Container(
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        child: Text(
                          'Reporte 2',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02,),
                      Container(
                        child:
                        Text(
                          'Reporte que incluye \n dibujos \n y mediciones ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 13,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: screenWidth * 0.22,),
                  ElevatedButton(
                    onPressed: () {
                      /* Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage(title: '')),
                      );*/
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonR,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Generar reporte',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.07,),
            Container(
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        child: Text(
                          'Reporte 3',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02,),
                      Container(
                        child:
                        Text(
                          'Reporte que incluye \n imagenes y \n mediciones ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 13,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: screenWidth * 0.22,),
                  ElevatedButton(
                    onPressed: () {
                      /* Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage(title: '')),
                      );*/
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonR,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Generar reporte',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.07,),
            Container(
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        child: Text(
                          'Reporte 4',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02,),
                      Container(
                        child:
                        Text(
                          'Reporte que incluye \n todo ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 13,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: screenWidth * 0.22,),
                  ElevatedButton(
                    onPressed: () {
                      /* Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage(title: '')),
                      );*/
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonR,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Generar reporte',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
