import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';

typedef DateValue =   Function(DateTime);

class ExperienceForm extends StatelessWidget{
  final _formKey = GlobalKey<FormState>();

  final RegExp exp = new RegExp(r"([123]+)");
  final maxLength = 100;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    // Create a global key that uniquely identifies the Form widget
    // and allows validation of the form.
    //
    // Note: This is a GlobalKey<FormState>,
    // not a GlobalKey<MyCustomFormState>.
    return Scaffold(
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
                // Row(children: <Widget>[
                //   Expanded(
                //       child: TextFormField(
                //         decoration: InputDecoration(
                //             labelText: 'Start date'
                //         ),
                //         // validator: (val) => DateUtils.isValidDate(val) ? null : 'Not a valid future date',
                //       )),
                //   IconButton(
                //     icon: new Icon(Icons.add_box_outlined),
                //     tooltip: 'Start date',
                //     onPressed: (() {
                //       showPickerDate(context);
                //     }),
                //   )
                // ]),
                SizedBox(
                  height: 10,
                ),
                _StartDate(),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  minLines: 5,
                  maxLines: 8,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.description_outlined),
                    hintText: 'Describe the project ?',
                    labelText: 'Description',
                  ),
                  validator: (value) {
                    print(value);
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
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('Processing Data')));
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

}

class _StartDate extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _StartDateState();

}

class _StartDateState extends State<_StartDate>{

  DateTime _input;
  final format = new DateFormat('yyyy-m');

  void _updateInput(DateTime pickedDate){
    setState(() {
      _input = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[

      Expanded(
          child: TextFormField(
            controller: TextEditingController(text: _input != null ? format.format(_input): ''),
            decoration: InputDecoration(
                labelText: 'Start date (e.g :2016-3)'
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          )),
      IconButton(
        icon: new Icon(Icons.add_box_outlined),
        tooltip: 'Start date',
        onPressed: (() {
          showPickerDate(context, 'Start Date', (pickedDate) {
            _updateInput(pickedDate);
          });
        }),
      )
    ]);
  }

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
      }
  ).showDialog(context);
}
