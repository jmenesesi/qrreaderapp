import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qrreaderapp/bloc/scans_bloc.dart';
import 'package:qrreaderapp/models/scan_model.dart';
import 'package:qrreaderapp/utils/utils.dart' as utils;

class MapasPage extends StatelessWidget {
  
  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if(!snapshot.hasData) {
          return Center(child: CircularProgressIndicator(),);
        }
        final scans = snapshot.data;
        if(scans.length == 0) {
          return Center(child: Text("No hay información"),);
        }

        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context, i) => Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.delete, color: Colors.white,),
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => scansBloc.borrarScan(scans[i].id),
            child: ListTile(
              leading: Icon(Icons.cloud_queue, color: Theme.of(context).primaryColor,),
              title: Text(scans[i].valor),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
              onTap: () => utils.abrirScan(context,scans[i]),
            ),
          ),
        );
      },
    );
  }
}