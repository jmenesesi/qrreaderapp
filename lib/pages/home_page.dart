import 'package:flutter/material.dart';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:qrreaderapp/pages/direcciones_page.dart';
import 'package:qrreaderapp/pages/mapas_page.dart';


class HomePage extends StatefulWidget {
 
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('QR Scanner'),
         actions: <Widget>[
           IconButton(
             icon: Icon(Icons.delete_forever),
             onPressed: (){},
           )
         ],
       ),
       body: _callPage(currentIndex),
       bottomNavigationBar: _createBottomNavigationBar(),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
       floatingActionButton: FloatingActionButton(
         child: Icon(Icons.filter_center_focus),
         onPressed: _scanQR,
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

  _scanQR() async {
  //geo:19.3328209,-99.0239552

    String futureString ="";
    try {
      futureString = await new QRCodeReader().scan();
    } catch (e) {
      futureString = e.toString();
    }
    print("futureString value: $futureString");
    if(futureString != null) {
      print("Hay información");
    }
  }
}