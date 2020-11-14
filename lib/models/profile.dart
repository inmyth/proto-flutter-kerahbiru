import 'package:meta/meta.dart';
import 'package:proto_flutter_kerahbiru/services/profile_entity.dart';

class Profile {
  final String id;
  final Header header;
  final List<Showcase> showcase;
  final List<Experience> experiences;
  final List<Project> projects;
  final List<Certification> certifications;
  final List<Education> educations;

  Profile({@required this.id, this.header, this.showcase, this.experiences, this.projects, this.certifications, this.educations});

  static Profile fromEntity(ProfileEntity entity) {
    return Profile(
      id: entity.id,
      showcase: entity.showcase.map(Showcase.fromEntity),
      header: Header.fromEntity(entity.header),
      experiences: entity.experiences.map(Experience.fromEntity),
      projects: entity.projects.map(Project.fromEntity),
      certifications: entity.certifications.map(Certification.fromEntity),
      educations: entity.educations.map(Education.fromEntity),
    );
  }
}

class Header {
  final String avatarUrl;
  final String name;
  final String summary;
  final String backgroundUrl;

  Header({this.avatarUrl, this.name, this.summary, this.backgroundUrl});

  static Header fromEntity(HeaderEntity entity) {
    return Header(
      name: entity.name,
      avatarUrl: entity.avatarUrl,
      summary: entity.summary,
      backgroundUrl: entity.backgroundUrl
    );
  }
}

class Showcase {
  final String url;

  Showcase({this.url});

  static Showcase fromEntity(ShowcaseEntity entity) {
    return Showcase(url: entity.url);
  }
}

class Experience {
  final int id;
  final String title;
  final String org;
  final DateTime start;
  final DateTime end;
  final String description;

  Experience({@required this.id, this.title, this.org, this.start, this.end, this.description});

  static Experience fromEntity(ExperienceEntity entity) {
    return Experience(
        id: entity.id,
        title: entity.title,
        org: entity.org,
        start: new DateTime.fromMicrosecondsSinceEpoch(entity.start * 1000),
        end: new DateTime.fromMicrosecondsSinceEpoch(entity.end * 1000),
        description: entity.description);
  }
}

class Project {
  final String title;
  final String org;
  final DateTime start;
  final DateTime end;
  final String description;

  Project({this.title, this.org, this.start, this.end, this.description});

  static Project fromEntity(ProjectEntity entity) {
    return Project(
        title: entity.title,
        org: entity.org,
        start: new DateTime.fromMicrosecondsSinceEpoch(entity.start * 1000),
        end: new DateTime.fromMicrosecondsSinceEpoch(entity.end * 1000),
        description: entity.description);
  }
}

class Certification {
  final String title;
  final String org;
  final DateTime dateIssued;
  final String url;

  Certification({this.title, this.org, this.dateIssued, this.url});

  static Certification fromEntity(CertificationEntity entity) {
    return Certification(
        title: entity.title, org: entity.org, dateIssued: new DateTime.fromMicrosecondsSinceEpoch(entity.dateIssued * 1000), url: entity.url);
  }
}

class Education {
  final String title;
  final String org;
  final DateTime start;
  final DateTime end;
  final String description;

  Education({this.title, this.org, this.start, this.end, this.description});

  static Education fromEntity(EducationEntity entity) {
    return Education(
        title: entity.title,
        org: entity.org,
        start: new DateTime.fromMicrosecondsSinceEpoch(entity.start * 1000),
        end: new DateTime.fromMicrosecondsSinceEpoch(entity.end * 1000),
        description: entity.description);
  }
}
