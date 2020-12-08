import 'package:proto_flutter_kerahbiru/models/company.dart';
import 'package:proto_flutter_kerahbiru/services/company_repository.dart';
import 'package:proto_flutter_kerahbiru/services/profile_entity.dart';
import 'package:proto_flutter_kerahbiru/services/profile_repository.dart';
import 'package:proto_flutter_kerahbiru/services/project_entity.dart';

class WebClient implements ProfileRepository, CompanyRepository {
  final Duration delay;

  var mucoindoProjects = [CompanyProjectEntity(3, "Tangguh LNG")];

  var tangguhWorkers = [
    ProjectWorkerEntity("adi@email.com", "Adi", null, null, ProjectWorkerStatus.ended),
    ProjectWorkerEntity("budi@email.com", "Budi", null, null, ProjectWorkerStatus.ended),

  ];

  var dbUsers = {
    "david@email.com" : ProjectWorkerEntity("david@email.com", "David", null, null, null),
  };

  var david = ProfileEntity(
      id: 'david',
      header: HeaderEntity(
          name: 'David Rahman',
          summary: 'Project Manager\n(Construction, Infrastructure)',
          country: 'Indonesia',
          region: 'Jakarta',
          avatarUrl:
              'https://media-exp1.licdn.com/dms/image/C4E03AQEcQGn1OLMJhQ/profile-displayphoto-shrink_800_800/0?e=1610582400&v=beta&t=AEfJrWhUCr3fHHDfz-DecwjhR0TPBM4nnjCUWFFeOQM',
          backgroundUrl:
              'https://images.unsplash.com/photo-1559959656-9bcf78455c5e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80'),
      showcases: [
        ShowcaseEntity(
            url:
                'https://images.unsplash.com/photo-1507335563142-a814078ce38c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=701&q=80'),
        ShowcaseEntity(
            url:
                'https://images.unsplash.com/photo-1589939705384-5185137a7f0f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80'),
        ShowcaseEntity(
            url:
                'https://images.unsplash.com/photo-1545186070-de624ed19875?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
        ShowcaseEntity(
            url:
                'https://images.unsplash.com/photo-1563166423-482a8c14b2d6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80'),
        ShowcaseEntity(
            url:
                'https://images.unsplash.com/photo-1530639834082-05bafb67fbbe?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80'),
      ],
      about: AboutEntity(
          about:
              "Certified Project Management Professional (IAPM®), with more than 15 years of experience in oil and gas infrastructure projects.\n" +
                  "Looking forward to apply my knowledge and experience in project management and learn new techniques."),
      experiences: [
        new ExperienceEntity(
            id: 0,
            title: 'Project Manager',
            start: 1349104032,
            end: 2147483647,
            org: 'Tripatra',
            description:
                'Business Development Lead for Midstream Power & Industrial Sector\n• Diversify and grow of Tripatra revenue streams\n• Increase share of Tripatra market\n• Develop network with new business partner'),
        new ExperienceEntity(
            id: 1,
            title: 'Senior Instrumentation & Electrical Engineer',
            org: 'PT. Meindo Elang Indah',
            start: 1333292832,
            end: 1346598432,
            description:
                '• Review and check engineering subcontractor (AMEC BERCA Indonesia) product detail engineering,\n• Supervision for applicability detail engineering, procurement, construction and commissioning of this project for instrumentation & control and electrical engineering.'),
        new ExperienceEntity(
            id: 2,
            title: 'Instrumentation & Control Engineer',
            org: 'GS E&C South Korea',
            start: 1299078432,
            end: 1335971232,
            description:
                '• Review and check Instrumentation & Control subcontractor product basic design engineering, detail engineering, procurement, construction and commissioning of this project\n• Provides technical planning and general guidance for instrumentation in the execution of the project.'),
      ],
      projects: [
        new ProjectEntity(
            title: 'Senoro Gas Development Project',
            org: 'Tripatra',
            start: 1401721632,
            end: 1420211232,
            description:
                'Represents the interface & coordination between construction, commissioning and operation group activities and includes all interface checks between all systems and subsystems in EPCC Senoro Gas Development Project with value more than 500 mio USD'),
        new ProjectEntity(
            title: 'Ruby Field Development',
            org: 'PT Meido Elang Indah, TOTAL E&P Indonesie',
            start: 1335971232,
            end: 1351868832,
            description:
                'Ruby Tie In (RTI) project is part of Ruby Field Development operated by Pearl Oil Sebuku Limited (POSL). RTI will be executed by Total E&P Indonesie (TEPI) as Pearl Oil partner as well as operator for Senipah Facility. Gas maximum flowrate capacity from this block is 120 MMscfd.'),
      ],
      certifications: [
        new CertificationEntity(
          title: 'Certified International Project Manager',
          org: 'IAPM',
          dateIssued: 1533222432,
          url: 'https://cert.pmi.org/registry.aspx',
        ),
        new CertificationEntity(
          title: 'Project Management Expert',
          org: 'IAMPI',
          dateIssued: 1604329632,
          url: 'https://siki.lpjk.net/lpjknew/detail/detail_ta_kbli.php?id=3276063009830006',
        ),
      ],
      educations: [
        EducationEntity(
          title: 'Applied Physics',
          org: 'Institut Teknologi Bandung',
          start: 996764832,
          end: 1122995232,
          description: 'GPA 3.5 / 4.0',
        )
      ]);

  WebClient([this.delay = const Duration(milliseconds: 1000)]);

  @override
  Future<ProfileEntity> loadProfile() {
    return Future.delayed(delay, () => david);
  }

  @override
  void updateHeader(String profileId, HeaderEntity headerEntity) {
    Future.delayed(
        delay,
        () => this.david = ProfileEntity(
              id: profileId,
              header: headerEntity,
              showcases: david.showcases,
              experiences: david.experiences,
              projects: david.projects,
              certifications: david.certifications,
              educations: david.educations,
            ));
  }

  @override
  Future createExperience(String profileId, ExperienceEntity newExp) => Future.delayed(delay, () {
        this.david.experiences.removeWhere((element) => element.id == newExp.id);
        this.david.experiences.add(newExp);
        this.david.experiences.sort((a, b) => a.id - b.id);
      });

  @override
  Future deleteExperience(String profileId, int expId) =>
      Future.delayed(delay, () => this.david.experiences.removeWhere((element) => element.id == expId));


  @override
  Future<List<CompanyProjectEntity>> loadProjects() => Future.delayed(delay, () => this.mucoindoProjects);

  @override
  bool checkIfUserExists(String email) => dbUsers.containsKey(email);

  @override
  ProjectWorkerEntity getWorker(String email) => dbUsers[email];

  @override
  List<ProjectWorkerEntity> loadProjectWorkers() => tangguhWorkers;

  @override
  addWorker(ProjectWorkerEntity entity) {
    tangguhWorkers.removeWhere((element) => element.email == entity.email);
    tangguhWorkers.add(entity);
  }



}
