import 'package:flutter/material.dart';
import 'package:proto_flutter_kerahbiru/screens/app_drawer.dart';
import 'package:proto_flutter_kerahbiru/screens/helpers.dart';

class CertificateScreen extends StatelessWidget {
  static const String routeName = '/certificate';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Certificate"),
      ),
      body: _Content(),
      drawer: AppDrawer(),
    );
  }
}

class _Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
      child: ListView(
        children: [
          _Header(),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Text(
              'Certified International Project Manager',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 27.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'International Association of Project Manager (IAPM)',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              'David Rahman',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              'Issued: Aug 2018',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              child: Text(
                'Verify',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.lightBlueAccent),
                textAlign: TextAlign.center,
              ),
              onTap: () {
                launchInBrowser(
                    "https://www.iapm.net/en/certification/levels-of-certification/certified-international-project-manager-iapm/");
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Description',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'This certification level is intended for project managers who want to obtain confirmation of their knowledge of international project management. In the examination, candidates have to demonstrate their knowledge in competence elements as “Projects in a globalised world”, “Phases in an international project”, “Management of an international project”, “Communication culture in international projects”, or “Cultural dimensions and their impact on the project”.',
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16.0,
                  color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ));
  }
}
