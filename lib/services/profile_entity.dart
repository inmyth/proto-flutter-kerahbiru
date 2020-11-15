import 'package:flutter/cupertino.dart';

class ProfileEntity {
  final String id;
  final HeaderEntity header;
  final List<ShowcaseEntity> showcases;
  final AboutEntity about;
  final List<ExperienceEntity> experiences;
  final List<ProjectEntity> projects;
  final List<CertificationEntity> certifications;
  final List<EducationEntity> educations;

  ProfileEntity({@required this.id, this.header, this.showcases, this.about, this.experiences, this.projects, this.certifications, this.educations});
}

class HeaderEntity {
  final String avatarUrl;
  final String name;
  final String country;
  final String region;
  final String summary;
  final String backgroundUrl;

  HeaderEntity({this.avatarUrl, this.name, this.country, this.region, this.summary, this.backgroundUrl});
}

class AboutEntity {
  final String about;

  AboutEntity({this.about});
}

class ShowcaseEntity {
  final String url;

  ShowcaseEntity({this.url});
}

class ExperienceEntity {
  final int id;
  final String title;
  final String org;
  final int start;
  final int end;
  final String description;

  ExperienceEntity({this.id, this.title, this.org, this.start, this.end, this.description});
}

class ProjectEntity {
  final String title;
  final String org;
  final int start;
  final int end;
  final String description;

  ProjectEntity({this.title, this.org, this.start, this.end, this.description});
}

class CertificationEntity {
  final String title;
  final String org;
  final int dateIssued;
  final String url;

  CertificationEntity({this.title, this.org, this.dateIssued, this.url});
}

class EducationEntity {
  final String title;
  final String org;
  final int start;
  final int end;
  final String description;

  EducationEntity({this.title, this.org, this.start, this.end, this.description});
}
