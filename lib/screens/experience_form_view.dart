import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';
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
            _StartDateField(),
            SizedBox(
              height: 10,
            ),
            _EndDateField(isCurrentlyWorking: false),
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

class _StartDateField extends _DateField {
  const _StartDateField() : super(key: Keys.startDateField, label: 'Start Date (i.e 2016-2)', isEnabled: true);
}

class _EndDateField extends StatefulWidget {
  final bool isCurrentlyWorking;

  const _EndDateField({this.isCurrentlyWorking}) : super(key: Keys.endDateField);

  @override
  State<StatefulWidget> createState() => _EndDateFieldState(isCurrentlyWorking);
}

class _EndDateFieldState extends State<_EndDateField> {
  bool _isCurrentlyWorking;

  _EndDateFieldState(this._isCurrentlyWorking);

  void _updateCurrentlyWorking(bool newStatus) {
    setState(() {
      this._isCurrentlyWorking = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _DateField(key: Keys.endDateField, label: 'End Date', isEnabled: _isCurrentlyWorking),
        CheckboxFormField(
          title: Text('Is currently working here ?'),
          initialValue: _isCurrentlyWorking,
          onChecked: (v){
            _updateCurrentlyWorking(v);
          },
          validator: (v) {
            return null;
          },
        )
      ],
    );
  }
}

class _DateField extends StatefulWidget {
  final String label;
  final bool isEnabled;


  const _DateField({Key key, @required this.label, @required this.isEnabled}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DateFieldState();
}

class _DateFieldState extends State<_DateField> {
  final DateFormat _dateFormat = Formats.formFormat;

  @override
  initState(){
    super.initState();
  }
  DateTime _input;

  _DateFieldState();

  void _updateInput(DateTime pickedDate) {
    setState(() {
      _input = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
          child: TextFormField(
        enabled: widget.isEnabled,
        controller: TextEditingController(text: _input != null ? _dateFormat.format(_input) : ''),
        decoration: InputDecoration(
          labelText: widget.label,
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      )),
      IconButton(
        disabledColor: Colors.grey,
        icon: new Icon(Icons.add_box_outlined),
        tooltip: 'Start date',
        onPressed: widget.isEnabled == false ? null : () => showPickerDate(context, 'Start Date', (pickedDate) {
          _updateInput(pickedDate);
        }),
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
                onChanged: (newVal){
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
  Picker(
      hideHeader: true,
      adapter: DateTimePickerAdapter(type: PickerDateTimeType.kYM),
      title: Text(title),
      confirmText: 'SELECT',
      selectedTextStyle: TextStyle(color: Colors.blue),
      cancelText: 'CANCEL',
      onConfirm: (Picker picker, List value) {
        onSelected((picker.adapter as DateTimePickerAdapter).value);
        print((picker.adapter as DateTimePickerAdapter).value);
      }).showDialog(context);
}
