import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class MyCameraPage extends StatefulWidget {
  final String projectId;

  MyCameraPage({required this.projectId});

  @override
  _MyCameraPageState createState() => _MyCameraPageState();
}

class _MyCameraPageState extends State<MyCameraPage> {
  File? imageFile;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _openCamera();
    });
  }

  _openCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      await _uploadImage(imageFile!);
    } else {
      Navigator.of(context).pop(); // Regresa sin imagen si se cancela
    }
  }

  Future<void> _uploadImage(File image) async {
    var uuid = Uuid().v4();
    var request = http.MultipartRequest('POST', Uri.parse('https://servidor-toposmart.zapto.org/projectsmanagement/photos'));

    // Genera un nombre aleatorio para la imagen
    var imageName = '$uuid.jpg';

    request.fields.addAll({
      'requestString': '{"name":"$imageName", "projectId":"${widget.projectId}"}',
    });

    request.files.add(await http.MultipartFile.fromPath('file', image.path, filename: imageName));

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        print('Imagen subida exitosamente');
        print(await response.stream.bytesToString());
      } else {
        print('Error al subir imagen: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error al enviar la solicitud: $e');
    } finally {
      Navigator.of(context).pop(); // Regresa a la vista anterior después de la carga
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tomar Foto"),
      ),
      body: Center(
        child: imageFile == null
            ? Text("No se ha tomado ninguna foto.")
            : Image.file(imageFile!),
      ),
    );
  }
}
