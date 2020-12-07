import 'package:proto_flutter_kerahbiru/services/project_entity.dart';

class CompanyProject {
  final int id;
  final String name;

  CompanyProject(this.id, this.name);

  static CompanyProject fromEntity(CompanyProjectEntity entity) => CompanyProject(entity.id, entity.name);
}


class ProjectWorker{
  final String email;
  final String name;
  final DateTime start;
  final DateTime end;
  final ProjectWorkerStatus status;

  ProjectWorker(this.email, this.name, this.start, this.end, this.status);

  static ProjectWorker fromEntity(ProjectWorkerEntity entity) => ProjectWorker(entity.email, entity.name, entity.start, entity.end, entity.status);
}