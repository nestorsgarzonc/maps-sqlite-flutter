import 'package:flutter/material.dart';
import 'package:qrrecognitions_maps/src/bloc/scans_bloc.dart';
import 'package:qrrecognitions_maps/src/models/scan_model.dart';

class MapsPage extends StatelessWidget {
  final scansBloc = ScansBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final scans = snapshot.data;
        if (scans.length == 0) {
          return Center(
            child: Text("No data"),
          );
        }
        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context, i) => Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.red,
            ),
            onDismissed: (direction) => scansBloc.borrarScans(scans[i].id),
            child: ListTile(
              leading: Icon(
                Icons.cloud_queue,
                color: Theme.of(context).primaryColor,
              ),
              subtitle: Text("ID: ${scans[i].id}"),
              title: Text(scans[i].valor),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
              ),
              //onTap: () {},
            ),
          ),
        );
      },
    );
  }
}
