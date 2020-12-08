import 'package:flutter/material.dart';
import 'package:proto_flutter_kerahbiru/models/profile.dart';
import 'package:proto_flutter_kerahbiru/services/profile_entity.dart';
import 'package:proto_flutter_kerahbiru/services/profile_repository.dart';

class ProfileState extends ChangeNotifier {
  final ProfileRepository repository;

  Profile _profile;

  bool _isLoading = false;

  bool _isRootPage = true;

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

  Future createExperience(String profileId, Experience experience) {
    return repository.createExperience(profileId, experience.toEntity());
  }

  Future deleteExperience(String profileId, int expId) =>
      repository.deleteExperience(profileId, expId);

  void switchPage(bool isRootPage, bool shouldUpdateProfile) {
    _isRootPage = isRootPage;
    if (_isRootPage && shouldUpdateProfile) {
      loadProfile();
    }
    else {
      notifyListeners();
    }
  }

  addProject(Project project) {
    repository.addProject(new ProjectEntity(project.id, title: project.title,
        org: project.org,
        start: project.start.millisecondsSinceEpoch ~/ 1000,
        end: project.end.millisecondsSinceEpoch ~/ 1000,
        description: project.description));
    notifyListeners();
  }



  bool get isLoading => _isLoading;

  Profile get profile => _profile;

  bool get isRootPage => _isRootPage;


}
