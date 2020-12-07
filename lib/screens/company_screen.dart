import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:proto_flutter_kerahbiru/models/company.dart';
import 'package:proto_flutter_kerahbiru/models/company_state.dart';
import 'package:proto_flutter_kerahbiru/models/profile.dart';
import 'package:proto_flutter_kerahbiru/models/profile_state.dart';
import 'package:proto_flutter_kerahbiru/screens/app_drawer.dart';
import 'package:proto_flutter_kerahbiru/screens/common_item_edit_screen.dart';
import 'package:provider/provider.dart';
import 'package:proto_flutter_kerahbiru/screens/helpers.dart';

class CompanyScreen extends StatelessWidget {
  static const String routeName = '/company';

  final SharedAxisTransitionType _transitionType = SharedAxisTransitionType.horizontal;

  @override
  Widget build(BuildContext context) {
    return Consumer<CompanyState>(
      builder: (context, state, child) {
        return PageTransitionSwitcher(
          duration: const Duration(milliseconds: 1500),
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
          // child: state.isRootPage ? _CompanyProjects() : CommonItemEditScreen(expList: List.of(state.profile.experiences), obj: new Experience()),
          child:  _CompanyProjects(),
        );
      },
    );
  }
}

class _CompanyProjects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mucoindo Projects"),
      ),
      drawer: AppDrawer(),
      body: Selector<CompanyState, bool>(
        selector: (context, state) => state.isLoading,
        builder: (context, isLoading, _) {
          if (isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
              child: Consumer<CompanyState>(builder: (context, state, child) {
                return ListView(children: [
                  ...state.projects.map((e) => _ProjectItem(item: e)).toList()
                ]);
              }));
        },
      ),
    );
  }
}


class _ProjectItem extends StatelessWidget {
  final CompanyProject item;

  const _ProjectItem({this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.album),
              title: Text(item.name),
            ),
          ],
        )
      ),
    );
  }
}



