import 'package:flutter/material.dart';
import 'package:proto_flutter_kerahbiru/models/profile.dart';
import 'package:proto_flutter_kerahbiru/screens/experience_form_view.dart';

class ExperienceEditScreen extends StatelessWidget {
  final List<ExperienceLike> expList;

  const ExperienceEditScreen({@required this.expList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new work"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) {
          return ExperienceForm();
        })),
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
  }



  Widget _getTaskListView() {
    return expList.isNotEmpty
        ? ListView.builder(
        itemCount: expList.length,
        itemBuilder: (BuildContext context, int position) {
          return _ExpCard(item: this.expList[position]);
        })
        :
        Column(
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

class _ExpCard extends StatelessWidget{
  final ExperienceLike item;

  const _ExpCard({@required this.item});


  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.title,
                  style: TextStyle(
                      fontWeight: FontWeight.w600, height: 1.5, fontSize: 14.0)),
              Text(item.org,
                  style: TextStyle(
                      fontWeight: FontWeight.w600, height: 1.5, fontSize: 14.0)),
              Text(item.toDurationString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w300, height: 1.5, fontSize: 14.0)),
              SizedBox(
                height: 5.0,
              ),
              Text(item.description,
                  style: TextStyle(
                      fontWeight: FontWeight.w300, height: 1.5, fontSize: 14.0)),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('DELETE', style: TextStyle(
                      color: Colors.red,
                    )),
                    onPressed: () {/* ... */},
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    child: const Text('EDIT'),
                    onPressed: () {/* ... */},
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ]
        ),
      ),
    );
  }


}
