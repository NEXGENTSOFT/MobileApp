import 'package:flutter/material.dart';
import 'package:TopoSmart/presentation/pages/signuppage.dart';
import 'package:TopoSmart/presentation/pages/homepage.dart';
import 'package:TopoSmart/presentation/pages/editprojectpage.dart';
import 'package:TopoSmart/presentation/pages/newprojectpage.dart';
import 'package:TopoSmart/presentation/pages/projectpage.dart';
import 'package:TopoSmart/presentation/pages/configurationpage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
  List<Map<String, dynamic>> projects = [];
  List<Map<String, dynamic>> filteredProjects = [];

  @override
  void initState() {
    super.initState();
    _fetchProjects();
  }

  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');

    if (userJson != null) {
      Map<String, dynamic> user = jsonDecode(userJson);
      return user['id'] != null ? int.tryParse(user['id'].toString()) : null;
    } else {
      print('No se encontraron datos del usuario.');
      return null;
    }
  }

  Future<void> _fetchProjects() async {
    print("Fetching projects...");
    int? userId = await getUserId();
    if (userId == null) {
      print('No se pudo obtener el ID del usuario.');
      return;
    }

    try {
      final response = await http.get(Uri.parse('https://servidor-toposmart.zapto.org/usersmanagement/projects/users/$userId'));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          projects = List<Map<String, dynamic>>.from(responseData['data']);
          filteredProjects = projects;
          print("Projects loaded: $projects");
        });
      } else {
        print('Failed to load projects. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception while fetching projects: $e');
    }
  }

  Future<void> _deleteProject(int projectId) async {
    int? userId = await getUserId();
    if (userId == null) {
      print('No se pudo obtener el ID del usuario.');
      return;
    }

    try {
      final url = Uri.parse('https://servidor-toposmart.zapto.org/usersmanagement/projects/users/$userId/$projectId');
      print(url);
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        setState(() {
          projects.removeWhere((project) => project['id'] == projectId);
          filteredProjects = projects;
        });
        print('Project deleted successfully');
      } else {
        print('Failed to delete project. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception while deleting project: $e');
    }
  }

  void _filterProjects(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredProjects = projects;
      } else {
        filteredProjects = projects
            .where((project) =>
        project['name'].toLowerCase().contains(query.toLowerCase()) ||
            project['description'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
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
      body: IndexedStack(
        index: _pagehome,
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Proyectos',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: letraA,
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    color: uno,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    onChanged: _filterProjects,
                    decoration: InputDecoration(
                      labelText: 'Buscar',
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: uno,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: uno),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: uno),
                      ),
                      labelStyle: TextStyle(
                        color: letraA,
                        fontFamily: 'Lato-Light',
                        fontSize: 13,
                      ),
                    ),
                    style: TextStyle(
                      color: letraA,
                      fontSize: 13,
                      fontFamily: "Lato-Light",
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                filteredProjects.isEmpty
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
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: filteredProjects.length,
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
                        filteredProjects[index]['name'],
                        style: TextStyle(
                          fontFamily: 'Lato-Bold',
                          fontSize: 18,
                          color: letraA,
                        ),
                      ),
                      subtitle: Text(
                        filteredProjects[index]['description'],
                        style: TextStyle(
                          fontFamily: 'Lato-Light',
                          fontSize: 15,
                          color: letraA,
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
                                    projectUUID: filteredProjects[index]['uuid'],
                                    name: filteredProjects[index]['name'],
                                    description: filteredProjects[index]['description'],
                                    title: 'Editar Proyecto',
                                  ),
                                ),
                              );
                              if (result != null) {
                                setState(() {
                                  projects[index] = result;
                                  filteredProjects = projects;
                                });
                              }
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Confirmar eliminación'),
                                    content: Text('¿Estás seguro de que deseas eliminar este proyecto?'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Cancelar'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text('Eliminar'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          _deleteProject(filteredProjects[index]['id']);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        _navigateToProjectDetailPage(context, filteredProjects[index]);
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
        onTap: _onNavBarTapped,
        currentIndex: _pagehome,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline, color: Colors.white),
            label: "Nueva tarea",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Colors.white),
            label: "Configuración",
          ),
        ],
        backgroundColor: colorpage,
      ),
    );
  }

  void _onNavBarTapped(int index) {
    if (index == 0) {
      _navigateToNewProjectPage(context);
    } else {
      _navigateToPerfilPage(context);
    }
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
        filteredProjects = projects;
      });
    }
  }

  Future<void> _navigateToPerfilPage(BuildContext context) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyConfigurationPage(title: ''),
      ),
    );
    if (result != null) {
      setState(() {
        projects.add(result);
        filteredProjects = projects;
      });
    }
  }

  void _navigateToProjectDetailPage(BuildContext context, Map<String, dynamic> project) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyProjectPage(
          project: {
            'id': project['id'].toString(),
            'name': project['name'].toString(),
            'description': project['description'].toString(),
          },
        ),
      ),
    );
  }
}
