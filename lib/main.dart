import 'package:flutter/material.dart';
import 'package:TopoSmart/presentation/pages/principalpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      //debugShowCheckedModeBanner: false,
      initialRoute: '/', // Especifica la ruta inicial de la aplicación
      routes: {
        '/': (context) => MyPrincipalPage(title: 'title'),
        /*'/home': (context) => MyHomePage(title: 'title'),
        '/pending': (context) => MyPendingPage(title: 'title'),
        '/library': (context) => MyLibraryPage(title: 'title'),
        '/profile': (context) => MyProfilePage(title: 'title'),
        '/books': (context) => MyNewBook(title: 'title'),*/
      },
    );
  }
}
