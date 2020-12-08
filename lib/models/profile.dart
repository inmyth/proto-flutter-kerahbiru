import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:proto_flutter_kerahbiru/screens/consts.dart';
import 'package:proto_flutter_kerahbiru/screens/formats.dart';
import 'package:proto_flutter_kerahbiru/services/profile_entity.dart';

class Profile {
  final String id;
  final Header header;
  final List<Showcase> showcases;
  final About about;
  final List<Experience> experiences;
  final List<Project> projects;
  final List<Certification> certifications;
  final List<Education> educations;

  Profile({@required this.id, this.header, this.showcases, this.about, this.experiences, this.projects, this.certifications, this.educations});

  static Profile fromEntity(ProfileEntity entity) {
    return Profile(
      id: entity.id,
      showcases: entity.showcases.map(Showcase.fromEntity).toList(),
      header: Header.fromEntity(entity.header),
      about: About.fromEntity(entity.about),
      experiences: entity.experiences.map(Experience.fromEntity).toList(),
      projects: entity.projects.map(Project.fromEntity).toList(),
      certifications: entity.certifications.map(Certification.fromEntity).toList(),
      educations: entity.educations.map(Education.fromEntity).toList(),
    );
  }
}

class Header {
  final String avatarUrl;
  final String name;
  final String country;
  final String region;
  final String summary;
  final String backgroundUrl;

  Header({this.avatarUrl, this.name, this.country, this.region, this.summary, this.backgroundUrl});

  static Header fromEntity(HeaderEntity entity) {
    return Header(
        name: entity.name,
        country: entity.country,
        region: entity.region,
        avatarUrl: entity.avatarUrl,
        summary: entity.summary,
        backgroundUrl: entity.backgroundUrl);
  }

  String toResidenceString() => "$region, $country";
}

class About {
  final String about;

  About({this.about});

  static About fromEntity(AboutEntity entity) => About(about: entity.about);
}

class Showcase {
  final String url;

  Showcase({this.url});

  static Showcase fromEntity(ShowcaseEntity entity) {
    return Showcase(url: entity.url);
  }
}

abstract class CommonItem {
  final int id;
  final String title;
  final String org;
  final DateTime start;
  final DateTime end;
  final String description;
  final format = Formats.commonDateFormat;

  String toDurationString() {
    String from = format.format(start);
    String to = end.millisecondsSinceEpoch == 2147483647 * 1000 ? "present" : format.format(end);
    return "$from - $to";
  }

  CommonItem({this.id, this.title, this.org, this.start, this.end, this.description});
}

class Experience extends CommonItem {
  Experience({int id, String title, String org, DateTime start, DateTime end, String description})
      : super(id: id, title: title, org: org, start: start, end: end, description: description);

  static Experience fromEntity(ExperienceEntity entity) {
    return Experience(
        id: entity.id,
        title: entity.title,
        org: entity.org,
        start: new DateTime.fromMillisecondsSinceEpoch(entity.start * 1000),
        end: new DateTime.fromMillisecondsSinceEpoch(entity.end * 1000),
        description: entity.description);
  }

  ExperienceEntity toEntity() {
    return new ExperienceEntity(
        id: this.id,
        title: this.title,
        org: this.org,
        start: this.start.millisecondsSinceEpoch == Consts.maxInt * 1000 ? Consts.maxInt : this.start.millisecondsSinceEpoch ~/ 1000,
        end: this.end.millisecondsSinceEpoch  ~/ 1000,
        description: this.description);
  }
}

class Project extends CommonItem {
  Project({int id, String title, String org, DateTime start, DateTime end, String description})
      : super(id: id, title: title, org: org, start: start, end: end, description: description);

  static Project fromEntity(ProjectEntity entity) {
    return Project(
        id: entity.id,
        title: entity.title,
        org: entity.org,
        start: new DateTime.fromMillisecondsSinceEpoch(entity.start * 1000),
        end: new DateTime.fromMillisecondsSinceEpoch(entity.end * 1000),
        description: entity.description);
  }
}

class Certification {
  final String title;
  final String org;
  final DateTime dateIssued;
  final String url;
  final format = Formats.commonDateFormat;

  Certification({this.title, this.org, this.dateIssued, this.url});

  static Certification fromEntity(CertificationEntity entity) {
    return Certification(
        title: entity.title, org: entity.org, dateIssued: new DateTime.fromMillisecondsSinceEpoch(entity.dateIssued * 1000), url: entity.url);
  }

  String toDurationString() => format.format(dateIssued);
}

class Education extends CommonItem {
  Education({int id, String title, String org, DateTime start, DateTime end, String description})
      : super(id: id, title: title, org: org, start: start, end: end, description: description);

  static Education fromEntity(EducationEntity entity) {
    return Education(
        title: entity.title,
        org: entity.org,
        start: new DateTime.fromMillisecondsSinceEpoch(entity.start * 1000),
        end: new DateTime.fromMillisecondsSinceEpoch(entity.end * 1000),
        description: entity.description);
  }
}
