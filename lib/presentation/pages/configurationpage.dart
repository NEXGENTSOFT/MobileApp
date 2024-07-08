import 'package:flutter/material.dart';
import 'package:TopoSmart/presentation/pages/perfilpage.dart';
import 'package:TopoSmart/presentation/pages/principalpage.dart';
import 'package:TopoSmart/presentation/pages/policiespages.dart';
import 'package:url_launcher/url_launcher.dart';


class MyConfigurationPage extends StatefulWidget {
  const MyConfigurationPage({super.key, required this.title});

  final String title;

  @override
  State<MyConfigurationPage> createState() => _MyConfigurationPageState();
}

class _MyConfigurationPageState extends State<MyConfigurationPage> {
  Color uno = Color(0xFFF2E9E4);
  Color letraA = Color(0xFF22223B);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: uno,
        title: Text('', style: TextStyle(
          fontFamily: 'Lato-Light',
          fontSize: 21,
        ),),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Perfil', style: TextStyle(
              fontFamily: 'Lato-Light',
              fontSize: 18, color: letraA
            ),),

            leading: Icon(Icons.person, color: letraA,),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyPerfilPage(title: ''),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text('Suscripción', style: TextStyle(
                fontFamily: 'Lato-Light',
                fontSize: 18, color: letraA
            ),),
            leading: Icon(Icons.attach_money, color: letraA,),
            onTap: () {
              // Acción al presionar el ítem de notificaciones
            },
          ),
          Divider(),
          ListTile(
            title: Text(
              'Acerca de nosotros',
              style: TextStyle(
                fontFamily: 'Lato-Light',
                fontSize: 18,
                color: letraA,
              ),
            ),
            leading: Icon(Icons.help, color: letraA),
            onTap: () {
              _launchURL('https://nexgensoft.ddnsking.com');
            },
          ),
         Divider(),
          ListTile(
            title: Text('Política de Privacidad', style: TextStyle(
              fontFamily: 'Lato-Light',
              fontSize: 18, color: letraA
            ),),
            leading: Icon(Icons.description, color: letraA,),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyPoliciesPage(title: ''),
                ),
              );             },
          ),
          Divider(),
          ListTile(
            title: Text('Cerrar sesión', style: TextStyle(
              fontFamily: 'Lato-Light',
              fontSize: 18, color: letraA
            ),),
            leading: Icon(Icons.exit_to_app, color: letraA,),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyPrincipalPage(title: ''),
                ),
              );            },
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'No se pudo lanzar $url';
    }
  }
}
