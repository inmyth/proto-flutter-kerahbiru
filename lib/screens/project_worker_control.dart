import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proto_flutter_kerahbiru/models/company.dart';

class ProjectWorkerControl extends StatelessWidget {
  final ProjectWorker worker;

  const ProjectWorkerControl({Key key, this.worker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage ${worker.name}'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:<Widget>[
              RaisedButton(
                color: Colors.blue,

                onPressed: null,
                child: const Text('START', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
              RaisedButton(
                color: Colors.blue,
                onPressed: null,
                child: const Text('END', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
