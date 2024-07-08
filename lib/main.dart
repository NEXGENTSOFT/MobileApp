import 'package:flutter/material.dart';
import 'package:TopoSmart/presentation/pages/principalpage.dart';
import 'package:TopoSmart/presentation/pages/homepage.dart';
import 'package:TopoSmart/presentation/pages/newprojectpage.dart';
import 'package:TopoSmart/domain/models/savedrawingmodel.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => SavedDrawingsModel(), // Aquí creas una instancia de SavedDrawingsModel
    child: MaterialApp(
    title: 'TopoSmart App',
    theme: ThemeData(
    primarySwatch: Colors.blue,
    ),
      //debugShowCheckedModeBanner: false,
      initialRoute: '/', // Especifica la ruta inicial de la aplicación
      routes: {
        '/': (context) => MyPrincipalPage(title: ''),
        '/home': (context) => MyHomePage(title: ''),
        '/newp': (context) => MyNewProjectPage(title: ''),
      /* '/library': (context) => Dr(),
       '/profile': (context) => MyProfilePage(title: 'title'),
        '/books': (context) => MyNewBook(title: 'title'),*/
      },
    ),
    );
  }
}
