import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:proto_flutter_kerahbiru/models/company.dart';
import 'package:proto_flutter_kerahbiru/models/company_state.dart';
import 'package:proto_flutter_kerahbiru/screens/project_worker_control.dart';
import 'package:proto_flutter_kerahbiru/screens/project_worker_stepper.dart';
import 'package:provider/provider.dart';

class ProjectWorkerScreen extends StatelessWidget {
  static const _fabDimension = 56.0;
  final ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  final CompanyProject project;

  const ProjectWorkerScreen({Key key, this.project}) : super(key: key);

  void _popToBack(BuildContext context) => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _popToBack(context);
        return null;
      },
      child: Consumer<CompanyState>(
        builder: (context, state, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Personnel @${project.name} '),
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back),
                onPressed: () => _popToBack(context),
              ),
            ),
            floatingActionButton: OpenContainer(
              transitionType: _transitionType,
              transitionDuration: Duration(milliseconds: 1000),
              openBuilder: (BuildContext context, VoidCallback _) => ProjectWorkerStepper(),
              onClosed: (newWorker) {
                if (newWorker != null) {
                  state.addWorker(newWorker);
                }
              },
              closedElevation: 6.0,
              closedShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(_fabDimension / 2),
                ),
              ),
              closedColor: Theme.of(context).colorScheme.secondary,
              closedBuilder: (BuildContext context, VoidCallback openContainer) {
                return SizedBox(
                  height: _fabDimension,
                  width: _fabDimension,
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                );
              },
            ),
            body: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
                alignment: Alignment(0.0, 0.0),
                child: Consumer<CompanyState>(
                  builder: (context, state, child){
                    return ListView(
                      children: state.getWorkers().map((e) => _WorkerItem(item: e, project: project,)).toList(),
                    );
                  },

                )
              ),
            ),
          );
        },
      ),
    );
  }
}

class _WorkerItem extends StatelessWidget {
  final ContainerTransitionType _transitionType = ContainerTransitionType.fadeThrough;

  final ProjectWorker item;
  final CompanyProject project;

  const _WorkerItem({this.item, this.project});

  @override
  Widget build(BuildContext context) {
    return
      Card(
      color: Colors.white,
      elevation: 2.0,
      child: OpenContainer(
        transitionType: _transitionType,
        closedColor: Theme.of(context).cardColor,
        closedElevation: 0.0,
        openElevation: 4.0,
        transitionDuration: Duration(milliseconds: 1000),
        closedBuilder: (BuildContext _, VoidCallback openContainer) {
          return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.perm_identity),
                      title: Text(item.name),
                    ),
                  ],
                ));
        },
        openBuilder: (BuildContext _, VoidCallback openContainer) =>  ProjectWorkerControl(worker: item, project: project,),
        // onClosed: (editedModel) => onItemEdited(editedModel),
      )
    );
  }
}
