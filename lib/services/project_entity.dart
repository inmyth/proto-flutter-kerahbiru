
class CompanyProjectEntity{

  final int id;
  final String name;

  CompanyProjectEntity(this.id, this.name);

}

enum ProjectWorkerStatus{
  created,
  notified,
  accepted,
  rejected,
  started,
  ended
}

class ProjectWorkerEntity{
  final String email;
  final String name;
  final DateTime start;
  final DateTime end;
  final ProjectWorkerStatus status;

  ProjectWorkerEntity(this.email, this.name, this.start, this.end, this.status);


}