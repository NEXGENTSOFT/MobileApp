import 'package:flutter/material.dart';

class MyPoliciesPage extends StatefulWidget {
  final String title;

  const MyPoliciesPage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyPoliciesPage> createState() => _MyPoliciesPageState();
}

class _MyPoliciesPageState extends State<MyPoliciesPage> {
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
            Text(
              'Política de Privacidad',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 26,
                fontWeight: FontWeight.bold, color: letraA
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: screenHeight  ,
              width: screenWidth * 2,
              color: colorpage,
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Política de Privacidad para TopoSmart\n\n'
                          'Responsable del Tratamiento de Datos Personales:\n'
                          'NexGenSoft, hace de su conocimiento que los datos personales de usted, que actualmente o en el futuro obren en nuestra base de datos, ya sea por formar parte de nuestro grupo de clientes o ser alguno de nuestros proveedores, serán tratados y/o utilizados por: NexGenSoft, con el propósito de cumplir aquellas obligaciones que se derivan de la relación jurídica existente entre usted como titular de los datos personales y la empresa antes señalada.\n\n'
                          'Transferencia de Datos:\n'
                          'En los casos de excepción previstos en el artículo 37 de la Ley Federal de Protección de Datos Personales en Posesión de Particulares y en los artículos 18 fracción V, 21, 22, 23 y 24 de la Ley Federal para la Prevención e Identificación de Operaciones con Recursos de Procedencia Ilícita, NexGenSoft podrá transferir sus datos personales, toda vez que los productos que comercializa son considerados por esta Ley como actividades vulnerables y por tanto sujetas a dicha normatividad.\n\n'
                          'Protección y Seguridad de Datos:\n'
                          'Los datos que almacenamos en nuestra base de datos serán tratados de conformidad con la Ley Federal de Protección de Datos Personales en Posesión de los Particulares y su Reglamento. La información está garantizada y protegida por medidas de seguridad administrativas, técnicas y físicas, para evitar su daño, pérdida, alteración, destrucción, uso, acceso o divulgación indebida. Para conocer dichos procedimientos se puede poner en contacto con nosotros a través del correo electrónico nexgensoft.ids@gmail.com.\n\n'
                          'Finalidades del Tratamiento de Datos:\n'
                          'Su información será utilizada para proporcionarle un mejor servicio y, en particular, por las siguientes razones:\n\n'
                          '- Mantenimiento de registros internos y alta de clientes.\n'
                          '- Mejorar nuestros productos y servicios.\n'
                          '- Comunicarnos con usted por correo electrónico si nos ha hecho pedidos o comprado productos, ya sea acerca del pedido, la compra u otros asuntos relacionados con transacciones entre nosotros o su relación como cliente.\n'
                          '- Atender quejas y aclaraciones, y en su caso, tratarlos para fines compatibles con los mencionados en este Aviso de Privacidad y que se consideren análogos para efectos legales.\n'
                          '- Cumplir con las obligaciones derivadas de la relación jurídica formalizada con usted.\n'
                          '- Proporcionar referencias comerciales.\n'
                          '- Procesar solicitudes de crédito o financiamiento.\n\n'
                          'Datos Personales Requeridos:\n'
                          'Para las finalidades antes mencionadas, requerimos obtener los siguientes datos personales: Nombre Completo, empresa en la que labora, cargo que ocupa, correo electrónico, números telefónicos, Registro Federal de Contribuyentes, Domicilio fiscal y personal. Para procesar su solicitud de crédito o financiamiento se le puede pedir referencias personales y comerciales. No divulgaremos su información personal a terceros para sus propios propósitos de marketing.\n\n'
                          'Derechos ARCO:\n'
                          'En cualquier momento, usted podrá ejercer los derechos de acceso, rectificación, cancelación u oposición al tratamiento de sus datos, presentando su solicitud a través del correo electrónico nexgensoft.ids@gmail.com debiendo recabar el acuse de recibo correspondiente. Todas las solicitudes que sean presentadas a NexGenSoft, independientemente del medio utilizado, deberán:\n\n'
                          '- Incluir el nombre y firma autógrafa del titular, así como un domicilio u otro medio para comunicarle la respuesta a su solicitud.\n'
                          '- Acompañar los documentos oficiales que acrediten la identidad del titular.\n'
                          '- Incluir una descripción clara y precisa de los datos personales respecto de los cuales ejercerá los derechos que les confiere la Ley.\n'
                          '- Incluir cualquier elemento o documento que facilite la localización de los datos personales de que se traten.\n\n'
                          'Consentimiento Tácito:\n'
                          'Se entenderá que usted como titular consiente tácitamente el tratamiento de sus datos personales conforme a lo enunciado en el presente aviso de privacidad, cuando habiéndolo puesto a su disposición, no manifieste su oposición.\n\n'
                          'Modificaciones al Aviso de Privacidad:\n'
                          'NexGenSoft se reserva el derecho de cambiar, modificar, complementar y/o alterar el presente Aviso, en cualquier momento, en cuyo caso se hará de su conocimiento a través de cualquiera de los medios que establece la legislación en la materia.\n\n'
                          'Contacto:\n'
                          'Para cualquier duda o información adicional, puede contactarnos a través del correo electrónico nexgensoft.ids@gmail.com.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 18, color: uno),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
