import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'delay.dart';
import 'dart:async';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
void main() {
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(title: 'Roadkill'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
    var mylocation = "Latitude: lat, Longitude: long";
    String latitude = "";
    String longitude = "";
    void getlocation() async{
      
      // Will update every second
      Timer.periodic(Duration(seconds: 1), (timer) async { 
      var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      var lat = position.latitude;
      var long = position.longitude;
      latitude = "$lat";
      longitude = "$long";
      setState(() {
        mylocation = "Latitude: $lat, Longitude: $long";
      });
      });

      /*
      //For Static
      var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      var lat = position.latitude;
      var long = position.longitude;
      latitude = "$lat";
      longitude = "$long";
      setState(() {
        mylocation = "Latitude: $lat | Longitude: $long";
        print(latitude);
        print(longitude);
      });*/
      
    }
    
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.network("https://i.ibb.co/z7PQcx8/111482-light-color-blurred-background-vector-1.jpg",             
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity
            ),
            Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  size: 60.0,
                  color: Color.fromARGB(255, 3, 173, 116)  ),
                SizedBox(
                  height: 30,
                ),
                Text("Your current location is",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 147, 173),
                    fontSize: 30
                  ),
                  ),
                SizedBox(height: 10,),
                Text(mylocation),
                ElevatedButton(onPressed: getlocation, child: Text("Start capturing"),
                  style:ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.pinkAccent),
                  )
                ),
                Container(
                  width: width*0.9,
                  height: height*0.5,
                  child: Flexible(
                    
                    child: FlutterMap(options: MapOptions(
                      center: latLng.LatLng(19.12,72.88),
                      zoom: 15,
                    ),
                    layers: [
                        TileLayerOptions(
                            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                            userAgentPackageName: 'com.example.app',
                        ),
                    ],),
                  ),
                ),
                SizedBox(height: 10,),
                Text("According to our database risk of roadkill is",
                style: TextStyle(fontSize: 20
                color: Color.fromARGB(255, 0, 116, 0)
                ),),
                SizedBox(height: 10,),
                Container(
                  width: width,
                  decoration: BoxDecoration(color: Color.fromARGB(255, 0, 86, 126)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text("Moderate",style: TextStyle(fontSize: 20, 
                        color: Color.fromARGB(255, 236, 240, 2),
                        fontWeight: FontWeight.bold,
                        )),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text("Recommended to maintain speed 40-55 mph",
                  style: TextStyle(
                    color: Color.fromARGB(255,255,0,0),
                    fontSize: 15,
                  ),
                  )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

