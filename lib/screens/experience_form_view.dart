import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';
import 'package:proto_flutter_kerahbiru/screens/consts.dart';
import 'package:proto_flutter_kerahbiru/screens/formats.dart';
import 'package:proto_flutter_kerahbiru/screens/keys.dart';

typedef DateValue = Function(DateTime);

class ExperienceForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final maxLength = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('New Work Experience'),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: '',
                    labelText: 'Posisi',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    } else if (value.length > maxLength) {
                      return 'Input cannot exceed 100 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: '',
                  decoration: const InputDecoration(
                    hintText: '',
                    labelText: 'Company',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    } else if (value.length > maxLength) {
                      return 'Input cannot exceed 100 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                StartEndDates(),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  minLines: 5,
                  maxLines: 8,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  validator: (value) {
                    if (value.length > maxLength) {
                      return 'Input cannot exceed 100 characters';
                    }
                    return null;
                  },
                ),
                Builder(
                  builder: (context) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false
                        // otherwise.
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, display a Snackbar.
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

// class _StartDateField extends _DateField {
//   const _StartDateField(DateTime initialValue, Function(String) validator) : super(key: Keys.startDateField, label: 'Start Date (i.e 2016-2)', isEnabled: true, initialValue: initialValue, validator: validator);
// }
//
// class _EndDateField extends StatefulWidget {
//   final bool isCurrentlyWorking;
//   final DateTime initialValue;
//   final Function(String) validator;
//
//   const _EndDateField({this.isCurrentlyWorking, this.initialValue, this.validator}) : super(key: Keys.endDateField);
//
//   @override
//   State<StatefulWidget> createState() => _EndDateFieldState(isCurrentlyWorking);
// }
//
// class _EndDateFieldState extends State<_EndDateField> {
//   bool _isCurrentlyWorking;
//
//   _EndDateFieldState(this._isCurrentlyWorking);
//
//   void _updateCurrentlyWorking(bool newStatus) {
//     setState(() {
//       this._isCurrentlyWorking = newStatus;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         _DateField(key: Keys.endDateField, label: 'End Date', isEnabled: !_isCurrentlyWorking, initialValue: widget.initialValue, validator: widget.validator,),
//         CheckboxFormField(
//           title: Text('Is currently working here ?'),
//           initialValue: _isCurrentlyWorking,
//           onChecked: (v) {
//             _updateCurrentlyWorking(v);
//           },
//           validator: (v) {
//             return null;
//           },
//         )
//       ],
//     );
//   }
// }

class StartEndDates extends StatefulWidget {
  final DateTime start;
  final DateTime end;

  const StartEndDates({Key key, this.start, this.end}) : super(key: key);

  @override
  _StartEndDatesState createState() => _StartEndDatesState();
}

class _StartEndDatesState extends State<StartEndDates> {
  _StartEndDatesState();

  DateTime _start;
  DateTime _end;
  bool _isCurrentlyWorking;

  TextEditingController _startController;
  TextEditingController _endController;
  Function(String) _startValidator;
  Function(String) _endValidator;

  @override
  void initState() {
    super.initState();
    _isCurrentlyWorking = (_end.millisecondsSinceEpoch / 1000 == Consts.maxInt) ? true : false;
    _end = (_isCurrentlyWorking || widget.end == null) ? null : widget.end;
    _startValidator = (v) {
      return null;
    };
    _endValidator = (v) {
      if (DateTime.parse(_startController.value.text).compareTo(DateTime.parse(v)) >= 0) {
        return "Start date has to be earlier than end date";
      }
      return null;
    };
  }

  // @override
  void dispose() {
    _startController.dispose();
    _endController.dispose();
    super.dispose();
  }

  void _updateCurrentlyWorking(bool newVal) {
    setState(() {
      _isCurrentlyWorking = newVal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _DateField(
          key: Keys.startDateField,
          label: 'Start Date',
          controller: _startController,
          isEnabled: true,
          initialValue: _start,
          validator: _startValidator,
        ),
        SizedBox(
          height: 10,
        ),
        _DateField(
          key: Keys.endDateField,
          label: 'End Date',
          controller: _endController,
          isEnabled: !_isCurrentlyWorking,
          initialValue: _end,
          validator: _endValidator,
        ),
        CheckboxFormField(
          title: Text('Is currently working here ?'),
          initialValue: _isCurrentlyWorking,
          onChecked: _updateCurrentlyWorking,
        )
      ],
    );
  }
}

class _DateField extends StatefulWidget {
  final String label;
  final bool isEnabled;
  final DateTime initialValue;
  final Function(String) validator;
  final TextEditingController controller;

  const _DateField(
      {Key key, @required this.label, @required this.isEnabled, @required this.initialValue, @required this.validator, @required this.controller})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DateFieldState();
}

class _DateFieldState extends State<_DateField> {
  final DateFormat _dateFormat = Formats.formFormat;
  Function onPickerPressed;
  DateTime _input;

// https://alvinalexander.com/flutter/how-to-supply-initial-value-textformfield/

  _DateFieldState();

  @override
  initState() {
    super.initState();
    _input = widget.initialValue;
    widget.controller.text = _input != null ? _dateFormat.format(_input) : '';
    onPickerPressed = widget.isEnabled == false ? null : () => showPickerDate(context, widget.label, _updateInput);
  }

  void _updateInput(DateTime pickedDate) {
    setState(() {
      _input = pickedDate;
    });
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
          child: TextFormField(
        readOnly: true,
        controller: widget.controller,
        enabled: widget.isEnabled,
        validator: widget.validator,
        decoration: InputDecoration(
          labelText: widget.label,
        ),
      )),
      IconButton(
        disabledColor: Colors.grey,
        icon: new Icon(Icons.add_box_outlined),
        tooltip: widget.label,
        onPressed: onPickerPressed,
      )
    ]);
  }
}

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField(
      {Widget title,
      @required Function(bool) onChecked,
      FormFieldSetter<bool> onSaved,
      FormFieldValidator<bool> validator,
      bool initialValue = false,
      autovalidateMode = AutovalidateMode.always})
      : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidateMode: autovalidateMode,
            builder: (FormFieldState<bool> state) {
              return CheckboxListTile(
                dense: state.hasError,
                title: title,
                value: state.value,
                onChanged: (newVal) {
                  state.didChange.call(newVal);
                  onChecked.call(newVal);
                },
                subtitle: state.hasError
                    ? Builder(
                        builder: (BuildContext context) => Text(
                          state.errorText,
                          style: TextStyle(color: Theme.of(context).errorColor),
                        ),
                      )
                    : null,
                controlAffinity: ListTileControlAffinity.leading,
              );
            });
}

showPickerDate(BuildContext context, String title, DateValue onSelected) {
  var now = new DateTime(2020, 1);
  Picker(
      hideHeader: true,
      adapter: DateTimePickerAdapter(type: PickerDateTimeType.kYM, maxValue: new DateTime(now.year, now.month - 1)),
      title: Text(title),
      confirmText: 'SELECT',
      selectedTextStyle: TextStyle(color: Colors.blue),
      cancelText: 'CANCEL',
      onConfirm: (Picker picker, List value) {
        onSelected((picker.adapter as DateTimePickerAdapter).value);
        print((picker.adapter as DateTimePickerAdapter).value);
      }).showDialog(context);
}
