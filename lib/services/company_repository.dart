import 'package:proto_flutter_kerahbiru/models/company.dart';
import 'package:proto_flutter_kerahbiru/services/project_entity.dart';

abstract class CompanyRepository {

  Future<List<CompanyProjectEntity>> loadProjects();

  List<ProjectWorkerEntity> loadProjectWorkers();

  bool checkIfUserExists(String email);

  ProjectWorkerEntity getWorker(String email);

  addWorker(ProjectWorkerEntity entity);
}