import 'package:flutter/material.dart';
import 'package:proto_flutter_kerahbiru/models/company.dart';
import 'package:proto_flutter_kerahbiru/services/company_repository.dart';
import 'package:proto_flutter_kerahbiru/services/project_entity.dart';

class CompanyState extends ChangeNotifier {
  final CompanyRepository _repository;

  bool _isProjectPageLoading;

  List<CompanyProject> _projects;

  CompanyState(this._repository);

  Future loadProjects() {
    _isProjectPageLoading = true;
    notifyListeners();

    return _repository.loadProjects().then((p) {
      _projects = p.map((e) => CompanyProject.fromEntity(e)).toList();
      _isProjectPageLoading = false;
      notifyListeners();
    }).catchError((err) {
      _isProjectPageLoading = false;
      notifyListeners();
    });
  }



  List<ProjectWorker> getWorkers() => _repository.loadProjectWorkers().map((e) => ProjectWorker.fromEntity(e)).toList();

  bool get isProjectPageLoading => _isProjectPageLoading;

  bool checkIfUserExists(String email) => _repository.checkIfUserExists(email);

  bool checkIfUserAlreadyRegistered(String email) => getWorkers().indexWhere((element) => element.email == email) > -1;

  ProjectWorker getWorkerFromRepo(String email) => ProjectWorker.fromEntity(_repository.getWorker(email));

  List<CompanyProject> get projects => _projects;

  addWorker(ProjectWorker worker) {
    ProjectWorkerEntity entity = new ProjectWorkerEntity(worker.email, worker.name, worker.start, worker.end, worker.status);
    _repository.addWorker(entity);
    notifyListeners();
  }
}
