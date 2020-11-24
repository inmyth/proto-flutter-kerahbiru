import 'package:flutter/material.dart';
import 'package:proto_flutter_kerahbiru/models/profile.dart';
import 'package:proto_flutter_kerahbiru/screens/consts.dart';


class TitleField extends StatefulWidget {
  final String initialValue;
  final Function(String) onSaved;


  const TitleField({Key key, @required this.initialValue, @required this.onSaved}) : super(key: key);

  @override
  _TitleFieldState createState() => _TitleFieldState();
}

class _TitleFieldState extends State<TitleField> {
  final int _maxLength = Consts.titleMaxLength;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue ?? '',
      decoration: const InputDecoration(
        hintText: '',
        labelText: 'Occupation',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter your occupation';
        } else if (value.length > _maxLength) {
          return 'Input cannot exceed $_maxLength characters';
        }
        return null;
      },
      onSaved: widget.onSaved,
    );
  }
}

class OrgField extends StatefulWidget {
  final String initialValue;
  final Function(String) onSaved;

  const OrgField({Key key, this.initialValue, this.onSaved}) : super(key: key);

  @override
  _OrgFieldState createState() => _OrgFieldState();
}

class _OrgFieldState extends State<OrgField> {
  final int _maxLength = Consts.orgMaxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue ?? '',
      decoration: const InputDecoration(
        hintText: '',
        labelText: 'Occupation',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter your company';
        } else if (value.length > _maxLength) {
          return 'Input cannot exceed $_maxLength characters';
        }
        return null;
      },
      onSaved: widget.onSaved,
    );  }
}

