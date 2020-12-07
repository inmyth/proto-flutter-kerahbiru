import 'package:flutter/material.dart';
import 'package:proto_flutter_kerahbiru/models/company_state.dart';
import 'package:proto_flutter_kerahbiru/models/profile_state.dart';
import 'package:proto_flutter_kerahbiru/routes.dart';
import 'package:proto_flutter_kerahbiru/screens/certificate_screen.dart';
import 'package:proto_flutter_kerahbiru/screens/company_screen.dart';
import 'package:proto_flutter_kerahbiru/screens/profile_screen.dart';
import 'package:proto_flutter_kerahbiru/services/company_repository.dart';
import 'package:proto_flutter_kerahbiru/services/profile_repository.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget{
final ProfileRepository profileRepository;
final CompanyRepository companyRepository;

  const App({@required this.profileRepository, @required this.companyRepository});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileState(repository: profileRepository)..loadProfile()),
        ChangeNotifierProvider(create: (_) => CompanyState(companyRepository)..loadProjects()),
      ],
      child: MaterialApp(
        routes: {
          Routes.profile: (context) => ProfileScreen(),
          Routes.certificate: (context) => CertificateScreen(),
          Routes.company: (_) => CompanyScreen(),
        },

      )

    );
  }
}