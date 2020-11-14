import 'package:flutter/cupertino.dart';
import 'package:proto_flutter_kerahbiru/models/profile.dart';
import 'package:proto_flutter_kerahbiru/services/profile_repository.dart';

class ProfileState extends ChangeNotifier {
  final ProfileRepository repository;

  Profile profile;

  bool _isLoading = false;

  ProfileState({this.repository, this.profile});

  Future loadProfile() {
    _isLoading = true;
    notifyListeners();

    return repository.loadProfile().then((repoProfile) {
      profile = Profile.fromEntity(repoProfile);
      _isLoading = false;
      notifyListeners();
    }).catchError((err) {
      _isLoading = false;
      notifyListeners();
    });
  }
}
