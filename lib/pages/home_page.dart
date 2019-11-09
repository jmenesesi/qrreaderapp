import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:qrreaderapp/bloc/scans_bloc.dart';
import 'package:qrreaderapp/models/scan_model.dart';
import 'package:qrreaderapp/pages/direcciones_page.dart';
import 'package:qrreaderapp/pages/mapas_page.dart';
import 'package:qrreaderapp/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
 
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final scansBloc = new ScansBloc();

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('QR Scanner'),
         actions: <Widget>[
           IconButton(
             icon: Icon(Icons.delete_forever),
             onPressed: scansBloc.borrarTodos,
           )
         ],
       ),
       body: _callPage(currentIndex),
       bottomNavigationBar: _createBottomNavigationBar(),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
       floatingActionButton: FloatingActionButton(
         child: Icon(Icons.filter_center_focus),
         onPressed: () =>_scanQR(context),
         backgroundColor: Theme.of(context).primaryColor,
       ),
     );
   }

  _createBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (idx) {
        setState(() {
          currentIndex= idx;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Maps')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Direcciones')
        )
      ],
    );
  }

  _callPage(int pageActual) {
    switch (pageActual) {
      case 0: return MapasPage();
      case 1: return DireccionesPage();
      default: return MapasPage();
    }
  }

  _scanQR(BuildContext context) async {
  //geo:19.3328209,-99.0239552

    String futureString ="https://jmenesesi.com";
    /*
    try {
      futureString = await new QRCodeReader().scan();
    } catch (e) {
      futureString = e.toString();
    }
    print("futureString value: $futureString"); */
    if(futureString != null) {
      print("Hay información");
      final scan = ScanModel(valor: futureString);
      scansBloc.agregarScan(scan);

       final scan2 = ScanModel(valor: "geo:19.3328209,-99.0239552");
      scansBloc.agregarScan(scan2);
      /*
      if(Platform.isIOS) {
         Future.delayed(Duration(milliseconds: 750), () {
           utils.abrirScan(context, scan);
         });
      } else {
        utils.abrirScan(context, scan);
      }*/
    }
  }
}