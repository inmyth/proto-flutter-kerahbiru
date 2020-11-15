import 'package:flutter/material.dart';
import 'package:proto_flutter_kerahbiru/models/profile_state.dart';
import 'package:proto_flutter_kerahbiru/routes.dart';
import 'package:proto_flutter_kerahbiru/screens/profile_screen.dart';
import 'package:proto_flutter_kerahbiru/services/profile_repository.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget{
final ProfileRepository profileRepository;

  const App({@required this.profileRepository});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileState(repository: profileRepository)..loadProfile(),
      child: MaterialApp(
        routes: {
          Routes.profile: (context) => ProfileScreen()
        },

      )

    );
  }


}