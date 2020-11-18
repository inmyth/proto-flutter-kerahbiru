import 'package:flutter/material.dart';
import 'package:proto_flutter_kerahbiru/models/profile.dart';
import 'package:proto_flutter_kerahbiru/models/profile_state.dart';
import 'package:proto_flutter_kerahbiru/screens/common_item_form_screen.dart';
import 'package:proto_flutter_kerahbiru/screens/keys.dart';
import 'package:proto_flutter_kerahbiru/screens/helpers.dart';

import 'package:provider/provider.dart';

class ExperienceEditScreen extends StatefulWidget {
  final String profileId;
  final List<CommonItem> expList;

  const ExperienceEditScreen({this.profileId, this.expList}) : super(key: Keys.editExperienceScreen);

  @override
  State<StatefulWidget> createState() => _ExperienceEditScreen(profileId, expList);
}

class _ExperienceEditScreen extends State<ExperienceEditScreen> {
  final String _profileId;
  final List<CommonItem> _expList;
  bool _isUpdated = false;

  _ExperienceEditScreen(this._profileId, this._expList);

  @override
  Widget build(BuildContext context) {

    return Consumer<ProfileState>(
      builder: (context, profileState, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Add new work"),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(_isUpdated),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final Map res = await Navigator.push(context, MaterialPageRoute(builder: (_) {
                return CommonItemForm();
              }));
              var newItem = new Experience(
                  id: res['id'], title: res['title'], org: res['org'], start: res['start'], end: res['end'], description: res['description']);
              _createItem(newItem);
              profileState.createExperience(_profileId, newItem);
              _isUpdated = true;
            },
            // tooltip: ArchSampleLocalizations.of(context).addTodo,
            child: const Icon(Icons.add),
          ),
          body: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              child: _getTaskListView(),
              alignment: Alignment(0.0, 0.0),
            ),
          ),
        );
      },
    );
  }

  void _removeItem(int index) {
    setState(() {
      _expList.removeAt(index);
    });
  }

  void _createItem(Experience newItem) {
    setState(() {
      _expList.add(newItem);
    });
  }

  Widget _getTaskListView() {
    return _expList.isNotEmpty
        ? ListView.builder(
            itemCount: _expList.length,
            itemBuilder: (BuildContext context, int position) {
              return _ExpCard(
                  item: this._expList[position],
                  onDelete: () {
                    Provider.of<ProfileState>(context, listen: false).deleteExperience(_profileId, this._expList[position].id);
                    _removeItem(position);
                  });
            })
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Mulai tambahkan pengalaman kerja Anda. ',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 22.0),
                textAlign: TextAlign.center,
              ),
            ],
          );
  }
}

class _ExpCard extends StatelessWidget {
  final CommonItem item;
  final VoidCallback onDelete;

  const _ExpCard({@required this.item, @required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(item.title, style: TextStyle(fontWeight: FontWeight.w600, height: 1.5, fontSize: 14.0)),
          Text(item.org, style: TextStyle(fontWeight: FontWeight.w600, height: 1.5, fontSize: 14.0)),
          Text(item.toDurationString(), style: TextStyle(fontWeight: FontWeight.w300, height: 1.5, fontSize: 14.0)),
          SizedBox(
            height: 5.0,
          ),
          Text(item.description, style: TextStyle(fontWeight: FontWeight.w300, height: 1.5, fontSize: 14.0)),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: const Text('DELETE',
                    style: TextStyle(
                      color: Colors.red,
                    )),
                onPressed: () => showConfirmDialog(
                        context, "Delete experience ?", "This item will be permanently deleted", "YES, DELETE IT", "CANCEL",
                        isRedYes: true)
                    .then((v) => v == ButtonResult.ok ? this.onDelete.call() : null),
              ),
              const SizedBox(width: 8),
              TextButton(
                child: const Text('EDIT'),
                onPressed: () {
                  /* ... */
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
        ]),
      ),
    );
  }
}
