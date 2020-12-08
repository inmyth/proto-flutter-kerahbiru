import 'package:flutter/material.dart';
import 'package:proto_flutter_kerahbiru/models/company.dart';
import 'package:proto_flutter_kerahbiru/services/company_repository.dart';

class CompanyState extends ChangeNotifier {
  final CompanyRepository _repository;

  bool _isProjectPageLoading;
  bool _isWorkerListPageLoading;

  List<CompanyProject> _projects;
  List<ProjectWorker> _workers;

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

  Future loadWorkers(int id) {
    _isWorkerListPageLoading = true;
    notifyListeners();

    return _repository.loadProjectUsers().then((p) {
      _workers = p.map((e) => ProjectWorker.fromEntity(e)).toList();
      _isWorkerListPageLoading = false;
      notifyListeners();
    }).catchError((err) {
      _isWorkerListPageLoading = false;
      notifyListeners();
    });
  }

  bool get isProjectPageLaoding => _isProjectPageLoading;

  bool get isWorkerListPageLoading => _isWorkerListPageLoading;

  bool checkIfUserExists(String email) => _repository.checkIfUserExists(email);

  bool checkIfUserAlreadyRegistered(String email) => _workers.indexWhere((element) => element.email == email) > -1;

  ProjectWorker getWorkerFromRepo(String email) => ProjectWorker.fromEntity(_repository.getWorker(email));

  List<CompanyProject> get projects => _projects;

  List<ProjectWorker> get workers => _workers;

  addWorker(ProjectWorker worker) {
    _workers.add(worker);
    notifyListeners();
  }
}
