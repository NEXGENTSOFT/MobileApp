import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as picker;
import 'package:intl/intl.dart';
import 'package:TopoSmart/presentation/pages/editperfilpage.dart';
import 'package:TopoSmart/presentation/pages/principalpage.dart';
import 'package:TopoSmart/presentation/pages/editpasswordpage.dart';

class MyPerfilPage extends StatefulWidget {
  const MyPerfilPage({super.key, required this.title});

  final String title;

  @override
  State<MyPerfilPage> createState() => _MyPerfilPageState();
}

class _MyPerfilPageState extends State<MyPerfilPage> {
  Color colorpage = Color(0xFF4A4E69);
  Color buttonIN = Color(0xFFD2A351);
  Color letraA = Color(0xFF22223B);
  Color uno = Color(0xFFF2E9E4);
  Color label = Color(0xFF9A8C98);
  Color buttonR = Color(0xFFFFA099);

  TextEditingController _dateController = TextEditingController();

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
                      'Perfil',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.5,),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/img/EllipseP.png',
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
            Container(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
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
                   child: Column(
                     children: [
                       SizedBox(height: screenHeight *0.05, ),
                       Container(
                         child:
                         ElevatedButton(
                           onPressed: () {
                             Navigator.push(
                               context,
                               MaterialPageRoute(builder: (context) => MyEditPerfilPage(title: '')),
                             );
                           },
                           style: ElevatedButton.styleFrom(
                             backgroundColor: buttonIN,
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(16),
                             ),
                             minimumSize: Size(375, 45),
                           ),
                           child: Text(
                             'Editar datos',
                             style: TextStyle(color: Colors.white, fontFamily: "Lato-Regular", fontSize: 15),
                           ),
                         ),

                       ),
                       SizedBox(height: screenHeight *0.04, ),
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
                       SizedBox(height: screenHeight *0.01, ),
                       Container(
                         child:
                         ElevatedButton(
                           onPressed: () {
                             Navigator.push(
                               context,
                               MaterialPageRoute(builder: (context) => MyEditPasswordPage(title: '')),
                             );
                           },
                           style: ElevatedButton.styleFrom(
                             backgroundColor: colorpage,
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(16),
                             ),
                             minimumSize: Size(375, 45),
                           ),
                           child: Text(
                             'Editar contraseña',
                             style: TextStyle(color: Colors.white, fontFamily: "Lato-Regular", fontSize: 15),
                           ),
                         ),

                       ),
                       SizedBox(height: screenHeight *0.05, ),
                       Container(
                         child:
                         ElevatedButton(
                           onPressed: () {
                             Navigator.push(
                               context,
                               MaterialPageRoute(builder: (context) => MyPrincipalPage(title: '')),
                             );
                           },
                           style: ElevatedButton.styleFrom(
                             backgroundColor: Colors.red,
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(16),
                             ),
                             minimumSize: Size(375, 45),
                           ),
                           child: Text(
                             'Eliminar cuenta',
                             style: TextStyle(color: letraA, fontFamily: "Lato-Regular", fontSize: 15),
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
