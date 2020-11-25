import 'package:flutter/material.dart';
import 'package:proto_flutter_kerahbiru/models/profile.dart';

class CommonItemView extends StatefulWidget {
  final CommonItem item;

  const CommonItemView({Key key, this.item}) : super(key: key);

  @override
  _CommonItemViewState createState() => _CommonItemViewState();
}

class _CommonItemViewState extends State<CommonItemView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(widget.item.title, style: TextStyle(fontWeight: FontWeight.w600, height: 1.5, fontSize: 14.0)),
            Text(widget.item.org, style: TextStyle(fontWeight: FontWeight.w600, height: 1.5, fontSize: 14.0)),
            Text(widget.item.toDurationString(), style: TextStyle(fontWeight: FontWeight.w300, height: 1.5, fontSize: 14.0)),
            SizedBox(
              height: 5.0,
            ),
            Text(widget.item.description ?? '', style: TextStyle(fontWeight: FontWeight.w300, height: 1.5, fontSize: 14.0)),
      ]),
    );
  }
}
