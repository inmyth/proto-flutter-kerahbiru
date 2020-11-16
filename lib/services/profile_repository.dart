import 'package:proto_flutter_kerahbiru/models/profile.dart';
import 'package:proto_flutter_kerahbiru/services/profile_entity.dart';

abstract class ProfileRepository{

  Future<ProfileEntity> loadProfile();

  Future updateHeader(String profileId, HeaderEntity headerEntity);

  Future createExperience(String profileId, ExperienceEntity newExp);

  Future deleteExperience(String profileId, int expId);

}