import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import 'package:qrreaderapp/providers/db_provider.dart';
import 'package:qrreaderapp/models/user_location.dart';
import 'package:latlong/latlong.dart';

class MapaPage extends StatefulWidget {

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final map = MapController();

  String tipoMapa = "streets";
  var userLocation;

  @override
  Widget build(BuildContext context) {
    userLocation = Provider.of<UserLocation>(context);
    final ScanModel scanModel = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text("Coordenadas"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.my_location),
              onPressed: () {
                map.move(scanModel.getLatLng(), 15);
              },
            )
          ],
        ),
        body: _createFlutterMap(scanModel),
        floatingActionButton: _crearBotonFlotante(context),
        );
  }

  _createFlutterMap(ScanModel scanModel) {
    return FlutterMap(
      mapController: map,
      options: MapOptions(center: scanModel.getLatLng(), zoom: 15.0),
      layers: [_crearMapa(), _crearMarcadores(scanModel)],
    );
  }

  _crearMapa() {
    return TileLayerOptions(
        urlTemplate: 'https://api.mapbox.com/v4/'
            '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
        additionalOptions: {
          'accessToken':
              'pk.eyJ1Ijoiam1lbmVzZXNpIiwiYSI6ImNrMnBvdmptaDA2bHEzZ255bWJuaXVrb2YifQ.eaUK3CosG17ZoZNh_Xqt9w',
          'id': 'mapbox.$tipoMapa' // streets, dark, light, outdoors, satellite
        });
  }

  _crearMarcadores(ScanModel scan) {
    return MarkerLayerOptions(markers: <Marker>[
      Marker(
          width: 120.0,
          height: 120.0,
          point: scan.getLatLng(),
          builder: (context) => Container(
                child: Icon(
                  Icons.location_on,
                  size: 70.0,
                  color: Theme.of(context).primaryColor,
                ),
              )),
      /*Marker(
          width: 120.0,
          height: 120.0,
          point: LatLng(userLocation.latitude, userLocation.longitude),
          builder: (context) => Container(
                child: Icon(
                  Icons.location_on,
                  size: 70.0,
                  color: Theme.of(context).primaryColor,
                ),
              ))*/
    ]);
  }

  Widget _crearBotonFlotante(BuildContext context) {
    return FloatingActionButton(
      onPressed: (){
        if(tipoMapa == 'streets') {
          tipoMapa = 'dark';
        } else if(tipoMapa == 'dark'){ 
          tipoMapa = 'light';
        } else if(tipoMapa == 'light'){ 
          tipoMapa = 'outdoors';
        } else if(tipoMapa == 'outdoors'){ 
          tipoMapa = 'satellite';
        } else {
          tipoMapa = 'streets';
        }
        this.setState(() {});
      },
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
