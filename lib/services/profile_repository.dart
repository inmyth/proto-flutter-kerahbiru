import 'package:proto_flutter_kerahbiru/services/profile_entity.dart';

abstract class ProfileRepository{

  Future<ProfileEntity> loadProfile();

  void updateHeader(String profileId, HeaderEntity headerEntity);

  Future createExperience(String profileId, ExperienceEntity newExp);

  Future deleteExperience(String profileId, int expId);

  addProject(ProjectEntity entity);

}