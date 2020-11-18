import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    );
  } else {
    throw 'Could not launch $url';
  }
}

enum ButtonResult { ok, no }

 Future<ButtonResult> showConfirmDialog(BuildContext context, String title, String content, String okTitle, String noTitle,
    {bool isBarrierDismissible = false, bool isRedYes = false}) async {
  return showDialog<ButtonResult>(
    context: context,
    barrierDismissible: isBarrierDismissible, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(content),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(noTitle),
            onPressed: () => Navigator.pop(context, ButtonResult.no),
          ),
          FlatButton(
            child: Text(okTitle,
                style: isRedYes
                    ? TextStyle(
                        color: Colors.red,
                      )
                    : TextStyle()),
            onPressed: () => Navigator.pop(context, ButtonResult.ok),
          ),
        ],
      );
    },
  );
}


