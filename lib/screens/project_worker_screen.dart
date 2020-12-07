import 'package:flutter/material.dart';
import 'package:proto_flutter_kerahbiru/models/company.dart';
import 'package:proto_flutter_kerahbiru/models/company_state.dart';
import 'package:provider/provider.dart';

class ProjectWorkerScreen extends StatelessWidget {
  final CompanyProject project;

  const ProjectWorkerScreen({Key key, this.project}) : super(key: key);

  void _popToBack(BuildContext context) => null;

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
              title: Text('Workers @${project.name} '),
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back),
                onPressed: () => _popToBack(context),
              ),
            ),
            body: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
                alignment: Alignment(0.0, 0.0),
                child: Selector<CompanyState, bool>(
                  selector: (context, state) => state.isWorkerListPageLoading,
                  builder: (context, isLoading, _) {
                    if (isLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView(
                      children: state.workers.map((e) => _WorkerItem(item: e)).toList(),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _WorkerItem extends StatelessWidget {
  final ProjectWorker item;

  const _WorkerItem({this.item});

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
                leading: Icon(Icons.perm_identity),
                title: Text(item.name),
              ),
            ],
          )),
    );
  }
}
