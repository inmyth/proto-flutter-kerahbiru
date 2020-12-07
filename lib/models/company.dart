import 'package:proto_flutter_kerahbiru/services/project_entity.dart';

class CompanyProject {
  final int id;
  final String name;

  CompanyProject(this.id, this.name);

  static CompanyProject fromEntity(CompanyProjectEntity entity) => CompanyProject(entity.id, entity.name);
}


class ProjectUser{
  final String email;
  final String name;
  final DateTime start;
  final DateTime end;
  final ProjectUserStatus projectUserStatus;

  ProjectUser(this.email, this.name, this.start, this.end, this.projectUserStatus);

  static ProjectUser fromEntity(ProjectUserEntity entity) => ProjectUser(entity.email, entity.name, entity.start, entity.end, entity.projectUserStatus);
}