import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:proto_flutter_kerahbiru/models/profile.dart';
import 'package:proto_flutter_kerahbiru/models/profile_state.dart';
import 'package:proto_flutter_kerahbiru/screens/app_drawer.dart';
import 'package:provider/provider.dart';

// import 'package:flutter_app/modules/AddItemOnly.dart';
// import 'package:flutter_app/widget/AppDrawer.dart';
// import 'package:flutter_app/helper/Helper.dart';

class ProfileScreen extends StatelessWidget {

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      drawer: AppDrawer(),

      body: Selector<ProfileState, bool>(
        selector: (context, model) => model.isLoading,
        builder: (context, isLoading, _) {
          if(isLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            child: Consumer<ProfileState>(
              builder: (context, profileState, child){
                return ListView(
                  children: [
                    HeadView(header: profileState.profile.header)
                  ]
                );
              }
            )
          );
        },
      ),
    );
  }
}

class HeadView extends StatelessWidget {
  final Header header;
  final double circleRadius = 100.0;

  const HeadView({this.header});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            Stack(children: <Widget>[
              Container(
                height: 250.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(header.backgroundUrl),
                        fit: BoxFit.cover)),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        top: circleRadius / 2.0,
                      ),

                      ///here we create space for the circle avatar to get ut of the box
                      child: Container(
                        height: 250.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8.0,
                              offset: Offset(0.0, 5.0),
                            ),
                          ],
                        ),
                        width: double.infinity,
                        child: Padding(
                            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: circleRadius / 2,
                                ),
                                Text(
                                  header.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 34.0),
                                ),
                                Text(
                                  'Jakarta, Indonesia',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                      color: Colors.lightBlueAccent),
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 32.0),
                                  child: Text(header.summary,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          height: 2.0,
                                          fontSize: 16.0)),
                                )
                              ],
                            )),
                      ),
                    ),

                    ///Image Avatar
                    Container(
                      width: circleRadius,
                      height: circleRadius,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8.0,
                            offset: Offset(0.0, 5.0),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Center(
                          child: Container(
                            child:             CircleAvatar(
                              backgroundImage: NetworkImage(
                                header.avatarUrl
                              ),
                              radius: 50.0,
                            ),

                            /// replace your image with the Icon
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
            SizedBox(
              height: 20.0,
            ),
          ],
        ));
  }
}

// final experiences = [
//   new ExperienceItem(
//       title: "Project Manager",
//       org: "Tripatra",
//       duration: "Oct 2012 - Present",
//       desc: "Business Development Lead for Midstream Power & Industrial Sector\n• Diversify and grow of Tripatra revenue streams\n• Increase share of Tripatra market\n• Develop network with new business partner"),
//   new ExperienceItem(
//       title: "Senior Instrumentation & Electrical Engineer",
//       org: "PT. Meindo Elang Indah",
//       duration: "Apr 2012 - Sep 2012",
//       desc: "• Review and check engineering subcontractor (AMEC BERCA Indonesia) product detail engineering,\n• Supervision for applicability detail engineering, procurement, construction and commissioning of this project for instrumentation & control and electrical engineering."),
//   new ExperienceItem(
//       title: "Instrumentation & Control Engineer",
//       org: "GS E&C South Korea",
//       duration: "Mar 2011 - May 2012",
//       desc: "• Review and check Instrumentation & Control subcontractor product basic design engineering, detail engineering, procurement, construction and commissioning of this project\n• Provides technical planning and general guidance for instrumentation in the execution of the project."),
// ];
//
// final projects = [
//   new ExperienceItem(
//       title: "Senoro Gas Development Project",
//       org: "Tripatra",
//       duration: "Jun 2014 - Jan 2015",
//       desc: "Represents the interface & coordination between construction, commissioning and operation group activities and includes all interface checks between all systems and subsystems in EPCC Senoro Gas Development Project with value more than 500 mio USD"),
//   new ExperienceItem(
//       title: "Ruby Field Development",
//       org: "PT Meido Elang Indah, TOTAL E&P Indonesie",
//       duration: "May 2012 - Nov 2012",
//       desc: "Ruby Tie In (RTI) project is part of Ruby Field Development operated by Pearl Oil Sebuku Limited (POSL). RTI will be executed by Total E&P Indonesie (TEPI) as Pearl Oil partner as well as operator for Senipah Facility. Gas maximum flowrate capacity from this block is 120 MMscfd."
//   )
// ];
//
// final educations = [
//   new ExperienceItem(
//     title: "Applied Physics",
//     org: "Institut Teknologi Bandung",
//     duration: "Aug 2001 - Aug 2005",
//     desc: "GPA 3.5 / 4.0",
//   )
// ];
//
// class Content extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
//       child: ListView(
//         children: [
//           Header(),
//           ShowcaseCarousel(),
//           About(),
//           Experience(list: experiences, title: "Experiences", isAddable: true),
//           Experience(list: projects, title: "Projects", isAddable: false),
//           Certification(),
//           Experience(list: educations, title: "Education", isAddable: false)],
//       ),
//     );
//   }
// }
//
//
//
//
//
//
//
// final List<String> imgList = [
//   'https://images.unsplash.com/photo-1507335563142-a814078ce38c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=701&q=80',
//   'https://images.unsplash.com/photo-1589939705384-5185137a7f0f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
//   'https://images.unsplash.com/photo-1545186070-de624ed19875?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
//   'https://images.unsplash.com/photo-1563166423-482a8c14b2d6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
//   'https://images.unsplash.com/photo-1530639834082-05bafb67fbbe?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80'
// ];
//
// List<Widget> buildSliders(BuildContext context, List<String> imgList) {
//   return imgList
//       .map((item) => GestureDetector(
//     onTap: (){
//       Navigator.push(context, MaterialPageRoute(builder: (_) {
//         return ShowcaseImageScreen(item);
//       }));
//     },
//
//     child: Container(
//       child: Container(
//         margin: EdgeInsets.all(5.0),
//         child: ClipRRect(
//             borderRadius: BorderRadius.all(Radius.circular(5.0)),
//             child: Stack(
//               children: <Widget>[
//                 Image.network(item, fit: BoxFit.cover, width: 1000.0),
//                 Positioned(
//                   bottom: 0.0,
//                   left: 0.0,
//                   right: 0.0,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           Color.fromARGB(200, 0, 0, 0),
//                           Color.fromARGB(0, 0, 0, 0)
//                         ],
//                         begin: Alignment.bottomCenter,
//                         end: Alignment.topCenter,
//                       ),
//                     ),
//                     padding: EdgeInsets.symmetric(
//                         vertical: 10.0, horizontal: 20.0),
//                     child: Text(
//                       'No. ${imgList.indexOf(item)} image',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 14.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             )),
//       ),
//     ),
//   ))
//       .toList();
// }
//
// class ShowcaseCarousel extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: Column(
//           children: <Widget>[
//             CarouselSlider(
//               options: CarouselOptions(
//                 autoPlay: true,
//                 aspectRatio: 2.0,
//                 enlargeCenterPage: true,
//               ),
//               items: buildSliders(context, imgList),
//             ),
//             SizedBox(
//               height: 20.0,
//             ),
//           ],
//         ));
//   }
// }
//
//
// class ShowcaseImageScreen extends StatelessWidget {
//   ShowcaseImageScreen(this.url);
//
//   final String url;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         child: Center(
//           child: Hero(
//             tag: 'imageHero',
//             child: Image.network(
//               url,
//             ),
//           ),
//         ),
//         onTap: () {
//           Navigator.pop(context);
//         },
//       ),
//     );
//   }
// }
//
// class Experience extends StatelessWidget {
//   const Experience({this.list, this.title, this.isAddable});
//
//   final List<ExperienceItem> list;
//   final String title;
//   final isAddable;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Container(
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(this.title,
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold, height: 2.0, fontSize: 24.0)),
//                   GestureDetector(
//                     child: IconButton(
//                       icon: Icon(Icons.add),
//                       tooltip: 'Add experience',
//                       onPressed: () {
//                         if(this.isAddable){
//                           Navigator.push(context, MaterialPageRoute(builder: (_) {
//                             return AddItemOnly();
//                           }));
//                         }
//                         else{
//                           Scaffold.of(context).showSnackBar(
//                               SnackBar(content: Text('Lagi dibuat')));
//                         }
//
//                       },
//                     ),
//                   ),
//                 ]
//             ),
//           ),
//           SizedBox(
//             height: 10.0,
//           ),
//           ...list,
//         ],
//       ),
//     );
//   }
// }
//
//
//
// class ExperienceItem extends StatelessWidget {
//   const ExperienceItem({this.title, this.org, this.duration, this.desc});
//
//   final String title;
//   final String org;
//   final String duration;
//   final String desc;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title,
//               style: TextStyle(
//                   fontWeight: FontWeight.w600, height: 1.5, fontSize: 14.0)),
//           Text(org,
//               style: TextStyle(
//                   fontWeight: FontWeight.w600, height: 1.5, fontSize: 14.0)),
//           Text(duration,
//               style: TextStyle(
//                   fontWeight: FontWeight.w300, height: 1.5, fontSize: 14.0)),
//           SizedBox(
//             height: 5.0,
//           ),
//           Text(desc,
//               style: TextStyle(
//                   fontWeight: FontWeight.w300, height: 1.5, fontSize: 14.0)),
//           SizedBox(
//             height: 20.0,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class About extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("Description",
//               style: TextStyle(
//                   fontWeight: FontWeight.bold, height: 2.0, fontSize: 24.0)),
//           SizedBox(
//             height: 10.0,
//           ),
//           Text(
//               "Certified Project Management Professional (IAPM®), with more than 15 years of experience in oil and gas infrastructure projects.\n" +
//                   "Looking forward to apply my knowledge and experience in project management and learn new techniques.",
//               style: TextStyle(
//                   fontWeight: FontWeight.w300, height: 1.5, fontSize: 14.0)),
//           SizedBox(
//             height: 20.0,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
// class Certification extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Container(
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text("Certifications & Qualifications",
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold, height: 2.0, fontSize: 24.0)),
//                   GestureDetector(
//                     child: IconButton(
//                       icon: Icon(Icons.add),
//                       tooltip: 'Add new item',
//                     ),
//                   ),
//                 ]
//             ),
//           ),
//           SizedBox(
//             height: 10.0,
//           ),
//           new CertificationItem(
//             title: "Certified International Project Manager",
//             org: "IAPM",
//             issued: "Aug 2018",
//             link: "https://cert.pmi.org/registry.aspx",
//           ),
//           new CertificationItem(
//             title: "Project Management Expert",
//             org: "IAMPI",
//             issued: "Nov 2020",
//             link: "https://siki.lpjk.net/lpjknew/detail/detail_ta_kbli.php?id=3276063009830006",
//           ),
//         ],
//       ),
//     );
//   }
//
// }
//
// class CertificationItem extends StatelessWidget{
//   const CertificationItem({this.title, this.org, this.issued, this.link});
//
//   final String title;
//   final String org;
//   final String issued;
//   final String link;
//
//   // Future<void> _launchInBrowser(String url) async {
//   //   if (await canLaunch(url)) {
//   //     await launch(
//   //       url,
//   //       forceSafariVC: false,
//   //       forceWebView: false,
//   //       headers: <String, String>{'my_header_key': 'my_header_value'},
//   //     );
//   //   } else {
//   //     throw 'Could not launch $url';
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title,
//               style: TextStyle(
//                   fontWeight: FontWeight.w600, height: 1.5, fontSize: 14.0)),
//           Text(org,
//               style: TextStyle(
//                   fontWeight: FontWeight.w600, height: 1.5, fontSize: 14.0)),
//           Text(issued,
//               style: TextStyle(
//                   fontWeight: FontWeight.w300, height: 1.5, fontSize: 14.0)),
//           GestureDetector(
//             child: Text("link",
//                 style: TextStyle(
//                     fontWeight: FontWeight.w300, height: 1.5, fontSize: 14.0,
//                     color: Colors.lightBlue.withOpacity(1.0)
//                 )
//
//             ),
//             onTap: (){
//               launchInBrowser(link);
//             },
//           ),
//           SizedBox(
//             height: 5.0,
//           ),
//           SizedBox(
//             height: 20.0,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//



