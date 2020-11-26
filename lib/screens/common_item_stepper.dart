import 'package:flutter/material.dart';
import 'package:proto_flutter_kerahbiru/models/profile.dart';
import 'package:proto_flutter_kerahbiru/screens/common_item_form_fields.dart';
import 'package:proto_flutter_kerahbiru/screens/common_item_view.dart';

class CommonItemStepper extends StatefulWidget {
  final int reservedItemId;
  final onClosed;

  const CommonItemStepper({Key key, this.reservedItemId, this.onClosed}) : super(key: key);

  @override
  _CommonItemStepperState createState() => _CommonItemStepperState();
}

class _CommonItemStepperState extends State<CommonItemStepper> {
  _CommonItemStepperState();

  CommonItem _model;
  final Map _values = {'title': null, 'org': null, 'start': null, 'end': null, 'description': null};
  final _formKeys = [
    null,
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    null,
  ];
  final _stepStates = List<StepState>.generate(6, (index) => index != 5 ? StepState.indexed : StepState.disabled);
  int _currentStep = 0;

  _toModel() {
    setState(() {
      _model = new Experience(
          id: widget.reservedItemId,
          title: _values['title'],
          org: _values['org'],
          start: _values['start'],
          end: _values['end'],
          description: _values['description']);
    });
  }

  _next() {
    _goTo(_currentStep + 1);
  }

  _back() {
    if (_currentStep > 0) {
      _goTo(_currentStep - 1);
    }
  }

  /*
- 0 : index, complete
- 1,2,3,4 : index, editing, error
- 5 : disabled, index
- if error, disable next and goto, disable 5
- 5 starts with disable, enable when model all clear, disable when any error
 */

  _goTo(int nextStep) {
    setState(() {
      if(_currentStep == _stepStates.length - 1){
        Navigator.pop(context, _model);
      }
      var form = _formKeys[_currentStep]?.currentState;
      if (form != null) {
        if (form.validate()) {
          form.save();
          _stepStates[_currentStep] = StepState.complete;
        } else {
          _stepStates[_currentStep] = StepState.error;
          return;
        }
        if (_stepStates.getRange(1, _stepStates.length - 1).any((p) => p != StepState.complete)) {
          _stepStates.last = StepState.disabled;
        } else {
          _stepStates.last = StepState.indexed;
          _toModel();
        }
      } else {
        if (_currentStep == 0) {
          _stepStates[_currentStep] = StepState.complete;
        }
      }
      if (nextStep < _stepStates.length - 1 || (nextStep == _stepStates.length - 1 && _stepStates.last == StepState.indexed)) {
        _currentStep = nextStep;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Create a work experience'),
        ),
        body: Stepper(
          steps: [
            Step(
              title: const Text('Start'),
              isActive: true,
              state: _stepStates[0],
              content: Column(
                children: <Widget>[
                  Text(
                    'Work experience tells the employers about you and your skill.',
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            Step(
              title: const Text('Occupation'),
              isActive: true,
              state: _stepStates[1],
              content: Column(
                children: <Widget>[
                  Text(
                    'Enter your occupation. It can be your duty or position.',
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0),
                    textAlign: TextAlign.start,
                  ),
                  Form(key: _formKeys[1], child: TitleField(initialValue: null, onSaved: (v) => _values['title'] = v))
                ],
              ),
            ),
            Step(
              title: const Text('Company'),
              isActive: true,
              state: _stepStates[2],
              content: Column(
                children: <Widget>[
                  Text(
                    'Enter the company you worked for. You can also enter freelance if you worked for yourself.',
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0),
                    textAlign: TextAlign.start,
                  ),
                  Form(key: _formKeys[2], child: TitleField(initialValue: null, onSaved: (v) => _values['org'] = v))
                ],
              ),
            ),
            Step(
              title: const Text('Duration'),
              isActive: true,
              state: _stepStates[3],
              content: Column(
                children: <Widget>[
                  Text(
                    'Choose the starting date and end date of this job. If you are still working here then please mark the checkbox',
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0),
                    textAlign: TextAlign.start,
                  ),
                  Form(key: _formKeys[3], child: StartEndDates(onSavedStart: (v) => _values['start'] = v, onSavedEnd: (v) => _values['end'] = v))
                ],
              ),
            ),
            Step(
              title: const Text('Description'),
              isActive: true,
              state: _stepStates[4],
              content: Column(
                children: <Widget>[
                  Text(
                    "What was you responsibility ? How did you solve your job's problem ? What was your achievement ? Describe it here to impress your potential employer.",
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0),
                    textAlign: TextAlign.start,
                  ),
                  Form(key: _formKeys[4], child: DescriptionField(onSaved: (v) => _values['description'] = v))
                ],
              ),
            ),
            Step(
              state: _stepStates[5],
              isActive: _stepStates[5] == StepState.indexed,
              title: const Text('Review'),
              content: Column(
                children: <Widget>[
                  CommonItemView(item: _model),
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
                if (_currentStep > 0 && _currentStep < _stepStates.length - 1)
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
        ));
  }
}
