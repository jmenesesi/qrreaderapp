import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrreaderapp/models/user_location.dart';
import 'package:qrreaderapp/pages/home_page.dart';
import 'package:qrreaderapp/pages/mapa_page.dart';
import 'package:qrreaderapp/providers/location_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserLocation>(
        builder: (context) => LocationProvider().locationStream,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'QR Reader',
          initialRoute: 'home',
          routes: {
            'home': (BuildContext context) => HomePage(),
            'mapa': (BuildContext context) => MapaPage()
          },
          theme: ThemeData(primaryColor: Colors.deepPurple),
        ));
  }
}
