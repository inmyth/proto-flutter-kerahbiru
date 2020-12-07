import 'package:proto_flutter_kerahbiru/services/project_entity.dart';

abstract class CompanyRepository {

  Future<List<CompanyProjectEntity>> loadProjects();

  Future<List<ProjectWorkerEntity>> loadProjectUsers();


}