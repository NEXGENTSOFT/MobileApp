import 'package:flutter/animation.dart';
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

  TextEditingController _dateController = TextEditingController();


  @override
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
        padding: const EdgeInsets.all(16.0),
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
                  SizedBox(width: screenWidth * 0.3,),
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
            // Resto de tu código...
            Container(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,  // Alinea al inicio
               children: [
                 SizedBox(height: screenHeight * 0.001),
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
                 ),
                 Container(
                   child: Row(
                     children: [
                       SizedBox(height: screenHeight *0.2, ),
                       Container(
                         child:
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

                       ),
                       SizedBox(width: screenHeight * 0.06, ),
                       Container(
                         child:
                         ElevatedButton(
                           onPressed: () {
                             Navigator.push(
                               context,
                               MaterialPageRoute(builder: (context) => MyPerfilPage(title: '')),
                             );
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

                       )

                     ],
                   ),
                 )

               ],
             ),
            ),
          ],
        ),
      ),
    );
  }
}
