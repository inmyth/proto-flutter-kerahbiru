import 'package:flutter/material.dart';
import 'package:proto_flutter_kerahbiru/models/company.dart';
import 'package:proto_flutter_kerahbiru/services/company_repository.dart';

class CompanyState extends ChangeNotifier {
  final CompanyRepository repository;

  bool _isRootPage = true;

  bool _isLoading;

  List<CompanyProject> _projects;

  CompanyState(this.repository);


  Future loadProjects() {
    _isLoading = true;
    notifyListeners();

    return repository.loadProjects().then((p) {
      _projects = p.map((e) => CompanyProject.fromEntity(e)).toList();
      _isLoading = false;
      notifyListeners();
    }).catchError((err) {
      _isLoading = false;
      notifyListeners();
    });
  }

  bool get isLoading => _isLoading;

  bool get isRootPage => _isRootPage;

  List<CompanyProject> get projects => _projects;
}
