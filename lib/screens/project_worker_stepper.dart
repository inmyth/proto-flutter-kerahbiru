import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:proto_flutter_kerahbiru/models/company.dart';
import 'package:proto_flutter_kerahbiru/models/company_state.dart';
import 'package:proto_flutter_kerahbiru/screens/common_item_form_fields.dart';
import 'package:proto_flutter_kerahbiru/services/project_entity.dart';
import 'package:provider/provider.dart';

class ProjectWorkerStepper extends StatefulWidget {
  const ProjectWorkerStepper({Key key}) : super(key: key);

  @override
  _ProjectWorkerStepperState createState() => _ProjectWorkerStepperState();
}

class _ProjectWorkerStepperState extends State<ProjectWorkerStepper> {

  final _stepStates = [StepState.indexed, StepState.disabled];
  final _formKeys = [
    GlobalKey<FormState>(),
    null,
  ];

  String _email;
  ProjectWorker _worker;

  int _currentStep = 0;

  _next() {
    _goTo(_currentStep + 1);
  }

  _back() {
    if (_currentStep > 0) {
      _goTo(_currentStep - 1);
    }
  }

  _goTo(int next){
    setState(() {
      if(_currentStep == _stepStates.length - 1 && next != 0){
        Navigator.pop(context, _worker);
        return;
      }
      if(_currentStep == 0){
        var form = _formKeys.first?.currentState;
        if(form.validate()){
          form.save();
          _stepStates.first = StepState.complete;
          _stepStates.first = StepState.indexed;
          _stepStates.last = StepState.indexed;

        } else {
          _stepStates.first = StepState.error;
          _stepStates.last = StepState.disabled;
          return;
        }
      }
      _currentStep = next;
    });
  }
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
            isActive: true,
            content: Consumer<CompanyState>(
              builder: (context, state, child){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Enter the staff's email",
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0),
                      textAlign: TextAlign.start,
                    ),
                    Form(key: _formKeys[0], child: EmailField(initialValue: 'david@email.com', onSaved: (v) {
                      _email = v;
                      var repoWorker = state.getWorkerFromRepo(v);
                      _worker = new ProjectWorker(repoWorker.email, repoWorker.name, null, null, ProjectWorkerStatus.created);
                    }))
                  ],
                );
              },
            ),
          ),
          Step(
            title: const Text('Review'),
            state: _stepStates[1],
              isActive: _stepStates.last == StepState.indexed,
              content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Register this user ?",
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "$_email",
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "${_worker?.name}",
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0),
                  textAlign: TextAlign.start,
                ),

              ],
            )
          ),

        ],
        currentStep: _currentStep,
        onStepContinue: _next,
        onStepTapped: (step) => _goTo(step),
        onStepCancel: _back,
        controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
          return ButtonBar(
            children: <Widget>[
              if (_currentStep > 0)
                TextButton(
                  onPressed: onStepCancel,
                  child: const Text('BACK'),
                ),
              RaisedButton(
                color: Colors.blue,
                onPressed: onStepContinue,
                child: _currentStep < _stepStates.length - 1
                    ? const Text('NEXT', style: TextStyle(fontSize: 16, color: Colors.white))
                    : const Text('FINISH', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          );
        },
      ),
    );
  }
}
