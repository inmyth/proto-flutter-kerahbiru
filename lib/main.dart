import 'package:flutter/material.dart';
import 'package:proto_flutter_kerahbiru/app.dart';
import 'package:proto_flutter_kerahbiru/services/web_client.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    App(profileRepository: WebClient(), companyRepository: WebClient())
  );
}


