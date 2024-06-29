import 'package:flutter/material.dart';
import 'package:TopoSmart/presentation/pages/signuppage.dart';
import 'package:TopoSmart/presentation/pages/homepage.dart';
import 'package:TopoSmart/presentation/pages/editprojectpage.dart';
import 'package:TopoSmart/presentation/pages/newprojectpage.dart';
import 'package:TopoSmart/presentation/pages/projectpage.dart';
import 'package:TopoSmart/presentation/pages/perfilpage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color colorpage = Color(0xFF4A4E69);
  Color buttonIN = Color(0xFFD2A351);
  Color letraA = Color(0xFF22223B);
  Color uno = Color(0xFFF2E9E4);
  Color label = Color(0xFFB78471);

  int _pagehome = 0;
  List<Map<String, String>> projects = [];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeigh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: uno,
        title: Text(widget.title),
      ),
      body: IndexedStack(
        index: _pagehome,
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Stack(
                    children: [
                      Text(
                        'Proyectos',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeigh * 0.05),
                Text('Clima'),
                SizedBox(height: screenHeigh * 0.01),
                projects.isEmpty
                    ? Text(
                  'No hay proyectos guardados',
                  style: TextStyle(
                    fontFamily: 'Lato-Light',
                    fontSize: 18,
                    color: letraA,
                  ),
                )
                    : ListView.builder(
                  shrinkWrap: true,
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/img/Ellipse11.png',
                            width: 50,
                            height: 50,
                          ),
                          Image.asset(
                            'assets/img/casco.png',
                            width: 30,
                            height: 30,
                          ),
                        ],
                      ),
                      title: Text(
                        projects[index]['name']!,
                        style: TextStyle(
                          fontFamily: 'Lato-Bold',
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        projects[index]['description']!,
                        style: TextStyle(
                          fontFamily: 'Lato-Light',
                          fontSize: 15,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: buttonIN),
                            onPressed: () async {
                              var result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyEditProjectPage(
                                    title: 'Editar Proyecto',
                                  ),
                                ),
                              );
                              if (result != null) {
                                setState(() {
                                  projects[index] = result;
                                });
                              }
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                projects.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        _navigateToProjectDetailPage(context, projects[index]);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          Center(child: Text('Perfil')), // Añade aquí el contenido de la pestaña de perfil
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          if (index == 0) {
            _navigateToNewProjectPage(context);
          } else {
            setState(() {
              _navigateToPerfilPage(context);
            });
          }
        },
        currentIndex: _pagehome,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline, color: Colors.white),
            label: "Nueva tarea",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.white),
            label: "Perfil",
          ),
        ],
        backgroundColor: colorpage,
      ),
    );
  }

  Future<void> _navigateToNewProjectPage(BuildContext context) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyNewProjectPage(title: 'Nuevo Proyecto'),
      ),
    );
    if (result != null) {
      setState(() {
        projects.add(result);
      });
    }
  }

  Future<void> _navigateToPerfilPage(BuildContext context) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyPerfilPage(title: ''),
      ),
    );
    if (result != null) {
      setState(() {
        projects.add(result);
      });
    }
  }

  void _navigateToProjectDetailPage(BuildContext context, Map<String, String> project) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyProjectPage(project: project),
      ),
    );
  }
}

