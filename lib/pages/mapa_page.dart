import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:qrreaderapp/providers/db_provider.dart';

class MapaPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final ScanModel scanModel = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Coordenadas"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: (){},
          )
        ],
      ),
      body: _createFlutterMap(scanModel)
    );
  }

  _createFlutterMap(ScanModel scanModel) {
  
    return FlutterMap(
      options: MapOptions(
        center: scanModel.getLatLng(),
        zoom: 15.0
      ),
      layers: [
        _crearMapa(),
      ],
    );
  }

  _crearMapa() {
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken': '',
        'id': 'mapbox.outdoors' // streets, dark, light, outdoors, satellite
      }
      
    );
  }
}