import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

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
        body: Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '(*) diperlukan',
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0),
                      textAlign: TextAlign.center,

                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: '',
                        labelText: 'Posisi atau tugas',
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
                      height: 20,
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
                    RaisedButton(
                      child: Text('Picker Show Date'),
                      onPressed: () {
                        showPickerDate(context);
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'When did it start and end ?',
                        labelText: 'Duration',
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
            ))
    );
  }

}

showPickerDate(BuildContext context) {
  Picker(
      hideHeader: true,
      adapter: DateTimePickerAdapter(type: PickerDateTimeType.kYM),
      title: Text("Select Data"),
      selectedTextStyle: TextStyle(color: Colors.blue),
      onConfirm: (Picker picker, List value) {
        print((picker.adapter as DateTimePickerAdapter).value);
      }
  ).showDialog(context);
}
