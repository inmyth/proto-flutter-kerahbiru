import 'package:flutter/cupertino.dart';
import 'package:proto_flutter_kerahbiru/models/profile.dart';
import 'package:proto_flutter_kerahbiru/services/profile_repository.dart';

class ProfileState extends ChangeNotifier {
  final ProfileRepository repository;

  Profile _profile;

  bool _isLoading = false;


  ProfileState({this.repository});

  Future loadProfile() {
    _isLoading = true;
    notifyListeners();

    return repository.loadProfile().then((repoProfile) {
      _profile = Profile.fromEntity(repoProfile);
      _isLoading = false;
      notifyListeners();
    }).catchError((err) {
      _isLoading = false;
      notifyListeners();
    });
  }

  Future createExperience(String profileId, Experience experience){
    return repository.createExperience(profileId, experience.toEntity());
  }

  Future deleteExperience(String profileId, int expId) =>
    repository.deleteExperience(profileId, expId);

  bool get isLoading => _isLoading;

  Profile get profile => _profile;


}
