
class CompanyProjectEntity{

  final int id;
  final String name;

  CompanyProjectEntity(this.id, this.name);

}

enum ProjectUserStatus{
  created,
  notified,
  accepted,
  rejected,
  started,
  ended
}

class ProjectUserEntity{
  final String email;
  final String name;
  final DateTime start;
  final DateTime end;
  final ProjectUserStatus projectUserStatus;

  ProjectUserEntity(this.email, this.name, this.start, this.end, this.projectUserStatus);


}