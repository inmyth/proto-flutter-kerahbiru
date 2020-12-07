import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:proto_flutter_kerahbiru/models/company.dart';
import 'package:proto_flutter_kerahbiru/models/company_state.dart';
import 'package:proto_flutter_kerahbiru/models/profile.dart';
import 'package:proto_flutter_kerahbiru/models/profile_state.dart';
import 'package:proto_flutter_kerahbiru/screens/app_drawer.dart';
import 'package:proto_flutter_kerahbiru/screens/common_item_edit_screen.dart';
import 'package:proto_flutter_kerahbiru/screens/project_worker_screen.dart';
import 'package:provider/provider.dart';
import 'package:proto_flutter_kerahbiru/screens/helpers.dart';

class CompanyScreen extends StatelessWidget {
  static const String routeName = '/company';

  @override
  Widget build(BuildContext context) {
    return Consumer<CompanyState>(
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Mucoindo Projects"),
          ),
          drawer: AppDrawer(),
          body: Selector<CompanyState, bool>(
            selector: (context, state) => state.isProjectPageLaoding,
            builder: (context, isLoading, _) {
              if (isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                  child: Consumer<CompanyState>(builder: (context, state, child) {
                    return ListView(children: state.projects.map((e) => _ProjectItem(item: e)).toList());
                  }));
            },
          ),
        );
        ;
      },
    );
  }
}

class _ProjectItem extends StatelessWidget {
  final ContainerTransitionType _transitionType = ContainerTransitionType.fadeThrough;

  final CompanyProject item;

  const _ProjectItem({this.item});

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionType: _transitionType,
      closedColor: Theme.of(context).cardColor,
      closedElevation: 0.0,
      openElevation: 4.0,
      transitionDuration: Duration(milliseconds: 1500),
      openBuilder: (BuildContext context, VoidCallback _) {
        Provider.of<CompanyState>(context, listen: false).loadWorkers(item.id);
        return ProjectWorkerScreen(project: item);
      },
      onClosed: null,
      closedBuilder: (BuildContext _, VoidCallback openContainer) {
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
              )),
        );
      },
    );
  }
}
