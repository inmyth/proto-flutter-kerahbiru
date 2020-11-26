import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:proto_flutter_kerahbiru/models/profile.dart';
import 'package:proto_flutter_kerahbiru/models/profile_state.dart';
import 'package:proto_flutter_kerahbiru/screens/app_drawer.dart';
import 'package:proto_flutter_kerahbiru/screens/common_item_edit_screen.dart';
import 'package:provider/provider.dart';
import 'package:proto_flutter_kerahbiru/screens/helpers.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/';

  SharedAxisTransitionType _transitionType = SharedAxisTransitionType.horizontal;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileState>(
      builder: (context, state, child) {
        return Expanded(
          child: PageTransitionSwitcher(
              duration: const Duration(milliseconds: 700),
              reverse: !state.isRootPage,
              transitionBuilder: (Widget child,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,) {
                return SharedAxisTransition(
                  child: child,
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: _transitionType,
                );
              },
              child: state.isRootPage ? _ProfileMain() : CommonItemEditScreen(expList: List.of(state.profile.experiences), obj: new Experience()),
        ),);
      },
    );
  }
}

class _ProfileMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      drawer: AppDrawer(),
      body: Selector<ProfileState, bool>(
        selector: (context, state) => state.isLoading,
        builder: (context, isLoading, _) {
          if (isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
              child: Consumer<ProfileState>(builder: (context, profileState, child) {
                return ListView(children: [
                  _Head(header: profileState.profile.header),
                  _ShowcaseCarousel(showcases: profileState.profile.showcases),
                  _About(about: profileState.profile.about),
                  _Common(list: profileState.profile.experiences, title: "Experiences", isAddable: true, obj: Experience()),
                  _Common(list: profileState.profile.projects, title: "Projects", isAddable: false, obj: Project()),
                  _Certification(list: profileState.profile.certifications),
                  _Common(list: profileState.profile.educations, title: "Education", isAddable: false, obj: Education()),
                ]);
              }));
        },
      ),
    );
  }
}


class _Head extends StatelessWidget {
  final Header header;
  final double circleRadius = 100.0;

  const _Head({this.header});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            Stack(children: <Widget>[
              Container(
                height: 250.0,
                decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(header.backgroundUrl), fit: BoxFit.cover)),
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
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34.0),
                                ),
                                Text(
                                  header.toResidenceString(),
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.lightBlueAccent),
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                                  child: Text(header.summary,
                                      textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w300, height: 2.0, fontSize: 16.0)),
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
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(header.avatarUrl),
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

List<Widget> _buildSliders(BuildContext context, List<Showcase> showcases) {
  return showcases
      .map((item) =>
      GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return _ShowcaseImageScreen(item.url);
          }));
        },
        child: Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item.url, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color.fromARGB(200, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          'No. ${showcases.indexOf(item)} image',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ))
      .toList();
}

class _ShowcaseCarousel extends StatelessWidget {
  final List<Showcase> showcases;

  const _ShowcaseCarousel({Key key, this.showcases}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: <Widget>[
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
              items: _buildSliders(context, showcases),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ));
  }
}

class _ShowcaseImageScreen extends StatelessWidget {
  _ShowcaseImageScreen(this.url);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              url,
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _About extends StatelessWidget {
  final About about;

  const _About({this.about});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Description", style: TextStyle(fontWeight: FontWeight.bold, height: 2.0, fontSize: 24.0)),
          SizedBox(
            height: 10.0,
          ),
          Text(about.about, style: TextStyle(fontWeight: FontWeight.w300, height: 1.5, fontSize: 14.0)),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}

class _Common extends StatelessWidget {
  const _Common({this.list, this.title, this.isAddable, @required this.obj});

  final double _fabDimension = 56.0;
  final CommonItem obj;
  final List<CommonItem> list;
  final String title;
  final isAddable;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(this.title, style: TextStyle(fontWeight: FontWeight.bold, height: 2.0, fontSize: 24.0)),
              IconButton(
                icon: Icon(Icons.add),
                tooltip: 'Add experience',
                onPressed: () {
                  if (this.isAddable) {
                    Provider.of<ProfileState>(context, listen: false).switchPage(false, false);
                  }
                  else {
                    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Lagi dibuat')));
                  }
                },
              ),
            ]),
          ),
          SizedBox(
            height: 10.0,
          ),
          ...list.map((e) => _CommonListItem(item: e)).toList(),
        ],
      ),
    );
  }
}

class _CommonListItem extends StatelessWidget {
  final CommonItem item;

  const _CommonListItem({this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.title, style: TextStyle(fontWeight: FontWeight.w600, height: 1.5, fontSize: 14.0)),
          Text(item.org, style: TextStyle(fontWeight: FontWeight.w600, height: 1.5, fontSize: 14.0)),
          Text(item.toDurationString(), style: TextStyle(fontWeight: FontWeight.w300, height: 1.5, fontSize: 14.0)),
          SizedBox(
            height: 5.0,
          ),
          Text(item.description, style: TextStyle(fontWeight: FontWeight.w300, height: 1.5, fontSize: 14.0)),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}


class _Certification extends StatelessWidget {
  final List<Certification> list;

  const _Certification({this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Certifications & Qualifications", style: TextStyle(fontWeight: FontWeight.bold, height: 2.0, fontSize: 24.0)),
              GestureDetector(
                child: IconButton(
                  icon: Icon(Icons.add),
                  tooltip: 'Add new item',
                  onPressed: null,
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 10.0,
          ),
          ...list.map((e) => _CertificationItem(item: e)).toList(),
        ],
      ),
    );
  }
}

class _CertificationItem extends StatelessWidget {
  final Certification item;

  const _CertificationItem({this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.title, style: TextStyle(fontWeight: FontWeight.w600, height: 1.5, fontSize: 14.0)),
          Text(item.org, style: TextStyle(fontWeight: FontWeight.w600, height: 1.5, fontSize: 14.0)),
          Text(item.toDurationString(), style: TextStyle(fontWeight: FontWeight.w300, height: 1.5, fontSize: 14.0)),
          GestureDetector(
            child: Text("link", style: TextStyle(fontWeight: FontWeight.w300, height: 1.5, fontSize: 14.0, color: Colors.lightBlue.withOpacity(1.0))),
            onTap: () {
              launchInBrowser(item.url);
            },
          ),
          SizedBox(
            height: 5.0,
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
