import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proto_flutter_kerahbiru/models/company.dart';
import 'package:proto_flutter_kerahbiru/models/company_state.dart';
import 'package:proto_flutter_kerahbiru/models/profile.dart';
import 'package:proto_flutter_kerahbiru/models/profile_state.dart';
import 'package:proto_flutter_kerahbiru/screens/consts.dart';
import 'package:proto_flutter_kerahbiru/services/project_entity.dart';
import 'package:provider/provider.dart';

class ProjectWorkerControl extends StatefulWidget {
  final ProjectWorker worker;
  final CompanyProject project;

  const ProjectWorkerControl({Key key, this.worker, this.project}) : super(key: key);

  @override
  _ProjectWorkerControlState createState() => _ProjectWorkerControlState();
}

class _ProjectWorkerControlState extends State<ProjectWorkerControl> {

  bool _isStarted = false;
  _onStart(BuildContext context){
    if(widget.worker.email != 'david@email.com') return;
    var p = new Project(id: widget.project.id, title: widget.project.name, org: 'Mucoindo', start: DateTime.now(),
        end: new DateTime.fromMillisecondsSinceEpoch(Consts.maxInt * 1000),
        description: ''
    );

    var w =  new ProjectWorker(widget.worker.email, widget.worker.name, widget.worker.start, widget.worker.end, ProjectWorkerStatus.started);
    Provider.of<CompanyState>(context, listen: false).addWorker(w);
    Provider.of<ProfileState>(context, listen: false)..addProject(p)..loadProfile();
    setState(() {
      _isStarted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage ${widget.worker.name}'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:<Widget>[
              RaisedButton(
                color: Colors.blue,
                onPressed: (widget.worker.status != ProjectWorkerStatus.created || _isStarted)? null : () => _onStart(context),
                child: const Text('START', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
