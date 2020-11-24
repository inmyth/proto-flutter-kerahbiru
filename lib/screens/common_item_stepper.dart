import 'package:flutter/material.dart';
import 'package:proto_flutter_kerahbiru/screens/common_item_form_fields.dart';

class CommonItemOnboarding extends StatefulWidget {
  @override
  _CommonItemOnboardingState createState() => _CommonItemOnboardingState();
}

class _CommonItemOnboardingState extends State<CommonItemOnboarding> {
  _CommonItemOnboardingState();

  final _formKeyTitle = GlobalKey<FormState>();
  final Map values = {'title': null, 'org': null, 'start': null, 'end': null, 'description': null};

  final List<StepState> stepStates = [
    StepState.indexed,
    StepState.indexed,
    StepState.indexed,
    StepState.indexed,
    StepState.indexed,
  ];
  int _currentStep = 0;
  bool _complete = false;

  _next() {
    // _currentStep + 1 != stepStates.length
    //     ? _goTo(_currentStep + 1)
    //     : setState(() => _complete = true);
    setState(() {
      if (_currentStep == 0) {
        stepStates[0] = StepState.complete;
        _currentStep = 1;
      } else if (_currentStep == 1) {
        var form = _formKeyTitle.currentState;
        if (form.validate()) {
          form.save();
          stepStates[_currentStep] = StepState.complete;
          _currentStep = 2;
        } else {
          stepStates[_currentStep] = StepState.error;
        }
      }
    });
  }

  _back() {
    if (_currentStep > 0) {
      _goTo(_currentStep - 1);
    }
  }

  _goTo(int step) {
    var x = 1;
    // setState(() {
    //   if(_currentStep == 0){
    //     stepStates[0] = StepState.complete;
    //     _currentStep = step;
    //   }
    //   else if(_currentStep > 0){
    //     var form = _formKey.currentState;
    //     if (form.validate()) {
    //       form.save();
    //       _currentStep = step;
    //     }
    //     else {
    //       stepStates[_currentStep] = StepState.error;
    //     }
    //   }
    // });
  }

/*

- 0 : index, complete
- 1,2,3 : index, editing, error
- 5 : disabled, index
- if error, disable next and goto, disable 5
- 5 starts with disable, enable when model is filled, disable when error
 */
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Create a work experience'),
        ),
        body: Stepper(
          steps: [
            Step(
              title: const Text('Start here'),
              isActive: true,
              state: stepStates[0],
              content: Column(
                children: <Widget>[
                  Text(
                    'Work experience tells the employers about you and your skill: what you did, where you did it, and when you did it.',
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            Step(
              title: const Text('Occupation'),
              isActive: true,
              state: stepStates[1],
              content: Column(
                children: <Widget>[
                  Text(
                    'Enter your occupation. It can be title, position, or duty.',
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0),
                    textAlign: TextAlign.start,
                  ),
                  Form(key: _formKeyTitle, child: TitleField(initialValue: null, onSaved: (v) => values['title'] = v))
                ],
              ),
            ),
            Step(
              title: const Text('Company'),
              isActive: true,
              state: stepStates[2],
              content: Column(
                children: <Widget>[
                  Text(
                    'Enter the company you worked for. You can also enter freelance if you worked for yourself.',
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0),
                    textAlign: TextAlign.start,
                  ),
                  TitleField(initialValue: null, onSaved: (v) => values['org'] = v)
                ],
              ),
            ),
            Step(
              title: const Text('Address'),
              isActive: true,
              state: stepStates[3],
              content: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Home Address'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Postcode'),
                  ),
                ],
              ),
            ),
            Step(
              state: StepState.error,
              title: const Text('Avatar'),
              subtitle: const Text("Error!"),
              content: Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.red,
                  )
                ],
              ),
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
                  child: const Text('NEXT', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ],
            );
          },
        ));
  }
}
