import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';
import 'package:proto_flutter_kerahbiru/models/profile.dart';
import 'package:proto_flutter_kerahbiru/screens/consts.dart';
import 'package:proto_flutter_kerahbiru/screens/formats.dart';
import 'package:proto_flutter_kerahbiru/screens/keys.dart';

class CommonItemForm extends StatelessWidget {
  final Map values = {'position': null, 'company': null, 'start': null, 'end': null, 'description': null};

  final _formKey = GlobalKey<FormState>();

  final maxLength = 100;

  CommonItemForm({Key key}) : super(key: key);

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
                  onSaved: (v) {
                    values['position'] = v;
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
                  onSaved: (v) {
                    values['company'] = v;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                StartEndDates(
                  start: new DateTime.now(),
                  end: new DateTime.now(),
                  values: values,
                ),
                TextFormField(
                  minLines: 5,
                  maxLines: 8,
                  decoration: const InputDecoration(
                    labelText: 'Description (optional)',
                  ),
                  validator: (value) {
                    if (value.length > maxLength) {
                      return 'Input cannot exceed 100 characters';
                    }
                    return null;
                  },
                  onSaved: (v) {
                    values['description'] = v;
                  },
                ),
                Builder(
                  builder: (context) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () {
                        var form = _formKey.currentState;
                        if (form.validate()) {
                          form.save();
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text(values.toString())));
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

class StartEndDates extends StatefulWidget {
  final DateTime start;
  final DateTime end;
  final Map values;

  const StartEndDates({Key key, this.start, this.end, this.values}) : super(key: key);

  @override
  _StartEndDatesState createState() => _StartEndDatesState();
}

class _StartEndDatesState extends State<StartEndDates> {
  _StartEndDatesState();

  DateFormat dateFormat = Formats.formDateFormat;
  bool _isCurrentlyWorking;

  TextEditingController _startController;
  TextEditingController _endController;
  Function(String) _startValidator;
  Function(String) _endValidator;
  FormFieldSetter _onSavedStart;
  FormFieldSetter _onSavedEnd;

  @override
  void initState() {
    super.initState();
    _startController = new TextEditingController();
    _endController = new TextEditingController();
    _isCurrentlyWorking = (widget.end != null && (widget.end.millisecondsSinceEpoch / 1000 == Consts.maxInt)) ? true : false;
    _startValidator = (v) {
      if (v.isEmpty) {
        return "Start Date required";
      }
      return null;
    };
    _endValidator = (v) {
      if (_isCurrentlyWorking) {
        return null;
      }
      if (v.isEmpty) {
        return "End Date required";
      }
      if (dateFormat.parse(_startController.value.text).compareTo(dateFormat.parse(v)) >= 0) {
        return "End data has to be later than start date";
      }
      return null;
    };

    _onSavedStart = (v) {
      widget.values['start'] = dateFormat.parse(v);
    };

    _onSavedEnd = (v) {
      widget.values['end'] = _isCurrentlyWorking ? DateTime.fromMillisecondsSinceEpoch(Consts.maxInt * 1000) : dateFormat.parse(v);
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
          initialValue: widget.start,
          onSaved: _onSavedStart,
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
          initialValue: widget.end,
          onSaved: _onSavedEnd,
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
  final FormFieldSetter onSaved;

  const _DateField(
      {Key key,
      @required this.label,
      @required this.isEnabled,
      @required this.initialValue,
      @required this.validator,
      @required this.controller,
      @required this.onSaved})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DateFieldState();
}

class _DateFieldState extends State<_DateField> {
  final DateFormat _dateFormat = Formats.formDateFormat;
  final _now = DateTime.now();
  DateTime _input;

  _DateFieldState();

  @override
  initState() {
    super.initState();
    _input = widget.initialValue;
    _initController(_input);
  }

  void _updateInput(DateTime pickedDate) {
    setState(() {
      _input = pickedDate;
      _initController(_input);
    });
  }

  void _initController(DateTime input) => widget.controller.text = input != null ? _dateFormat.format(input) : '';

  // @override
  // void dispose() {
  //   widget.controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
          child: TextFormField(
        readOnly: true,
        onTap: widget.isEnabled ? () => _showPickerDate(context, widget.label, _now, _updateInput) : null,
        controller: widget.controller,
        enabled: widget.isEnabled,
        validator: widget.validator,
        decoration: InputDecoration(
          labelText: widget.label,
        ),
        onSaved: widget.onSaved,
      )),
      IconButton(
        disabledColor: Colors.grey,
        icon: new Icon(Icons.add_box_outlined),
        tooltip: widget.label,
        onPressed: widget.isEnabled ? () => _showPickerDate(context, widget.label, _now, _updateInput) : null,
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

_showPickerDate(BuildContext context, String title, DateTime now, Function(DateTime) onSelected) {
  Picker(
      hideHeader: true,
      adapter: DateTimePickerAdapter(type: PickerDateTimeType.kYM, maxValue: new DateTime(now.year, now.month - 1)),
      title: Text(title),
      confirmText: 'SELECT',
      selectedTextStyle: TextStyle(color: Colors.blue),
      cancelText: 'CANCEL',
      onConfirm: (Picker picker, List value) {
        onSelected((picker.adapter as DateTimePickerAdapter).value);
      }).showDialog(context);
}