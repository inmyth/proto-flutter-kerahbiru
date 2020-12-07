import 'package:flutter/material.dart';
import 'package:proto_flutter_kerahbiru/screens/common_item_form_fields.dart';

class ProjectWorkerStepper extends StatefulWidget {
  final int reservedWorkerId;

  const ProjectWorkerStepper({Key key, this.reservedWorkerId}) : super(key: key);

  @override
  _ProjectWorkerStepperState createState() => _ProjectWorkerStepperState();
}

class _ProjectWorkerStepperState extends State<ProjectWorkerStepper> {

  final _stepStates = [StepState.indexed, StepState.disabled];
  final _formKeys = [
    GlobalKey<FormState>(),
    null,
  ];

  final Map _values = {'email': null, 'name': null};


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('Create a work experience'),
      ),
      body: Stepper(
        steps: [
          Step(
            title: const Text('Email'),
            state: _stepStates[0],
            content: Column(
              children: <Widget>[
                Text(
                  "Worker's email",
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0),
                  textAlign: TextAlign.start,
                ),
                Form(key: _formKeys[1], child: EmailField(initialValue: 'david@email.com', onSaved: (v) => _values['title'] = v))
              ],

            ),
          )
        ],

      ),
    );
  }
}
