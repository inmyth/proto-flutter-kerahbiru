import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:proto_flutter_kerahbiru/models/profile.dart';
import 'package:proto_flutter_kerahbiru/models/profile_state.dart';
import 'package:proto_flutter_kerahbiru/screens/common_item_form.dart';
import 'package:proto_flutter_kerahbiru/screens/common_item_stepper.dart';
import 'package:proto_flutter_kerahbiru/screens/common_item_view.dart';
import 'package:proto_flutter_kerahbiru/screens/keys.dart';
import 'package:proto_flutter_kerahbiru/screens/helpers.dart';

import 'package:provider/provider.dart';

class CommonItemEditScreen extends StatefulWidget {
  final String profileId;
  final List<CommonItem> expList;
  final CommonItem obj;

  const CommonItemEditScreen({this.profileId, this.expList, this.obj}) : super(key: Keys.editExperienceScreen);

  @override
  State<StatefulWidget> createState() => _ExperienceEditScreen(profileId, expList);
}

class _ExperienceEditScreen extends State<CommonItemEditScreen> {
  final ContainerTransitionType _transitionType = ContainerTransitionType.fade;
  static const _fabDimension = 56.0;
  final String _profileId;
  final List<CommonItem> _expList;
  bool _isUpdated = false;
  String _title;
  String _emptyMsg;
  Function(ProfileState, int) _deleteFromState;
  Function(ProfileState, CommonItem) _createInState;

  _ExperienceEditScreen(this._profileId, this._expList);

  @override
  void initState() {
    super.initState();
    if (widget.obj is Experience) {
      _title = 'Work Experience';
      _emptyMsg = 'Add your work experience. Start getting noticed.';
      _deleteFromState = (state, position) => state.deleteExperience(_profileId, this._expList[position].id);
      _createInState = (state, item) => state.createExperience(_profileId, item);
    } else {
      _title = 'error';
      _emptyMsg = 'unknown common item type';
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _popToBack(context, _isUpdated);
        return Future.value(true);
      },
      child: Consumer<ProfileState>(
        builder: (context, profileState, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(_title),
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back),
                onPressed: () => _popToBack(context, _isUpdated),
              ),
            ),
            floatingActionButton: OpenContainer(
              transitionType: _transitionType,
              transitionDuration: Duration(milliseconds: 800),
              openBuilder: (BuildContext context, VoidCallback _) {
                int reservedItemId = _expList.isEmpty ? 0 : _expList.reduce((a, b) => a.id > b.id ? a : b).id + 1;
                return CommonItemStepper(reservedItemId: reservedItemId);
              },
              onClosed: (createdItem) {
                if (createdItem != null) {
                  _onNewItem(profileState, createdItem);
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
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                child: _buildMainView(profileState),
                alignment: Alignment(0.0, 0.0),
              ),
            ),
          );
        },
      ),
    );
  }

  void _popToBack(BuildContext context, bool isUpdated) => Navigator.of(context).pop(isUpdated);

  void onRemoved(int index) {
    setState(() {
      _expList.removeAt(index);
    });
  }

  void _onNewItem(ProfileState state, CommonItem createdItem) {
    // var newItem = _buildItem(res);
    _createInState(state, createdItem);
    _isUpdated = true;
    setState(() {
      _expList.removeWhere((element) => element.id == createdItem.id);
      _expList.add(createdItem);
      _expList.sort((a, b) => a.id - b.id);
    });
  }

  void _onEdited(ProfileState state, CommonItem editedItem, int position) {
    // var editedItem = _buildItem(res);
    _createInState(state, editedItem);
    _isUpdated = true;
    setState(() {
      _expList[position] = editedItem;
    });
  }

  Widget _buildMainView(ProfileState state) {
    return _expList.isNotEmpty
        ? ListView.builder(
            itemCount: _expList.length,
            itemBuilder: (BuildContext context, int position) {
              return _ExpCard(
                item: this._expList[position],
                onDelete: () {
                  _deleteFromState(state, position);
                  onRemoved(position);
                  _isUpdated = true;
                },
                onItemEdited: (editedModel) {
                  _onEdited(state, editedModel, position);
                },
                onOpenBuilder: () {
                  return CommonItemForm(initialModel: this._expList[position]);
                },
              );
            })
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                _emptyMsg,
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 22.0),
                textAlign: TextAlign.center,
              ),
            ],
          );
  }
}

class _ExpCard extends StatelessWidget {
  final ContainerTransitionType _transitionType = ContainerTransitionType.fade;
  final CommonItem item;
  final VoidCallback onDelete;
  final onOpenBuilder;
  final onItemEdited;

  const _ExpCard({@required this.item, @required this.onDelete, this.onOpenBuilder, this.onItemEdited});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2.0,
      child: OpenContainer(
        transitionType: _transitionType,
        closedColor: Theme.of(context).cardColor,
        closedElevation: 0.0,
        openElevation: 4.0,
        transitionDuration: Duration(milliseconds: 500),
        closedBuilder: (BuildContext _, VoidCallback openContainer) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.start, children: [
              CommonItemView(item: item),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('DELETE',
                        style: TextStyle(
                          color: Colors.red,
                        )),
                    onPressed: () =>
                        showConfirmDialog(context, 'Confirm Delete', 'This item will be permanently deleted', 'YES, DELETE IT', 'CANCEL', isRedYes: true)
                            .then((v) => v == ButtonResult.ok ? this.onDelete.call() : null),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    child: const Text('EDIT'),
                    onPressed: openContainer,
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ]),
          );
        },
        openBuilder: (BuildContext _, VoidCallback openContainer) {
          return onOpenBuilder();
        },
        onClosed: (editedModel) => onItemEdited(editedModel),

      ),
    );
  }
}
