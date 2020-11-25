import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';
import 'package:proto_flutter_kerahbiru/models/profile.dart';
import 'package:proto_flutter_kerahbiru/screens/common_item_form_fields.dart';
import 'package:proto_flutter_kerahbiru/screens/consts.dart';
import 'package:proto_flutter_kerahbiru/screens/formats.dart';
import 'package:proto_flutter_kerahbiru/screens/keys.dart';

class CommonItemForm extends StatelessWidget {
  final CommonItem initialModel;
  final Map _values = {'title': null, 'org': null, 'start': null, 'end': null, 'description': null};

  final _formKey = GlobalKey<FormState>();

  CommonItemForm({Key key, @required this.initialModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Work Experience'),
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
                TitleField(
                    initialValue: initialModel?.title ?? '',
                    onSaved: (v) {
                      _values['title'] = v;
                    }),
                SizedBox(
                  height: 10,
                ),
                OrgField(
                    initialValue: initialModel?.org ?? '',
                    onSaved: (v) {
                      _values['org'] = v;
                    }),
                SizedBox(
                  height: 10,
                ),
                StartEndDates(
                    initialStart: initialModel?.start,
                    initialEnd: initialModel?.end,
                    onSavedStart: (v) => _values['start'] = v,
                    onSavedEnd: (v) => _values['end'] = v),
                SizedBox(
                  height: 10,
                ),
                DescriptionField(
                    initialValue: initialModel?.description,
                    onSaved: (v) {
                      _values['description'] = v;
                    }),
                Builder(
                  builder: (context) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ButtonBar(
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.blue,
                          onPressed: () {
                            var form = _formKey.currentState;
                            if (form.validate()) {
                              form.save();
                              _values['id'] = initialModel.id;
                              var editedModel = new Experience(
                                  id: initialModel.id,
                                  title: _values['title'],
                                  org: _values['org'],
                                  start: _values['start'],
                                  end: _values['end'],
                                  description: _values['description']);
                              Navigator.pop(context, editedModel);
                            }
                          },
                          child: const Text('FINISH', style: TextStyle(fontSize: 16, color: Colors.white)),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
